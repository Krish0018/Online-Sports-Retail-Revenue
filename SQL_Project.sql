-- Count the total number of products, along with the number of non-missing values in description, listing_price, and last_visited

SELECT count(i.product_id) AS totat_products, count(i.description) AS total_description, 
		count(f.listing_price) AS total_listing, count(t.last_visited) AS total_last_visited
FROM info_v2 i 
INNER JOIN finance f ON f.product_id = i.product_id
INNER JOIN traffic_v3 t ON t.product_id = i.product_id;

-- Find out how listing_price varies between Adidas and Nike products
SELECT b.brand, Round(AVG(f.listing_price),2) AS avg_listing_price,
		MIN(f.listing_price) AS min_listing_price, MAX(f.listing_price) AS max_listing_price
FROM brands_v2 b
INNER JOIN finance f ON b.product_id = f.product_id
WHERE b.brand IN ('Adidas', 'Nike')
GROUP BY b.brand;

-- Create labels for products grouped by price range and brand.
SELECT b.brand, COUNT(*) AS product_count, SUM(f.revenue) AS total_revenue,
		CASE WHEN f.listing_price < 50 THEN 'Low Price'
			WHEN f.listing_price < 100 THEN 'Medium Price'
			ELSE 'High Price'
		END AS price_range
FROM brands_v2 b
INNER JOIN finance f ON b.product_id = f.product_id
WHERE b.brand <> ''
GROUP BY 1,4;

-- Calculate the average discount offered by brand.
SELECT b.brand, ROUND(AVG(f.discount),2) AS avg_discount
FROM brands_v2 b 
INNER JOIN finance f ON b.product_id = f.product_id
WHERE b.brand <> ''
GROUP BY b.brand;

-- Calculate the correlation between reviews and revenue.
WITH combined AS
		(SELECT r.reviews, f.revenue
		FROM reviews_v2 r 
		INNER JOIN finance f ON r.product_id = f.product_id)

SELECT ROUND((COUNT(*) * SUM(reviews * revenue) - SUM(reviews) * SUM(revenue)) /
        (SQRT((COUNT(*) * SUM(reviews * reviews) - SUM(reviews) * SUM(reviews)) * 
          (COUNT(*) * SUM(revenue * revenue) - SUM(revenue) * SUM(revenue)))),2) AS correlation
FROM combined;

-- Split description into bins in increments of one hundred characters, and calculate average rating by for each bin.
SELECT TRUNCATE(LENGTH(i.description),-2) AS description_length,
		ROUND(AVG(r.rating),2) AS avg_rating
FROM info_v2 i 
INNER JOIN reviews_v2 r ON i.product_id = r.product_id
WHERE i.description <> ''
GROUP BY 1
ORDER BY 1;

-- Count the number of reviews per brand per month.
SELECT b.brand, SUBSTR(t.last_visited,6,2) AS month, COUNT(r.reviews) AS review_count
FROM brands_v2 b 
INNER JOIN traffic_v3 t ON b.product_id = t.product_id
INNER JOIN reviews_v2 r ON b.product_id = r.product_id
WHERE b.brand <> '' AND SUBSTR(t.last_visited,6,2) <> ''
GROUP BY 1,2
ORDER BY month, b.brand;

-- Create the footwear CTE, then calculate the number of products and average revenue from these items.
WITH footwear AS
		(SELECT i.description, f.revenue
		FROM info_v2 AS i
		INNER JOIN finance AS f ON i.product_id = f.product_id
		WHERE i.description LIKE '%shoe%'
					OR i.description LIKE '%trainer%'
					OR i.description LIKE '%foot%'
					AND i.description IS NOT NULL)
SELECT COUNT(description) AS total_product, ROUND(AVG(revenue),2) as avg_revenue
FROM footwear;

-- Copy the code used to create footwear then use a filter to return only products that are not in the CTE.
WITH footwear AS
		(SELECT i.description, f.revenue
		FROM info_v2 AS i
		INNER JOIN finance AS f ON i.product_id = f.product_id
		WHERE i.description LIKE '%shoe%'
					OR i.description LIKE '%trainer%'
					OR i.description LIKE '%foot%'
					AND i.description IS NOT NULL)
SELECT COUNT(i.description) AS total_product, ROUND(AVG(f.revenue),2) as avg_revenue
FROM info_v2 i 
INNER JOIN finance f ON i.product_id = f.product_id
WHERE i.description NOT IN 
						(SELECT description FROM footwear);
                        





