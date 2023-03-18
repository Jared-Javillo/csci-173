import org.apache.hadoop.hbase.filter.CompareFilter;
import org.apache.hadoop.hbase.filter.SingleColumnValueFilter;
import org.apache.hadoop.hbase.filter.BinaryComparator;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.hadoop.hbase.client.*;

public class SpeedQuery {

    public static void main(String[] args) throws Exception {
        // Get the HBase configuration object
        Configuration config = HBaseConfiguration.create();

        // Create an HTable object for the "driver_data" table
        HTable table = new HTable(config, "driver_data");

        // Create a filter to select rows where SPEED > 30
        SingleColumnValueFilter filter = new SingleColumnValueFilter(
            Bytes.toBytes("cf"),
            Bytes.toBytes("speed"),
            CompareFilter.CompareOp.GREATER,
            new BinaryComparator(Bytes.toBytes("30"))
        );

        // Create a scan object and add the filter to it
        Scan scan = new Scan();
        scan.setFilter(filter);

        // Count the number of rows matching the filter
        long rowCount = 0;
        ResultScanner scanner = table.getScanner(scan);
        for (Result result : scanner) {
            rowCount++;
        }
        scanner.close();

        // Print the result
        System.out.println("Number of rows where SPEED > 30: " + rowCount);
    }
}
