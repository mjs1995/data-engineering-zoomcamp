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
  ```
- 필요한 라이브러리들을 설치해 줍니다.
- ```bash
  pip install -r requirements.txt
  ```
- <img width="1264" alt="image" src="https://user-images.githubusercontent.com/47103479/236681781-967022f9-e02f-4d9e-8f6d-4bc23fc4525a.png">
- producer python 스크립트 파일을 실행합니다.
- ```bash
  python producer.py
  ```
