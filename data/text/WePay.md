
WePay's logging infrastructure is designed to handle a high volume of logs, with the ability to store up to 90 days of log data. The company uses Elasticsearch as its primary logging solution, with two clusters for dev and production environments. Each cluster has its own retention policy, with 90 days of retention for immediate analysis in the dev cluster and long-term retention in Google BigQuery for compliance and regulatory requirements.

To handle sudden log surges and protect Elasticsearch from data surges, WePay uses Apache Kafka to buffer logs. Incoming logs are forwarded to Kafka in Avro format before being ingested into Elasticsearch. This approach ensures that the logging pipeline can handle high volumes of logs without overwhelming Elasticsearch.

For long-term log storage, WePay uses Google BigQuery and Google Cloud Storage Buckets. Logs are ingested into BigQuery using a custom connector, and the company is exploring the use of Frozen Tier for searching longer durations of logs (90+ days) by referencing storage buckets.

To ensure secure access to log data, WePay has implemented cross-cluster search with a third Elasticsearch cluster that serves as a proxy for search requests. This approach allows for centralized security management and prevents end users from making changes to dev and production clusters.

Future work at WePay includes integrating APM data from its applications into Elasticsearch, setting up cross-cluster replication across multiple regions with an active-passive model, and using Frozen Tier for longer-duration log storage. The company also plans to use BigQuery more extensively for compliance and regulatory requirements.

Overall, WePay's logging infrastructure is designed to handle high volumes of logs, provide long-term log storage, and ensure secure access to log data. The company's approach includes the use of Elasticsearch, Kafka, BigQuery, and cross-cluster search to achieve these goals.