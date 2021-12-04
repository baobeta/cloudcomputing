CREATE DATABASE dkmh CHARACTER SET utf8mb4 COLLATE utf8mb4_vietnamese_ci;

use dkmh;

SET NAMES utf8mb4;


create table persistent_logins
(
    username  varchar(64)                           not null,
    series    varchar(64)                           not null
        primary key,
    token     varchar(64)                           not null,
    last_used timestamp default current_timestamp() not null on update current_timestamp()
);

create table roles
(
    id          int auto_increment
        primary key,
    description varchar(400) not null,
    name        varchar(40)  not null,
    constraint UK_ofx66keruapi6vyqpv6f2or37
        unique (name)
);

create table subjects
(
    id               int auto_increment
        primary key,
    category_subject varchar(128) not null,
    name_subject     varchar(128) not null,
    total_credits    int          null
);

create table users
(
    id       int auto_increment
        primary key,
    class    varchar(45)  null,
    enabled  bit          not null,
    name     varchar(45)  null,
    password varchar(64)  not null,
    username varchar(128) not null
);

create table dkmh
(
    users_id   int not null,
    subject_id int not null,
    primary key (users_id, subject_id),
    constraint FK9ufm9ox1x9ojcsopq3b2uw1fh
        foreign key (users_id) references users (id),
    constraint FKlwefj8rpoiedof7k5oh3393ao
        foreign key (subject_id) references subjects (id)
);

create table users_roles
(
    users_id int not null,
    role_id  int not null,
    primary key (users_id, role_id),
    constraint FKj6m8fwv7oqv74fcehir1a9ffy
        foreign key (role_id) references roles (id),
    constraint FKml90kef4w2jy7oxyqv742tsfc
        foreign key (users_id) references users (id)
);


INSERT INTO dkmh.roles (id, description, name) VALUES (1, 'abc', 'ROLE_ADMIN');
INSERT INTO dkmh.roles (id, description, name) VALUES (2, 'abc', 'ROLE_USER');

INSERT INTO dkmh.users (id, class, enabled, name, password, username) VALUES (1, 'abc
abcd', true, 'Bao1', '$2a$10$PrI5Gk9L.tSZiW9FXhTS8O8Mz9E97k2FZbFvGFFaSsiTUIl.TCrFu', 'dbadmin1');
INSERT INTO dkmh.users (id, class, enabled, name, password, username) VALUES (2, 'abc
abcd', true, 'Bao222', '$2a$10$PrI5Gk9L.tSZiW9FXhTS8O8Mz9E97k2FZbFvGFFaSsiTUIl.TCrFu', 'dbuser1');

INSERT INTO dkmh.subjects (id, category_subject, name_subject, total_credits) VALUES (1, N'Đại cương', N'Vật lí 1', 3);
INSERT INTO dkmh.subjects (id, category_subject, name_subject, total_credits) VALUES (2, N'Đại cương', N'Toán 1', 3);
INSERT INTO dkmh.subjects (id, category_subject, name_subject, total_credits) VALUES (3, N'Đại cương ', N'Toán 2', 3);
INSERT INTO dkmh.subjects (id, category_subject, name_subject, total_credits) VALUES (4, N'Đại cương', N'Xác suất thống kê - ứng dụng', 3);
INSERT INTO dkmh.subjects (id, category_subject, name_subject, total_credits) VALUES (5, N'Chuyên ngành', N'Nhập môn lập trình ', 3);
INSERT INTO dkmh.subjects (id, category_subject, name_subject, total_credits) VALUES (6, N'Chuyên ngành', N'Kỹ thuật lập trình', 3);
INSERT INTO dkmh.subjects (id, category_subject, name_subject, total_credits) VALUES (7, N'Chuyên ngành ', N'Nhập môn ngành CNTT', 3);
INSERT INTO dkmh.subjects (id, category_subject, name_subject, total_credits) VALUES (8, N'Chuyên ngành', N'Cơ sở dữ liệu ', 3);
INSERT INTO dkmh.subjects (id, category_subject, name_subject, total_credits) VALUES (9, N'Chuyên ngành', N'An toàn thông tin', 3);
INSERT INTO dkmh.subjects (id, category_subject, name_subject, total_credits) VALUES (10, N'Chuyên ngành', N'Hệ quản trị CSDL', 3);


INSERT INTO dkmh.dkmh (users_id, subject_id) VALUES (2, 1);
INSERT INTO dkmh.dkmh (users_id, subject_id) VALUES (2, 2);
INSERT INTO dkmh.dkmh (users_id, subject_id) VALUES (2, 4);
INSERT INTO dkmh.dkmh (users_id, subject_id) VALUES (2, 5);
INSERT INTO dkmh.dkmh (users_id, subject_id) VALUES (2, 8);

INSERT INTO dkmh.users_roles (users_id, role_id) VALUES (1, 1);
INSERT INTO dkmh.users_roles (users_id, role_id) VALUES (1, 2);
INSERT INTO dkmh.users_roles (users_id, role_id) VALUES (2, 2);

INSERT INTO dkmh.persistent_logins (username, series, token, last_used) VALUES ('dbuser1', '3nHvHc6jyvXb0QseFxohnQ==', '/8fpGZBgoKjzqnZf4O0TWQ==', '2021-11-25 15:21:03');
INSERT INTO dkmh.persistent_logins (username, series, token, last_used) VALUES ('dbuser1', '9TMxKcUUvBFGg9WZFG0LUg==', 'GNGqT5VIpiIXxD8ms3kCsw==', '2021-11-25 15:21:03');