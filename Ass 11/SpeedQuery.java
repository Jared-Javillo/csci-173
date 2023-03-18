
count 'driver_data', FILTER => "SingleColumnValueFilter('cf','speed',>,'30')"
count 'driver_data', FILTER => "SingleColumnValueFilter('cf', 'speed', >, 'long:30')"
count 'driver_data', {FILTER => "(SingleColumnValueFilter('cf','speed',>, 'binaryprefix:30'))"}

scan 'driver_data', { 
    COLUMNS => 'cf:speed',
    FILTER =>  "ValueFilter (>,'binary:30')"
 }
 

hbase> count 'driver_data', { FILTER => SingleColumnValueFilter.new(Bytes.toBytes('cf'), Bytes.toBytes('speed'), CompareFilter::CompareOp.valueOf('GREATER'),BinaryComparator.new(Bytes.toBytes('30')))}
scan 'driver_data', {FILTER => "ValueFilter (>,'binaryprefix:30')"}
                            
scan 'driver_data', { 
   FILTER => "ColumnPrefixFilter('speed')", "ValueFilter (>,'binaryprefix:30')"
   COLUMNS => 'cf:speed'
}
      
scan 'driver_data', {
    FILTER => "MultipleFilters(
      [{ 'type' => 'ColumnPrefixFilter', 'value' => 'speed' }, {'type' => 'ValueFilter','valueComparator' => 'GREATER', 'comparatorType' => 'BinaryComparator','value' => '30'}]
    )",
    COLUMNS => 'cf:speed'
  }

  scan 'driver_data', {
    FILTER => FilterList.new([
      PrefixFilter.new('prefix'),
      ColumnValueFilter.new('cf', 'speed', '>', 'binary:30')
    ], FilterList::Operator.MUST_PASS_ALL),
    COLUMNS => 'cf:speed'
  }

  count 'driver_data', {FILTER => "ValueFilter(>, 'binary:30') AND ColumnPrefixFilter('speed')"}

  count 'driver_data', {FILTER => "(SingleColumnValueFilter('cf', 'speed', >, 'binary:30'))"}


  javac -cp "/usr/lib/hbase/hbase-client-2.2.7.jar" count.java


  

beeline -u "jdbc:hive2://hbase-ass-11-m:10000/default" -n "hive" -p ""


CREATE EXTERNAL TABLE driver_hive_table (
  row_key string,
  distance double,
  speed int
)
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
WITH SERDEPROPERTIES ('hbase.columns.mapping' =
    ':key,cf:distance,cf:speed', 'hbase.scan.cacheblocks' = 'false', 'hbase.scan.cache' = '1000')
TBLPROPERTIES ('hbase.table.name' = 'drive_data');

CREATE EXTERNAL TABLE driver_hive_table (
  row_key string,
  distance double,
  speed int
)
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
WITH SERDEPROPERTIES ("hbase.columns.mapping" =
    ":key,cf:distance,cf:speed")
TBLPROPERTIES ("hbase.table.name" = "driver_data");

SELECT COUNT(*) FROM driver_hive_table WHERE speed > 30;
DESCRIBE FORMATTED driver_hive_table;


CREATE EXTERNAL TABLE driver_data_hive (
  key BIGINT,
  id BIGINT,
  distance DOUBLE,
  speed INT
)
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
WITH SERDEPROPERTIES ("hbase.columns.mapping" = ":HBASE_ROW_KEY,cf:id,cf:distance,cf:speed")
TBLPROPERTIES ("hbase.table.name" = "driver_data");

CREATE EXTERNAL TABLE driver_data_hive (
  row_key STRING,
  id BIGINT,
  distance DOUBLE,
  speed INT
)
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
WITH SERDEPROPERTIES ("hbase.columns.mapping" = ":key,cf:id,cf:distance,cf:speed")
TBLPROPERTIES ("hbase.table.name" = "driver_data");


beeline -u "jdbc:hive2://hbase-ass-11-m:10000/default" -n "hive" -p ""

CREATE EXTERNAL TABLE driver_data_hive (
  row_key STRING,
  distance DOUBLE,
  speed INT
)
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
WITH SERDEPROPERTIES ("hbase.columns.mapping" = ":key,cf:distance,cf:speed")
TBLPROPERTIES ("hbase.table.name" = "driver_data");
SELECT COUNT(*) FROM driver_data_hive WHERE speed > 30;

scan 'driver_data', {COLUMNS => 'cf:speed', FILTER => "SingleColumnValueFilter('cf', 'speed', >, 'binary:30')"} COUNT => 4000