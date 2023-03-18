CREATE EXTERNAL TABLE IF NOT EXISTS my_table ( field1 string, field2 int, field3 string, field4 double ) 
ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.JsonSerde'
LOCATION '/path-to/my_table/';

gcloud dataproc jobs submit hive \
    --cluster=hive-ass-9\
    --region=${REGION} \
    --execute="CREATE EXTERNAL TABLE tweets (
        interactions array<struct<
            demographic:struct<
                gender:string
            >,
            interaction:struct<
                author: struct<
                    username:string,
                    name:string,
                    id:string
                >,
                id:bigint
            >,
            klout:struct<
                score:int
            >
        >>
      )
    ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
    LOCATION 'gs://${WAREHOUSE_BUCKET}';"

gcloud dataproc jobs submit hive\
    --cluster=hive-ass-9\
    --region='asia-south1'\
    --execute="
                ADD JAR gs://hive-ass-9/hive-json-serde-0.2.jar;
               CREATE EXTERNAL TABLE tweets6 (
                   interactions array<struct<
                       demographic:struct<
                           gender:string
                       >,
                       interaction:struct<
                           author: struct<
                               username:string,
                               name:string,
                               id:string
                           >,
                           id:bigint
                       >,
                       klout:struct<
                           score:int
                       >
                   >>
                   )
                   ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
                   LOCATION 'gs://hive-ass-9/data';"
                   
                CREATE EXTERNAL TABLE tweets13 (
                    interactions array<struct<
                        demographic:struct<
                        gender:string
                        >,
                        interaction:struct<
                        author: struct<
                            username:string,
                            name:string,
                            id:string
                        >,
                        id:bigint
                        >,
                        klout:struct<
                        score:int
                        >
                    >>
                    )
                    ROW FORMAT SERDE 'org.apache.hive.serde2.json.JsonSerDe'
                    LOCATION 'gs://hive-ass-9/data';"

gcloud dataproc jobs submit hive\
    --cluster=hive-ass-9\
    --region='asia-south1'\
    --execute="
                CREATE TABLE tweets (
                    interactions array<struct<
                        demographic:struct<
                        gender:string
                        >,
                        interaction:struct<
                        author: struct<
                            username:string,
                            name:string,
                            id:string
                        >,
                        id:bigint
                        >,
                        klout:struct<
                        score:int
                        >
                    >>
                    )
                    ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
                    LOCATION 'gs://hive-ass-9/data';"

gcloud dataproc jobs submit hive\
    --cluster=hive-ass-9\
    --region='asia-south1'\
    --execute="SELECT * FROM tweets6;"


gcloud dataproc jobs submit hive 
    --cluster="hive-ass-9" \ 
    --region=${REGION} \ 
    --execute="ADD JAR gs://hive-ass-9//hive-json-serde-0.2.jar;"

gcloud dataproc jobs submit hive \
    --cluster=hive-ass-9 \
    --region=${REGION} \
    --execute="ADD JAR gs://hive-ass-9/hive-json-serde-0.2.jar;"

gcloud dataproc jobs submit hive \
    --cluster=hive-ass-9\
    --region='asia-south1'\
    --execute="
      CREATE EXTERNAL TABLE transactions
      (SubmissionDate DATE, TransactionAmount DOUBLE, TransactionType STRING)
      STORED AS PARQUET
      LOCATION 'gs://hive-ass-9/datasets/transactions';"

gcloud dataproc jobs submit hive \
    --cluster hive-ass-9 \
    --region ${REGION} \
    --execute "
      CREATE EXTERNAL TABLE transactions
      (SubmissionDate DATE, TransactionAmount DOUBLE, TransactionType STRING)
      STORED AS PARQUET
      LOCATION 'gs://${WAREHOUSE_BUCKET}';"
      
