# docker에서 Spark 및 Kafka 실행
- 도커 데스크탑을 실행한 뒤에 Spark 컨테이너(spark master, spark worker, jupyterlab)를 빌드하는 데 필요한 도커 이미지를 다운로드합니다.
- ```bash
  ./build.sh 
  ```
- <img width="1257" alt="image" src="https://user-images.githubusercontent.com/47103479/235941545-71cebf8a-99f2-4b84-97cc-d4bb56b6b1da.png">
- Kafka와 Spark가 연결되도록 네트워크와 볼륨을 만들어줍니다.
- ```bash
  docker network create kafka-spark-network
  docker volume create --name=hadoop-distributed-file-system
  docker network ls
  ```
- <img width="763" alt="image" src="https://user-images.githubusercontent.com/47103479/235941711-c3a0f999-3037-4374-b4ad-0aab72194208.png">
- ![image](https://user-images.githubusercontent.com/47103479/236684346-35e396c3-6ddd-4408-b777-d9df7acd02e7.png)
- Kafka 및 Spark 컨테이너를 시작합니다.
- ```bash
  docker compose up -d
  ```
- ![image](https://user-images.githubusercontent.com/47103479/236684465-67c4b176-5fca-4253-9c67-6899913d7cf0.png)
- ```bash
  docker ps -a
  ```
- ![image](https://user-images.githubusercontent.com/47103479/236832393-26b0f1a6-ffe3-4e4a-9b74-4497754e44b4.png)
- | Application     | URL                                      | Description                                                |
  | --------------- | ---------------------------------------- | ---------------------------------------------------------- |
  | JupyterLab      | [localhost:8888](http://localhost:8888/) | Cluster interface with built-in Jupyter notebooks          |
  | Spark Master    | [localhost:8080](http://localhost:8080/) | Spark Master node                                          |
  | Spark Worker I  | [localhost:8083](http://localhost:8081/) | Spark Worker node with 1 core and 512m of memory (default) |
  | Spark Worker II | [localhost:8084](http://localhost:8082/) | Spark Worker node with 1 core and 512m of memory (default) |
  | Confluent kafka | [localhost:9021](http://localhost:9021/) | Web interface, to monitor, operate, and manage Kafka clusters|
- ![image](https://user-images.githubusercontent.com/47103479/235942450-d26c8cc5-1450-4291-ae3d-ca83ddcded8f.png)
- ![image](https://user-images.githubusercontent.com/47103479/235942665-a5100a95-1860-42f2-84e8-c4b0f29dd0d1.png)
- ![image](https://user-images.githubusercontent.com/47103479/236684498-8087328f-0ad8-45c7-953d-9db728050fef.png)
- 현재 실행 중인 모든 컨테이너를 중지하는 명령어 입니다. 컨테이너를 사용하지 않을 때 실행시켜 줍니다.
- ```
  docker stop $(docker ps -a -q)
  ```
- <img width="797" alt="image" src="https://user-images.githubusercontent.com/47103479/236684998-79599cbe-1060-4d26-b25a-2609508f51de.png">

## kafka-python
- 새로운 환경을 설정해줍니다.
- ```bash
  virtualenv kafka-env
  source kafka-env/bin/activate
  ```
- requirements.txt 파일을 생성해 줍니다.
- ```bash
  kafka-python==1.4.6
  confluent_kafka
  requests
  avro
  faust
  fastavro
  pyspark
  ```
- 필요한 라이브러리들을 설치해 줍니다.
- ```bash
  pip install -r requirements.txt
  ```
- <img width="1264" alt="image" src="https://user-images.githubusercontent.com/47103479/236681781-967022f9-e02f-4d9e-8f6d-4bc23fc4525a.png">
- 소스 코드는 다음과 같습니다.
  - settings.py : 환경 구성에 대한 설정 파일입니다.
    - ```python
      import pyspark.sql.types as T

      INPUT_DATA_PATH = '../../resources/rides.csv'
      BOOTSTRAP_SERVERS = 'localhost:9092'

      TOPIC_WINDOWED_VENDOR_ID_COUNT = 'vendor_counts_windowed'

      PRODUCE_TOPIC_RIDES_CSV = CONSUME_TOPIC_RIDES_CSV = 'rides_csv'

      RIDE_SCHEMA = T.StructType(
          [T.StructField("vendor_id", T.IntegerType()),
           T.StructField('tpep_pickup_datetime', T.TimestampType()),
           T.StructField('tpep_dropoff_datetime', T.TimestampType()),
           T.StructField("passenger_count", T.IntegerType()),
           T.StructField("trip_distance", T.FloatType()),
           T.StructField("payment_type", T.IntegerType()),
           T.StructField("total_amount", T.FloatType()),
           ])
      ```
  - producer.py : 원본 데이터 파일 (rides.csv)에 연결하여 데이터를 가져와 메시지를 토픽에 전달합니다.
    - ```python
      import csv
      from time import sleep
      from typing import Dict
      from kafka import KafkaProducer

      from settings import BOOTSTRAP_SERVERS, INPUT_DATA_PATH, PRODUCE_TOPIC_RIDES_CSV


      def delivery_report(err, msg):
          if err is not None:
              print("Delivery failed for record {}: {}".format(msg.key(), err))
              return
          print('Record {} successfully produced to {} [{}] at offset {}'.format(
              msg.key(), msg.topic(), msg.partition(), msg.offset()))


      class RideCSVProducer:
          def __init__(self, props: Dict):
              self.producer = KafkaProducer(**props)
              # self.producer = Producer(producer_props)

          @staticmethod
          def read_records(resource_path: str):
              records, ride_keys = [], []
              i = 0
              with open(resource_path, 'r') as f:
                  reader = csv.reader(f)
                  header = next(reader)  # skip the header
                  for row in reader:
                      # vendor_id, passenger_count, trip_distance, payment_type, total_amount
                      records.append(f'{row[0]}, {row[1]}, {row[2]}, {row[3]}, {row[4]}, {row[9]}, {row[16]}')
                      ride_keys.append(str(row[0]))
                      i += 1
                      if i == 5:
                          break
              return zip(ride_keys, records)

          def publish(self, topic: str, records: [str, str]):
              for key_value in records:
                  key, value = key_value
                  try:
                      self.producer.send(topic=topic, key=key, value=value)
                      print(f"Producing record for <key: {key}, value:{value}>")
                  except KeyboardInterrupt:
                      break
                  except Exception as e:
                      print(f"Exception while producing record - {value}: {e}")

              self.producer.flush()
              sleep(1)


      if __name__ == "__main__":
          config = {
              'bootstrap_servers': [BOOTSTRAP_SERVERS],
              'key_serializer': lambda x: x.encode('utf-8'),
              'value_serializer': lambda x: x.encode('utf-8')
          }
          producer = RideCSVProducer(props=config)
          ride_records = producer.read_records(resource_path=INPUT_DATA_PATH)
          print(ride_records)
          producer.publish(topic=PRODUCE_TOPIC_RIDES_CSV, records=ride_records)
      ```
  - consumer.py : 토픽에서 메시지를 받아옵니다.
    - ```python
      import argparse
      from typing import Dict, List
      from kafka import KafkaConsumer

      from settings import BOOTSTRAP_SERVERS, CONSUME_TOPIC_RIDES_CSV


      class RideCSVConsumer:
          def __init__(self, props: Dict):
              self.consumer = KafkaConsumer(**props)

          def consume_from_kafka(self, topics: List[str]):
              self.consumer.subscribe(topics=topics)
              print('Consuming from Kafka started')
              print('Available topics to consume: ', self.consumer.subscription())
              while True:
                  try:
                      # SIGINT can't be handled when polling, limit timeout to 1 second.
                      msg = self.consumer.poll(1.0)
                      if msg is None or msg == {}:
                          continue
                      for msg_key, msg_values in msg.items():
                          for msg_val in msg_values:
                              print(f'Key:{msg_val.key}-type({type(msg_val.key)}), '
                                    f'Value:{msg_val.value}-type({type(msg_val.value)})')
                  except KeyboardInterrupt:
                      break

              self.consumer.close()


      if __name__ == '__main__':
          parser = argparse.ArgumentParser(description='Kafka Consumer')
          parser.add_argument('--topic', type=str, default=CONSUME_TOPIC_RIDES_CSV)
          args = parser.parse_args()

          topic = args.topic
          config = {
              'bootstrap_servers': [BOOTSTRAP_SERVERS],
              'auto_offset_reset': 'earliest',
              'enable_auto_commit': True,
              'key_deserializer': lambda key: int(key.decode('utf-8')),
              'value_deserializer': lambda value: value.decode('utf-8'),
              'group_id': 'consumer.group.id.csv-example.1',
          }
          csv_consumer = RideCSVConsumer(props=config)
          csv_consumer.consume_from_kafka(topics=[topic])
      ```
- producer python 스크립트 파일을 실행합니다.
- ```bash
  python producer.py
  ```
- <img width="966" alt="image" src="https://user-images.githubusercontent.com/47103479/236827102-1d84b68c-da3c-4522-8967-215d0885464f.png">
- consumer python 스크립트 파일을 실행합니다.
- ```bash
  python consumer.py
  ```
- <img width="945" alt="image" src="https://user-images.githubusercontent.com/47103479/236828320-244751e5-a8ab-41ee-9087-cd69549b6c8a.png">
- [Confluent Control Center](http://localhost:9021/)에서 위에서 실행한 producer와 consumer에 대한 Topic을 확인합니다.
- ![image](https://user-images.githubusercontent.com/47103479/236828890-2d3b5349-1c71-476b-8293-0c8a0021f32c.png)

# PySpark Streaming
- streaming.py의 소스 코드는 다음과 같습니다.
- ```python
  from pyspark.sql import SparkSession
  import pyspark.sql.functions as F
  import findspark
  findspark.init()

  from settings import RIDE_SCHEMA, CONSUME_TOPIC_RIDES_CSV, TOPIC_WINDOWED_VENDOR_ID_COUNT


  def read_from_kafka(consume_topic: str):
      # Spark Streaming DataFrame, connect to Kafka topic served at host in bootrap.servers option
      df_stream = spark \
          .readStream \
          .format("kafka") \
          .option("kafka.bootstrap.servers", "localhost:9092,broker:29092") \
          .option("subscribe", consume_topic) \
          .option("startingOffsets", "earliest") \
          .option("checkpointLocation", "checkpoint") \
          .load()
      return df_stream


  def parse_ride_from_kafka_message(df, schema):
      """ take a Spark Streaming df and parse value col based on <schema>, return streaming df cols in schema """
      assert df.isStreaming is True, "DataFrame doesn't receive streaming data"

      df = df.selectExpr("CAST(key AS STRING)", "CAST(value AS STRING)")

      # split attributes to nested array in one Column
      col = F.split(df['value'], ', ')

      # expand col to multiple top-level columns
      for idx, field in enumerate(schema):
          df = df.withColumn(field.name, col.getItem(idx).cast(field.dataType))
      return df.select([field.name for field in schema])


  def sink_console(df, output_mode: str = 'complete', processing_time: str = '5 seconds'):
      write_query = df.writeStream \
          .outputMode(output_mode) \
          .trigger(processingTime=processing_time) \
          .format("console") \
          .option("truncate", False) \
          .start()
      return write_query  # pyspark.sql.streaming.StreamingQuery


  def sink_memory(df, query_name, query_template):
      query_df = df \
          .writeStream \
          .queryName(query_name) \
          .format("memory") \
          .start()
      query_str = query_template.format(table_name=query_name)
      query_results = spark.sql(query_str)
      return query_results, query_df


  def sink_kafka(df, topic):
      write_query = df.writeStream \
          .format("kafka") \
          .option("kafka.bootstrap.servers", "localhost:9092,broker:29092") \
          .outputMode('complete') \
          .option("topic", topic) \
          .option("checkpointLocation", "checkpoint") \
          .start()
      return write_query


  def prepare_df_to_kafka_sink(df, value_columns, key_column=None):
      columns = df.columns

      df = df.withColumn("value", F.concat_ws(', ', *value_columns))
      if key_column:
          df = df.withColumnRenamed(key_column, "key")
          df = df.withColumn("key", df.key.cast('string'))
      return df.select(['key', 'value'])


  def op_groupby(df, column_names):
      df_aggregation = df.groupBy(column_names).count()
      return df_aggregation


  def op_windowed_groupby(df, window_duration, slide_duration):
      df_windowed_aggregation = df.groupBy(
          F.window(timeColumn=df.tpep_pickup_datetime, windowDuration=window_duration, slideDuration=slide_duration),
          df.vendor_id
      ).count()
      return df_windowed_aggregation


  if __name__ == "__main__":
      spark = SparkSession.builder.appName('streaming-examples').getOrCreate()
      spark.sparkContext.setLogLevel('WARN')

      # read_streaming data
      df_consume_stream = read_from_kafka(consume_topic=CONSUME_TOPIC_RIDES_CSV)
      print(df_consume_stream.printSchema())

      # parse streaming data
      df_rides = parse_ride_from_kafka_message(df_consume_stream, RIDE_SCHEMA)
      print(df_rides.printSchema())

      sink_console(df_rides, output_mode='append')

      df_trip_count_by_vendor_id = op_groupby(df_rides, ['vendor_id'])
      df_trip_count_by_pickup_date_vendor_id = op_windowed_groupby(df_rides, window_duration="10 minutes",
                                                                   slide_duration='5 minutes')

      # write the output out to the console for debugging / testing
      sink_console(df_trip_count_by_vendor_id)
      # write the output to the kafka topic
      df_trip_count_messages = prepare_df_to_kafka_sink(df=df_trip_count_by_pickup_date_vendor_id,
                                                        value_columns=['count'], key_column='vendor_id')
      kafka_sink_query = sink_kafka(df=df_trip_count_messages, topic=TOPIC_WINDOWED_VENDOR_ID_COUNT)

      spark.streams.awaitAnyTermination()
  ```
- spark-submit을 실행합니다. 
- ```bash
  ./spark-submit.sh streaming.py
  ```
- 직접 설정값을 조정할 수 도 있습니다.
- ```bash
  spark-submit --master spark://localhost:7077 --num-executors 2 --executor-memory 3G --executor-cores 1  --packages org.apache.spark:spark-sql-kafka-0-10_2.12:3.3.1,org.apache.spark:spark-avro_2.12:3.3.1,org.apache.spark:spark-streaming-kafka-0-10_2.12:3.3.1 streaming.py
  ```
- <img width="1085" alt="image" src="https://github.com/mjs1995/data-engineering-zoomcamp/assets/47103479/e27924a3-aa8a-4df9-943c-543f2039dd4f">
- <img width="766" alt="image" src="https://github.com/mjs1995/data-engineering-zoomcamp/assets/47103479/55a6855b-1ab3-40e6-abe7-a57a50e1f245">
- 해당 spark-submit 관련 에러는 [블로그](https://mjs1995.tistory.com/274) 포스팅에서 확인하실 수 있습니다.
