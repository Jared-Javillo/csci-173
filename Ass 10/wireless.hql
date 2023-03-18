gcloud dataproc jobs submit hive \
    --cluster hive-cluster-ass-10\
    --region asia-east1 \
    --execute "
        CREATE EXTERNAL TABLE reviews3 (
        marketplace STRING,
        customer_id STRING,
        review_id STRING,
        product_id STRING,
        product_parent STRING,
        product_title STRING,
        product_category STRING,
        star_rating INT,
        helpful_votes INT,
        total_votes INT,
        vine STRING,
        verified_purchase STRING,
        review_headline STRING,
        review_body STRING,
        review_date STRING
        )
        ROW FORMAT DELIMITED
        FIELDS TERMINATED BY '\t'
        STORED AS TEXTFILE
        LOCATION 'gs://hive-ass-10-bucket/datasets/reviews';"




gcloud dataproc jobs submit hive \
    --cluster hive-cluster-ass-10\
    --region asia-east1 \
    --execute "
        SELECT product_id, product_title, product_category, AVG(star_rating) AS avg_rating
            FROM reviews3
            GROUP BY product_id, product_title, product_category
            ORDER BY avg_rating DESC
            LIMIT 10;"


gcloud dataproc jobs submit hive \
    --cluster hive-cluster-ass-10\
    --region asia-east1 \
    --execute "
        SELECT *
        FROM 
        FROM reviews;"