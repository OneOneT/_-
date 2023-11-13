-- 1.直接从两张表中查询数据(笛卡尔乘积，也称之为直积，表示为 X*Y)
SELECT * FROM products, brands;

-- 2.从两张表查询所有的数据, 再对结果进行过滤
-- 表连接(这个表示查询到笛卡尔乘积后的结果中，符合products.brand_id = brand.id条件的数据过滤出来)
SELECT * FROM products, brands WHERE products.brand_id = brands.id;

-- 1.左连接 LEFT [OUTER] JOIN '表' ON 连接条件(以左表为主)
SELECT * FROM products LEFT JOIN brands ON products.brand_id = brands.id;

-- 查询左边的数据哪些是和右边没有交集(右边为空)
SELECT * FROM products LEFT JOIN brands ON products.brand_id = brands.id WHERE brands.id IS NULL;

-- 2.右连接: RIGHT [OUTER] JOIN
SELECT * FROM products RIGHT JOIN brands ON products.brand_id = brands.id;
SELECT * FROM products RIGHT JOIN brands ON products.brand_id = brands.id WHERE products.brand_id IS NULL;

-- 3.内连接: [CROSS/INNER] JOIN(左边的表和右边的表都有对应的数据关联)
SELECT * FROM products JOIN brands ON products.brand_id = brands.id;

-- 4.全连接: MySQL不支持全连接, 使用union
(SELECT * FROM products LEFT JOIN brands ON products.brand_id = brands.id)
UNION
(SELECT * FROM products RIGHT JOIN brands ON products.brand_id = brands.id);

(SELECT * FROM products LEFT JOIN brands ON products.brand_id = brands.id WHERE brands.id IS NULL)
UNION
(SELECT * FROM products RIGHT JOIN brands ON products.brand_id = brands.id WHERE products.id IS NULL);