gcloud dataproc jobs submit hive \
    --cluster=hive-ass-9\
    --region=asia-south1 \
    --execute="
      set hive.vectorized.execution.enabled=false;
      set hive.vectorized.execution.reduce.enabled=false;
      SELECT *
      FROM tweets5
      LIMIT 10;"
"
CREATE TABLE tweets (
    count INT,
    hash STRING,
    hash_type STRING,
    id STRING,
    interactions ARRAY<STRUCT<
        interaction: STRUCT<
            schema: STRUCT<version: INT>,
            source: STRING,
            author: STRUCT<
                username: STRING,
                name: STRING,
                id: BIGINT,
                avatar: STRING,
                link: STRING
            >,
            type: STRING,
            created_at: STRING,
            content: STRING,
            id: BIGINT,
            link: STRING
        >,
        klout: STRUCT<score: INT>,
        language: STRUCT<tag: STRING, confidence: INT>,
        twitter: STRUCT<
            created_at: STRING,
            id: BIGINT,
            in_reply_to_screen_name: STRING,
            in_reply_to_status_id: BIGINT,
            in_reply_to_user_id: BIGINT,
            mention_ids: ARRAY<BIGINT>,
            mentions: ARRAY<STRING>,
            source: STRING,
            text: STRING,
            user_details: STRUCT<
                name: STRING,
                url: STRING,
                description: STRING,
                location: STRING,
                statuses_count: BIGINT,
                followers_count: BIGINT,
                friends_count: BIGINT,
                screen_name: STRING,
                profile_image_url: STRING,
                lang: STRING,
                time_zone: STRING,
                utc_offset: INT,
                listed_count: INT,
                id: BIGINT,
                id_str: STRING,
                geo_enabled: BOOLEAN,
                created_at: STRING
            >
        >
    >
)
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE
LOCATION '/json_data';

CREATE TABLE tweets (
    count INT,
    hash STRING,
    hash_type STRING,
    id STRING,
    interactions ARRAY<STRUCT<
        interaction: STRUCT<
            schema: STRUCT<version: INT>,
            source: STRING,
            author: STRUCT<
                username: STRING,
                name: STRING,
                id: BIGINT,
                avatar: STRING,
                link: STRING
            >,
            type: STRING,
            created_at: STRING,
            content: STRING,
            id: BIGINT,
            link: STRING
        >,
        klout: STRUCT<score: INT>,
        language: STRUCT<tag: STRING, confidence: INT>,
        twitter: STRUCT<
            created_at: STRING,
            id: BIGINT,
            in_reply_to_screen_name: STRING,
            in_reply_to_status_id: BIGINT,
            in_reply_to_user_id: BIGINT,
            mention_ids: ARRAY<BIGINT>,
            mentions: ARRAY<STRING>,
            source: STRING,
            text: STRING,
            user_details: STRUCT<
                name: STRING,
                url: STRING,
                description: STRING,
                location: STRING,
                statuses_count: BIGINT,
                followers_count: BIGINT,
                friends_count: BIGINT,
                screen_name: STRING,
                profile_image_url: STRING,
                lang: STRING,
                time_zone: STRING,
                utc_offset: INT,
                listed_count: INT,
                id: BIGINT,
                id_str: STRING,
                geo_enabled: BOOLEAN,
                created_at: STRING
            >
        >
    >)
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE
LOCATION '/json_data';

ADD JAR hdfs://hive-hcatalog-core-3.1.3.jar;
CREATE EXTERNAL TABLE tweets4 (
    interactions array<struct<
        demographic:struct<
            gender:string
        >,
        interactions:struct<
            author:struct<
                username:string,
                name:string,
                id:string
            >,
            id:bigint
        >,
        klout:struct<
            score:int
        >
    >>
)
ROW FORMAT SERDE 'org.apache.hive.hcatalog.data.JsonSerDe'
STORED AS TEXTFILE
LOCATION '/json_data';


