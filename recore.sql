create user if not exists 'repl' identified by 'repl_password';
grant replication slave on *.* to 'repl'@'%';
flush privileges;

drop schema if exists `recore`;
create schema if not exists `recore`;

create table recore.users
(
	id char(36) not null,
	user_id int auto_increment comment 'Display field',
	first_name varchar(100) null,
	last_name varchar(100) null,
	created datetime default NOW() not null,
	modified datetime default NOW() null,
	constraint users_pk
		primary key (id),
	constraint users_uniq
		unique (user_id)
);

INSERT INTO recore.users (id, user_id, first_name, last_name, created, modified)
VALUES ('5edba4be-b7b8-451b-8c63-018cc0a88004', 1, 'Yvette', 'Marshall', '2020-06-06 14:14:22', '2020-06-06 14:14:22');
INSERT INTO recore.users (id, user_id, first_name, last_name, created, modified)
VALUES ('5edba61e-1d6c-4483-a777-01b0c0a88004', 2, 'Reece', 'Carter', '2020-06-06 14:20:14', '2020-06-06 14:20:14');
INSERT INTO recore.users (id, user_id, first_name, last_name, created, modified)
VALUES ('5edba620-8ea8-4791-8d5b-01bcc0a88004', 3, 'Jasmine', 'Robinson', '2020-06-06 14:20:16', '2020-06-06 14:20:16');
INSERT INTO recore.users (id, user_id, first_name, last_name, created, modified)
VALUES ('5edba621-eff8-4481-b980-01c8c0a88004', 4, 'Claire', 'Russell', '2020-06-06 14:20:17', '2020-06-06 14:20:17');
