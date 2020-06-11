.PHONY: install

install:
	docker-compose up \
		--build \
		--detach
	docker exec -it -u $$(id -u) web composer install

seed:
	pv core.sql | docker exec -i db_core mysql --user=root --password=password
	pv recore.sql | docker exec -i db_recore mysql --user=root --password=password

core-logs:
	docker exec -t db_core bash -c "tail -fn100 /var/log/mysql/mysql.log"

recore-logs:
	docker exec -t db_recore bash -c "tail -fn100 /var/log/mysql/mysql.log"

start:
	docker-compose up --remove-orphans

down:
	docker-compose down --remove-orphans
	docker volume rm --force mysql-cross-database-replication-cakephp_db-main-data
	docker volume rm --force mysql-cross-database-replication-cakephp_db-new-data
	docker volume rm --force mysql-cross-database-replication-cakephp_db-main-logs
	docker volume rm --force mysql-cross-database-replication-cakephp_db-new-logs

shell:
	docker exec -it -u $$(id -u) web bash
