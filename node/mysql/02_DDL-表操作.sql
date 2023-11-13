-- 1.查看当前数据库中有哪些表
SHOW TABLES;

-- 2.查看某一张表的表结构
DESC `student_db`;

-- 3.创建一张新的表
-- 3.1.创建基本表结构
CREATE TABLE IF NOT EXISTS `teacher_db`(
	name VARCHAR(20),
	age INT
)
-- 删除表
DROP TABLE IF EXISTS `teacher_db`;

-- 3.2.创建完整的表结构
CREATE TABLE IF NOT EXISTS teacher (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(20) NOT NULL UNIQUE,
	age INT
);

-- 4.修改表结构
-- 4.1. 修改表名字
ALTER TABLE `teacher` RENAME `teacher_db`;

-- 4.2. 添加新的字段(field)
ALTER TABLE `teacher_db` ADD `createTime` TIMESTAMP;

-- 4.3. 修改字段的名称(field名称)
ALTER TABLE `teacher_db` CHANGE `name` userName VARCHAR(20);

-- 4.4. 删除某一个字段(field列)
ALTER TABLE `teacher_db` DROP `createTime`;

-- 4.5. 修改某一字段的类型(id int => bigint)
ALTER TABLE `teacher_db` MODIFY id BIGINT;