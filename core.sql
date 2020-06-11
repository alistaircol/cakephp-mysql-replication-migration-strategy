drop schema if exists `core`;
create schema if not exists `core`;

create table core.notes
(
	id char(36) not null,
	note_id int auto_increment comment 'Display ID',
	content text null,
	user_id char(36) not null comment 'Author',
	created datetime default NOW() null,
	updated datetime default NOW() null,
	pinned datetime default NULL null,
	constraint notes_pk
		primary key (id),
	constraint notes_uniq
		unique (note_id)
);

INSERT INTO core.notes (id, note_id, content, user_id, created, updated, pinned)
VALUES ('5edba6ad-566c-46a9-ab0e-0270c0a88004', 1, 'molestiae dolores nemo aliquam velit unde error perferendis minus officia ut tenetur vitae veniam eveniet eveniet quas', '5edba620-8ea8-4791-8d5b-01bcc0a88004', '2020-06-06 14:22:37', '2020-06-06 14:22:37', null);
INSERT INTO core.notes (id, note_id, content, user_id, created, updated, pinned)
VALUES ('5edba6bf-99c4-4ac2-9953-027cc0a88004', 2, 'sapiente sunt rerum error aliquid veritatis harum sint maiores quo iusto', '5edba621-eff8-4481-b980-01c8c0a88004', '2020-06-06 14:22:55', '2020-06-06 14:22:55', null);
INSERT INTO core.notes (id, note_id, content, user_id, created, updated, pinned)
VALUES ('5edba6c0-402c-4c4f-a9bc-0288c0a88004', 3, 'et quia laboriosam in non recusandae cum enim adipisci molestiae aut est eius culpa qui perferendis distinctio qui aliquid inventore', '5edba620-8ea8-4791-8d5b-01bcc0a88004', '2020-06-06 14:22:56', '2020-06-06 14:22:56', null);
INSERT INTO core.notes (id, note_id, content, user_id, created, updated, pinned)
VALUES ('5edba6c0-0a20-4bbf-acb9-0294c0a88004', 4, 'id ipsam facere aut quibusdam nemo consequatur velit recusandae et', '5edba61e-1d6c-4483-a777-01b0c0a88004', '2020-06-06 14:22:56', '2020-06-06 14:22:56', null);
INSERT INTO core.notes (id, note_id, content, user_id, created, updated, pinned)
VALUES ('5edba6c1-5698-430a-8f51-02a0c0a88004', 5, 'quibusdam vitae est vero beatae recusandae molestiae ex ad nihil cupiditate neque earum quisquam blanditiis dolor qui reiciendis qui vero', '5edba620-8ea8-4791-8d5b-01bcc0a88004', '2020-06-06 14:22:57', '2020-06-06 14:22:57', null);
INSERT INTO core.notes (id, note_id, content, user_id, created, updated, pinned)
VALUES ('5edba6c1-9f30-4132-bc5e-02acc0a88004', 6, 'sunt enim dicta sequi quibusdam esse omnis provident quia quod neque ad quos officiis ut quae aut nihil nemo in', '5edba621-eff8-4481-b980-01c8c0a88004', '2020-06-06 14:22:57', '2020-06-06 14:22:57', null);
INSERT INTO core.notes (id, note_id, content, user_id, created, updated, pinned)
VALUES ('5edba6c1-2b9c-4318-94b4-02b8c0a88004', 7, 'nam officiis animi est sed laboriosam velit autem qui nam iure voluptates totam dignissimos ipsa', '5edba4be-b7b8-451b-8c63-018cc0a88004', '2020-06-06 14:22:57', '2020-06-06 14:22:57', null);
INSERT INTO core.notes (id, note_id, content, user_id, created, updated, pinned)
VALUES ('5edba6c2-4a60-4e03-abf2-02c4c0a88004', 8, 'est quos numquam ipsum est et numquam velit dicta voluptatem molestiae', '5edba620-8ea8-4791-8d5b-01bcc0a88004', '2020-06-06 14:22:58', '2020-06-06 14:22:58', null);
INSERT INTO core.notes (id, note_id, content, user_id, created, updated, pinned)
VALUES ('5edba6c2-f1a0-445e-8f6d-02d0c0a88004', 9, 'eos nihil ut nesciunt et excepturi alias quisquam ea distinctio libero laborum quis fuga', '5edba4be-b7b8-451b-8c63-018cc0a88004', '2020-06-06 14:22:58', '2020-06-06 14:22:58', null);
INSERT INTO core.notes (id, note_id, content, user_id, created, updated, pinned)
VALUES ('5edba6c2-c3a4-4d63-abb0-02dcc0a88004', 10, 'quas et quae suscipit mollitia id quasi ea vero quia et quibusdam tenetur autem ea inventore aliquid quis quia', '5edba61e-1d6c-4483-a777-01b0c0a88004', '2020-06-06 14:22:58', '2020-06-06 14:22:58', null);
