#!/usr/bin/env bash
STEP=$(
    whiptail --title "Replication Tutorial" --radiolist \
    "Which step do you want to perform?" 14 67 7 \
    "1" "Import core and recore data" ON \
    "2" "Perform master dump in recore" OFF \
    "3" "Import master dump into core" OFF \
    "4" "CHANGE MASTER and start replication" OFF \
    "5" "SHOW SLAVE STATUS in core" OFF \
    "6" "Import new record into core" OFF \
    "7" "Import new record into recore and see it replicated" OFF \
    3>&1 1>&2 2>&3
)

if [ -z "$STEP" ]; then
    exit
fi

if [ "$STEP" -eq "1" ]; then # Import core and recore data
    pv core.sql | docker exec \
        --interactive \
        db_core \
        mysql \
        --user=root \
        --password=password

    pv recore.sql | docker exec \
        --interactive \
        db_recore \
        mysql \
        --user=root \
        --password=password
    
    echo ''
    read -n 1 -s -r -p "Press any key to continue"
    clear
    bash tutorial.sh
elif [ "$STEP" -eq "2" ]; then # Perform master dump in recore
    cat <<-"SH" | docker exec -i db_recore bash > master.sql
mysqldump \
    --master-data \
    --user=root \
    --password=password \
    --databases recore
SH

    echo ''
    read -n 1 -s -r -p "Press any key to continue"
    clear
    bash tutorial.sh
elif [ "$STEP" -eq "3" ]; then # Import master dump into core
    pv master.sql | docker exec \
        --interactive \
        db_core \
        mysql \
        --user=root \
        --password=password \
        2>/dev/null

    echo ''
    read -n 1 -s -r -p "Press any key to continue"
    clear
    bash tutorial.sh
elif [ "$STEP" -eq "4" ]; then # CHANGE MASTER and start replication
    cat <<-SQL | docker exec -i \
    db_core \
    mysql \
    --user=root \
    --password=password
CHANGE MASTER TO
    MASTER_HOST = 'db_recore',
    MASTER_USER = 'repl',
    MASTER_PASSWORD = 'repl_password',
    MASTER_LOG_FILE = '$(
        docker exec --interactive \
            db_recore \
            mysql \
            --user=root \
            --password=password \
            --execute="SHOW MASTER STATUS\G;" \
            2>/dev/null \
            | grep 'File: ' \
            | awk '{print $2}'
    )',
    MASTER_LOG_POS = $(
        docker exec --interactive \
            db_recore \
            mysql \
            --user=root \
            --password=password \
            --execute="SHOW MASTER STATUS\G;" \
            2>/dev/null \
            | grep 'Position: ' \
            | awk '{print $2}'
    );
START SLAVE;
SQL

    echo ''
    read -n 1 -s -r -p "Press any key to continue"
    clear
    bash tutorial.sh
elif [ "$STEP" -eq "5" ]; then
    cat <<-"SQL" | docker exec -i \
        db_core \
        mysql \
        --user=root \
        --password=password
SHOW SLAVE STATUS\G;
SQL

    echo ''
    read -n 1 -s -r -p "Press any key to continue"
    clear
    bash tutorial.sh
elif [ "$STEP" -eq "6" ]; then
    cat <<-"SH" | docker exec -i web bash
./Vendor/bin/cake App newNote
SH
    
    cat <<-SQL | docker exec -i \
        db_core \
        mysql \
        --user=root \
        --password=password \
        recore
SELECT * FROM users ORDER BY user_id DESC LIMIT 2\G;
SQL

    echo ''
    read -n 1 -s -r -p "Press any key to continue"
    bash tutorial.sh
elif [ "$STEP" -eq "7" ]; then
    cat <<-"SH" | docker exec -i web bash
./Vendor/bin/cake App newUser
SH

    echo ''
    read -n 1 -s -r -p "Show last 2 users in core instance"

    cat <<-SQL | docker exec -i \
        db_core \
        mysql \
        --user=root \
        --password=password \
        recore
SELECT * FROM users ORDER BY user_id DESC LIMIT 2\G;
SQL

    echo ''
    read -n 1 -s -r -p "Same query but in recore (master)"

    cat <<-SQL | docker exec -i \
        db_recore \
        mysql \
        --user=root \
        --password=password \
        recore
SELECT * FROM users ORDER BY user_id DESC LIMIT 2\G;
SQL



    echo ''
    read -n 1 -s -r -p "Press any key to continue"
    clear
    bash tutorial.sh
else
    echo "unknown option"
fi