CREATE TABLE tweets (
    count INT,
    hash STRING,
    hash_type STRING,
    id STRING,
    interactions ARRAY<STRUCT<
        interaction: STRUCT<
            schema: STRUCT<version: INT>,
            source: STRING,
            author: STRUCT<
                username: STRING,
                name: STRING,
                id: BIGINT,
                avatar: STRING,
                link: STRING
            >,
            type: STRING,
            created_at: STRING,
            content: STRING,
            id: BIGINT,
            link: STRING
        >,
        klout: STRUCT<score: INT>,
        language: STRUCT<tag: STRING, confidence: INT>,
        twitter: STRUCT<
            created_at: STRING,
            id: BIGINT,
            in_reply_to_screen_name: STRING,
            in_reply_to_status_id: BIGINT,
            in_reply_to_user_id: BIGINT,
            mention_ids: ARRAY<BIGINT>,
            mentions: ARRAY<STRING>,
            source: STRING,
            text: STRING,
            user_details: STRUCT<
                name: STRING,
                url: STRING,
                description: STRING,
                location: STRING,
                statuses_count: BIGINT,
                followers_count: BIGINT,
                friends_count: BIGINT,
                screen_name: STRING,
                profile_image_url: STRING,
                lang: STRING,
                time_zone: STRING,
                utc_offset: INT,
                listed_count: INT,
                id: BIGINT,
                id_str: STRING,
                geo_enabled: BOOLEAN,
                created_at: STRING
            >
        >
    >
    >
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.JsonSerDe'
STORED AS TEXTFILE
LOCATION 'tweets';

CREATE TABLE tweetsShort (
    interactions array<struct<
        demographic:struct<
            gender:string
        >,
        interactions:struct<
            author:struct<
                username:string,
                name:string,
                id:string
            >,
            id:bigint
        >,
        klout:struct<
            score:int
        >
    >>
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.JsonSerDe'
STORED AS TEXTFILE
LOCATION 'tweets';



SELECT
  interactions.interactions.author.username,
  SUM(interactionsklout.score) AS total_klout_score
FROM tweets
GROUP BY interactions.author.username
ORDER BY total_klout_score DESC
LIMIT 5;

SELECT a.interactions.interactions.author.username, a.interactions.klout.score 
FROM tweets a 
LATERAL VIEW explode(interactions) interactions_table AS interactions 
WHERE interactions_table.interactions.author.id IS NOT NULL 
ORDER BY interactions_table.interactions.klout.score DESC 
LIMIT 5;

SELECT DISTINCT interactions.interactions.author, interactions.klout.score
FROM tweets;


-- query the data
SELECT author.username, author.name, MAX(interaction.klout.score) AS max_klout_score
FROM tweets
LATERAL VIEW explode(interactions) tbl AS interaction
LATERAL VIEW explode(interaction.interaction.author) tbl AS author
GROUP BY author.username, author.name
ORDER BY max_klout_score DESC
LIMIT 5;



SELECT i.interactions.interactions.author.username, i.interactions.interactions.author.name, MAX(i.interactions.klout.score) AS max_klout_score
FROM tweetsShort t
LATERAL VIEW explode(t.interactions) i AS interactions
GROUP BY i.interactions.interactions.author.username, i.interactions.interactions.author.name
ORDER BY max_klout_score DESC
LIMIT 5;

SELECT interactions.interactions.id, interactions.interactions.created_at
FROM tweetsShort
LATERAL VIEW explode(interactions) tbl AS interactions
ORDER BY interactions.interactions.created_at ASC
LIMIT 5;


SELECT interactions[0].interaction.created_at AS created_at, interactions[0].interaction.content AS content
FROM tweets
ORDER BY interactions[0].interaction.created_at ASC
LIMIT 5;


SELECT interactions[0].interaction.author.username AS uname, interactions[0].klout.score
FROM tweets
GROUP BY interactions[0].interaction.author.username, interactions[0].klout.score
ORDER BY interactions[0].klout.score ASC
LIMIT 5;