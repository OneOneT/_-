-- 1.创建歌曲表
CREATE TABLE IF NOT EXISTS `t_songs`(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(30) NOT NULL,
	duration INT DEFAULT 0,
	singer VARCHAR(20),
	singerId INT,
-- 	添加外键
	FOREIGN KEY (singerId) REFERENCES `t_singer`(id)
)

INSERT INTO `t_songs` (name, duration, singer) VALUES ('温柔', 100, '五月天');
INSERT INTO `t_songs` (name, duration, singer) VALUES ('离开地球表面', 120, '五月天');
INSERT INTO `t_songs` (name, duration, singer) VALUES ('倔强', 130, '五月天');

-- 2.创建歌手表
CREATE TABLE IF NOT EXISTS `t_singer`(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(10),
	intro VARCHAR(200)
)

INSERT INTO `t_singer` (name, intro) VALUES ('五月天', '五月天，全亚洲代表性摇滚乐团。演出足迹踏遍美国，澳洲以及全亚洲地区.')


UPDATE t_songs SET singerId = 1 WHERE singer = '五月天';


----------------------------------------------------------------------------------------------------
-- 1.为了品牌单独创建一张表
CREATE TABLE IF NOT EXISTS `brands`(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(10) UNIQUE NOT NULL,
	website VARCHAR(100),
	worldRank INT
);

INSERT INTO `brands` (name, website, worldRank) VALUES ('华为', 'www.huawei.com', 1);
INSERT INTO `brands` (name, website, worldRank) VALUES ('小米', 'www.mi.com', 10);
INSERT INTO `brands` (name, website, worldRank) VALUES ('苹果', 'www.apple.com', 5);
INSERT INTO `brands` (name, website, worldRank) VALUES ('oppo', 'www.oppo.com', 15);
INSERT INTO `brands` (name, website, worldRank) VALUES ('京东', 'www.jd.com', 3);
INSERT INTO `brands` (name, website, worldRank) VALUES ('Google', 'www.google.com', 8);


-- 2.为products表添加brand_id,并且设置外键约束
ALTER TABLE products ADD `brand_id` INT;
ALTER TABLE products ADD FOREIGN KEY (brand_id) REFERENCES brands (id);

UPDATE `products` SET `brand_id` = 1 WHERE `brand` = '华为';
UPDATE `products` SET `brand_id` = 4 WHERE `brand` = 'OPPO';
UPDATE `products` SET `brand_id` = 3 WHERE `brand` = '苹果';
UPDATE `products` SET `brand_id` = 2 WHERE `brand` = '小米';

-- 3.在有外键约束的情况下, 修改brand中的id(会报错)
UPDATE `brands` SET id = 99 WHERE id = 1;

-- 4.查看products中目前的外键

-- 5.修改外键
ALTER TABLE products ADD FOREIGN KEY (brand_id) REFERENCES brands(id)
										ON UPDATE CASCADE
										ON DELETE CASCADE;
