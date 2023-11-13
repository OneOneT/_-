-- 1.对象(JSON_OBJECT)
SELECT * FROM products p
				LEFT JOIN brands b ON p.brand_id = b.id;
				
SELECT p.id, p.brand, p.title,score,
				JSON_OBJECT('id', b.id, 'name', b.`name`, 'website', b.website) brand
				FROM products p
				LEFT JOIN brands b ON p.brand_id = b.id;


-- 2.数组(JSON_ARRAYAGG) JSON_ARRAYAGG和JSON_OBJECT结合来使用；
-- 查询所有学生选课状态
SELECT stu.name, stu.age,
			JSON_ARRAYAGG(JSON_OBJECT("id", cos.id, 'cosName', cos.`name`) ) AS cos
			from students stu
			LEFT JOIN students_select_courses ssc ON stu.id = ssc.student_id
			LEFT JOIN courses cos ON ssc.course_id = cos.id
			GROUP BY stu.id;
			
-- 查询未选择学生
SELECT stu.name, stu.age,
			JSON_ARRAYAGG(JSON_OBJECT("id", cos.id, 'cosName', cos.`name`) ) AS cos
			from students stu
			LEFT JOIN students_select_courses ssc ON stu.id = ssc.student_id
			LEFT JOIN courses cos ON ssc.course_id = cos.id
			WHERE ssc.id IS NULL
			GROUP BY stu.id;
			
-- 查询选择学生
SELECT stu.name, stu.age,
			JSON_ARRAYAGG(JSON_OBJECT("id", cos.id, 'cosName', cos.`name`) ) AS cos
			from students stu
			LEFT JOIN students_select_courses ssc ON stu.id = ssc.student_id
			LEFT JOIN courses cos ON ssc.course_id = cos.id
			WHERE ssc.id IS NOT NULL
			GROUP BY stu.id;