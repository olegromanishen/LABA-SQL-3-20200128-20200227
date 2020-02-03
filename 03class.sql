/*
 * #############################
 * #     Занятие 3             #  
 * #     Функции агрегации     #
 * #############################
 */

/*
 * +-----+
 * | SUM |
 * +-----+
 */

-- вывести содержимое таблицы продуктов
SELECT
	product_id,
	product_name,
	description,
	standard_cost,
	list_price,
	category_id
FROM
	db_laba.dbo.products;

-- вывести общую сумму цены на сайте
 SELECT
	SUM(list_price)
FROM
	db_laba.dbo.products;

/*
 * +-----+
 * | AVG |
 * +-----+
 */
-- вывести среднюю цену продукта на сайте
 SELECT
	AVG(list_price)
FROM
	db_laba.dbo.products;

/*
 * +-------+
 * | COUNT |
 * +-------+
 */

-- ИСПОЛЬЗОВАНИЕ COUNT СО СТРОКАМИ, А НЕ ЗНАЧЕНИЯМИ 
-- вывести общее количество строк в таблице заказов
 SELECT
	--*, 1, 112323, 'qewrqewrer'
 COUNT(*)
FROM
	db_laba.dbo.orders;

select 1;
-- вывести количество менеджеров продаж и общее количество строк таблицы заказоа
 SELECT
	COUNT(salesman_id) AS count_salesman,
	COUNT(*) AS count_all,
	COUNT(1) AS count_all_2,
	COUNT('qqq') AS count_all_3
FROM
	db_laba.dbo.orders;

-- вывести количество продуктов с уникальными ценами
 SELECT
	COUNT(DISTINCT list_price),
	COUNT(list_price)--,
	--COUNT(sum(list_price))
FROM
	db_laba.dbo.products;

SELECT
	COUNT(list_price)
FROM
	db_laba.dbo.products;

/*
 * +-----+
 * | MIN |
 * +-----+
 */

-- вывести минимальную цену на сайте
 SELECT
	MIN(list_price)
FROM
	db_laba.dbo.products;

/*
 * +-----+
 * | MAX |
 * +-----+
 */

-- вывести максимальную цену на сайте
 SELECT
	MAX(list_price)
FROM
	db_laba.dbo.products;

/*
 * +----------------------+
 * | Предложение GROUP BY |
 * +----------------------+
 */

-- вывести суммарное значение цены для каждой категории
 SELECT
	SUM(p.list_price) as sum_list_price,
	p.category_id
FROM
	db_laba.dbo.products as p
GROUP BY
	p.category_id;

-- вывести среднее значение цены для каждой категории
-- для товаров стандартная цена которых выше 1000
SELECT
	AVG(p.list_price) avg_list_price,
	round(AVG(p.list_price), 2) raunded_avg_list_price,
	CAST(round(AVG(p.list_price), 2) AS DECIMAL(10, 2)) raunded_avg_list_price_2,
	p.category_id
FROM
	db_laba.dbo.products p
WHERE
	p.standard_cost > 1000
GROUP BY
	p.category_id
order by 1;
/*
1979.018823	1
2007.823333	5
2642.375000	2*/
select 1 + 2;
select '1' + 2;
select '1' + '2';
select '1' + CAST(23333 AS varchar(40))
select 1 + CAST(2 AS varchar(5))


-- вывести 5 первых строк таблицы  деталей заказов
SELECT TOP (50)
	*
FROM 
 	db_laba.dbo.order_items
 	order by 1, 2;
 -- что ткаое unit price

-- вывести суммы в разрезе одного заказа
SELECT
	SUM(oi.unit_price),
	oi.order_id
FROM
	db_laba.dbo.order_items oi
GROUP BY
	oi.order_id;

select * FROM
	db_laba.dbo.orders

-- вывести суммы в разрезе одного заказа
-- для количества в одном заказе не менее 100 штук
 SELECT
	SUM(oi.unit_price),
	oi.order_id
FROM
	db_laba.dbo.order_items oi
WHERE
	oi.quantity >= 100
GROUP BY
	oi.order_id;

-- вывести суммы проданых продуктов в разрезе продукта (сгруппировав по product_id)
-- отсортировать по убыванию суммы
 SELECT
	SUM(oi.unit_price),
	oi.product_id
FROM
	db_laba.dbo.order_items oi
GROUP BY
	oi.product_id
ORDER BY 1 DESC;

/*
 * +--------------------+
 * | Предложение HAVING |
 * +--------------------+
 */

-- вывести к-во (сумму) проданных продуктов в разрезе продукта (сгруппировав по product_id)
-- для продуктов которые продали не менее 500 шт
-- отсортировать по убыванию к-ва
 SELECT
	SUM(oi.quantity),
	oi.product_id
FROM
	db_laba.dbo.order_items oi
--where SUM(oi.quantity) >= 500
--where oi.quantity >= 50 --500
GROUP BY
	oi.product_id
HAVING SUM(oi.quantity) >= 500
ORDER BY 1 DESC;

-- вывести суммы продаж в разрезе продукта
-- для продуктов которые продали не менее 500 шт
-- отсортировать по убыванию к-ва
 SELECT
	SUM(oi.unit_price * oi.quantity),
	--SUM(oi.quantity),
	oi.product_id
FROM
	db_laba.dbo.order_items oi
GROUP BY
	oi.product_id
HAVING SUM(oi.quantity) >= 500
ORDER BY 1 DESC;

-- вывести номера заказов и сумму чека
-- для заказов с не менее 10 позиций
-- отсортировать по убыванию суммы
 SELECT
	--COUNT(oi.item_id),
	oi.order_id,
	SUM(oi.unit_price * oi.quantity)
FROM
	db_laba.dbo.order_items oi
GROUP BY
	oi.order_id
HAVING COUNT(oi.item_id) >= 10
ORDER BY 2 DESC;

-- вывести топ 5 продаваемых продуктов и их кол-во
-- отсортировать по убыванию ко-ва
 SELECT TOP(5)
	SUM(oi.quantity),
	oi.product_id
FROM
	db_laba.dbo.order_items oi
GROUP BY
	oi.product_id
ORDER BY 1 DESC;

-- вывести топ 5 не продаваемых продуктов и их кол-во
-- отсортировать по убыванию ко-ва
 SELECT TOP(5)
	SUM(oi.quantity),
	oi.product_id
FROM
	db_laba.dbo.order_items oi
GROUP BY
	oi.product_id
ORDER BY 1;

