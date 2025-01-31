PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "migrations" ("id" integer primary key autoincrement not null, "migration" varchar not null, "batch" integer not null);
INSERT INTO migrations VALUES(11,'0001_01_01_000000_create_users_table',1);
INSERT INTO migrations VALUES(12,'0001_01_01_000001_create_cache_table',1);
INSERT INTO migrations VALUES(13,'0001_01_01_000002_create_jobs_table',1);
INSERT INTO migrations VALUES(14,'2024_12_20_181949_create_admins_table',1);
INSERT INTO migrations VALUES(15,'2024_12_30_082047_create_clients_table',1);
INSERT INTO migrations VALUES(16,'2025_01_06_183235_create_categories_table',2);
INSERT INTO migrations VALUES(17,'2025_01_12_094515_create_cities_table',3);
INSERT INTO migrations VALUES(18,'2025_01_13_175309_add_role_to_users_table',4);
INSERT INTO migrations VALUES(19,'2025_01_13_191053_create_menus_table',5);
INSERT INTO migrations VALUES(20,'2025_01_15_174519_add_menu_name_to_menus_table',6);
INSERT INTO migrations VALUES(21,'2025_01_15_181050_create_menus_table',7);
INSERT INTO migrations VALUES(22,'2025_01_15_190401_create_products_table',8);
CREATE TABLE IF NOT EXISTS "users" ("id" integer primary key autoincrement not null, "name" varchar not null, "email" varchar not null, "email_verified_at" datetime, "password" varchar not null, "photo" varchar, "phone" varchar, "address" varchar, "role" varchar not null default 'user', "status" varchar not null default '1', "remember_token" varchar, "created_at" datetime, "updated_at" datetime);
INSERT INTO users VALUES(1,'chirag','chiraglaheru1@gmail.com',NULL,'$2y$12$vXCaKXRKMw.6BZAiGhIhLOlgjIS9zULesT7xmRGM551e9CxPdboAS',NULL,NULL,NULL,'user','1',NULL,'2025-01-05 18:49:23','2025-01-05 18:49:23');
INSERT INTO users VALUES(2,'chirag','pizzaahut@gmail.com',NULL,'$2y$12$prh0iduwr2F4YdnMQxaxcexg0KsgJzXMq7Vef/ltnEb2PYRMoHycK','1736150512.webp',NULL,NULL,'user','1',NULL,'2025-01-06 08:00:19','2025-01-06 08:01:52');
INSERT INTO users VALUES(3,'chirag','chiragclient@gmail.com',NULL,'$2y$12$Fp4Bjbdg4/r15aCJi/UiRurBpZMoxwLsBubaDHok77cRrqPbVGxTu',NULL,NULL,NULL,'user','1',NULL,'2025-01-11 08:01:26','2025-01-11 08:01:26');
INSERT INTO users VALUES(4,'chirag','chiragadmin@gmail.com',NULL,'$2y$12$Grp9phZw0KiYK0JpGR3Pa.xDXmx.gXHYroNVL48l0fYozTCpiJIvy',NULL,NULL,NULL,'user','1',NULL,'2025-01-12 19:01:07','2025-01-12 19:01:07');
INSERT INTO users VALUES(5,'chirag','adminchirag@gmail.com',NULL,'$2y$12$h9FCUMVdWuEVvEdcjWrOYehUrrOdqLqIG6IEBGKPvGANAlQj6yJKG',NULL,NULL,NULL,'user','1',NULL,'2025-01-13 17:49:42','2025-01-13 17:49:42');
INSERT INTO users VALUES(6,'chirag','abc@gmail.com',NULL,'$2y$12$TuwzayXfvvrlnTLqNTYlzeQM3b8tz7cX0mRVmx7OKgYkaByV3yeh6',NULL,NULL,NULL,'user','1',NULL,'2025-01-13 18:39:14','2025-01-13 18:39:14');
CREATE TABLE IF NOT EXISTS "password_reset_tokens" ("email" varchar not null, "token" varchar not null, "created_at" datetime, primary key ("email"));
CREATE TABLE IF NOT EXISTS "sessions" ("id" varchar not null, "user_id" integer, "ip_address" varchar, "user_agent" text, "payload" text not null, "last_activity" integer not null, primary key ("id"));
INSERT INTO sessions VALUES('h5UnvDIg7BYkJHQ7Ta9PI39oKuHkh4NP4Rlcdyhd',NULL,'127.0.0.1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNjYzQWF4WUFxOG1oVkdnRFBwRmxSVlpPT2hlZ2I3cTlpZ0J3MkFCcSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZGQvcHJvZHVjdCI7fXM6NTM6ImxvZ2luX2NsaWVudF81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7fQ==',1737188981);
CREATE TABLE IF NOT EXISTS "cache" ("key" varchar not null, "value" text not null, "expiration" integer not null, primary key ("key"));
CREATE TABLE IF NOT EXISTS "cache_locks" ("key" varchar not null, "owner" varchar not null, "expiration" integer not null, primary key ("key"));
CREATE TABLE IF NOT EXISTS "jobs" ("id" integer primary key autoincrement not null, "queue" varchar not null, "payload" text not null, "attempts" integer not null, "reserved_at" integer, "available_at" integer not null, "created_at" integer not null);
CREATE TABLE IF NOT EXISTS "job_batches" ("id" varchar not null, "name" varchar not null, "total_jobs" integer not null, "pending_jobs" integer not null, "failed_jobs" integer not null, "failed_job_ids" text not null, "options" text, "cancelled_at" integer, "created_at" integer not null, "finished_at" integer, primary key ("id"));
CREATE TABLE IF NOT EXISTS "failed_jobs" ("id" integer primary key autoincrement not null, "uuid" varchar not null, "connection" text not null, "queue" text not null, "payload" text not null, "exception" text not null, "failed_at" datetime not null default CURRENT_TIMESTAMP);
CREATE TABLE IF NOT EXISTS "admins" ("id" integer primary key autoincrement not null, "name" varchar not null, "email" varchar not null, "email_verified_at" datetime, "password" varchar not null, "photo" varchar, "token" varchar, "phone" varchar, "address" varchar, "role" varchar not null default 'admin', "status" varchar not null default '1', "remember_token" varchar, "created_at" datetime, "updated_at" datetime);
INSERT INTO admins VALUES(1,'Chirag Admin','chiragadmin@gmail.com',NULL,'$2y$12$ZrF6ZSS1.wUqTBASfWvO4eOKX4sqs6tS80qFCRGPahhCIeaPQfICm',NULL,NULL,NULL,NULL,'admin','1',NULL,'2025-01-06 18:28:24','2025-01-06 18:28:24');
CREATE TABLE IF NOT EXISTS "clients" ("id" integer primary key autoincrement not null, "name" varchar not null, "email" varchar not null, "email_verified_at" datetime, "password" varchar not null, "photo" varchar, "token" varchar, "phone" varchar, "address" varchar, "role" varchar not null default 'client', "status" varchar not null default '1', "remember_token" varchar, "created_at" datetime, "updated_at" datetime);
INSERT INTO clients VALUES(1,'chiragclient','chiragclient@gmail.com',NULL,'$2y$12$SFWMhClK9qIryHyuu3QUU.Vgu7v5UFceQhkR4jg4G4WgR3qXouzR6',NULL,NULL,NULL,NULL,'client','0',NULL,NULL,NULL);
INSERT INTO clients VALUES(2,'biryani','biryani@gmail.com',NULL,'$2y$12$IyuvXzxSTVj/cSPXoy7iVup2tqhmjzpPvQLQtHPI6ukwAbg1t9Hri',NULL,NULL,'1234','123','client','0',NULL,NULL,NULL);
CREATE TABLE IF NOT EXISTS "categories" ("id" integer primary key autoincrement not null, "created_at" datetime, "updated_at" datetime, "category_name" varchar not null, "image" varchar);
INSERT INTO categories VALUES(5,'2025-01-17 09:59:44','2025-01-17 09:59:44','pizza','upload/category/1821489741291807.webp');
CREATE TABLE IF NOT EXISTS "cities" ("id" integer primary key autoincrement not null, "city_name" varchar not null, "city_slug" varchar not null, "created_at" datetime, "updated_at" datetime);
INSERT INTO cities VALUES(1,'mumbai','mumbai','2025-01-12 17:47:31','2025-01-12 17:47:31');
CREATE TABLE IF NOT EXISTS "menus" ("id" integer primary key autoincrement not null, "menu_name" varchar not null, "image" varchar, "created_at" datetime, "updated_at" datetime);
INSERT INTO menus VALUES(2,'pizza','upload/menu/1821340920318338.webp','2025-01-15 18:34:17','2025-01-15 18:34:17');
INSERT INTO menus VALUES(3,'the pizza','upload/menu/1821434212288333.webp','2025-01-16 19:17:07','2025-01-16 19:17:07');
CREATE TABLE IF NOT EXISTS "products" ("id" integer primary key autoincrement not null, "name" varchar not null, "slug" varchar, "category_id" varchar not null, "city_id" varchar not null, "menu_id" varchar not null, "code" varchar, "qty" varchar, "price" varchar, "discount_price" varchar, "image" varchar, "size" varchar, "client_id" varchar, "most_popular" varchar, "best_seller" varchar, "status" varchar, "created_at" datetime, "updated_at" datetime);
DELETE FROM sqlite_sequence;
INSERT INTO sqlite_sequence VALUES('migrations',22);
INSERT INTO sqlite_sequence VALUES('users',6);
INSERT INTO sqlite_sequence VALUES('admins',1);
INSERT INTO sqlite_sequence VALUES('categories',5);
INSERT INTO sqlite_sequence VALUES('clients',2);
INSERT INTO sqlite_sequence VALUES('cities',3);
INSERT INTO sqlite_sequence VALUES('menus',3);
CREATE UNIQUE INDEX "users_email_unique" on "users" ("email");
CREATE INDEX "sessions_user_id_index" on "sessions" ("user_id");
CREATE INDEX "sessions_last_activity_index" on "sessions" ("last_activity");
CREATE INDEX "jobs_queue_index" on "jobs" ("queue");
CREATE UNIQUE INDEX "failed_jobs_uuid_unique" on "failed_jobs" ("uuid");
CREATE UNIQUE INDEX "admins_email_unique" on "admins" ("email");
CREATE UNIQUE INDEX "clients_email_unique" on "clients" ("email");
COMMIT;
