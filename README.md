# Online-Sports-Retail-Revenue

## Description
This SQL project involves analyzing data related to products, brands, sales, and reviews. It includes various queries to extract insights and perform calculations on the dataset. Below are the key queries and their descriptions:

### Total Product Counts:
    Counts the total number of products and the number of non-missing values in the description, listing_price, and last_visited columns.
### Listing Price Variation: 
    Finds out how listing_price varies between Adidas and Nike products, including average, minimum, and maximum listing prices.
### Product Labels by Price Range: 
    Creates labels for products grouped by price range and brand.
### Average Discount by Brand: 
    Calculates the average discount offered by each brand.
### Correlation Analysis: 
    Calculates the correlation between reviews and revenue.
### Description Binning and Average Rating: 
    Splits the description into bins in increments of one hundred characters and calculates the average rating for each bin.
### Review Count by Brand and Month: 
    Counts the number of reviews per brand per month.
### Footwear Analysis:  
    Creates a Common Table Expression (CTE) for footwear-related products and calculates the number of products and average revenue from these items.
### Non-Footwear Product Analysis: 
    Creates a CTE for footwear-related products and filters out non-footwear products to calculate the total number of products and average revenue.
    
## Usage
To use this project, you can run the provided SQL queries on your MySQL database containing the relevant tables (info_v2, brands_v2, finance, traffic_v3, reviews_v2). Make sure to adjust the table names and column names in the queries according to your database schema.

## Queries
All queries are provided in the project files. You can copy and paste them into your MySQL client or editor to run them against your database.
