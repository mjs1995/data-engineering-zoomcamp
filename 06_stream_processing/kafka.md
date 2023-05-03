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
  ```
- <img width="763" alt="image" src="https://user-images.githubusercontent.com/47103479/235941711-c3a0f999-3037-4374-b4ad-0aab72194208.png">
- Kafka 및 Spark 컨테이너를 시작합니다.
- ```bash
  docker compose up -d
  ```
- | Application     | URL                                      | Description                                                |
  | --------------- | ---------------------------------------- | ---------------------------------------------------------- |
  | JupyterLab      | [localhost:8888](http://localhost:8888/) | Cluster interface with built-in Jupyter notebooks          |
  | Spark Master    | [localhost:8080](http://localhost:8080/) | Spark Master node                                          |
  | Spark Worker I  | [localhost:8083](http://localhost:8081/) | Spark Worker node with 1 core and 512m of memory (default) |
  | Spark Worker II | [localhost:8084](http://localhost:8082/) | Spark Worker node with 1 core and 512m of memory (default) |
- ![image](https://user-images.githubusercontent.com/47103479/235942450-d26c8cc5-1450-4291-ae3d-ca83ddcded8f.png)
- ![image](https://user-images.githubusercontent.com/47103479/235942665-a5100a95-1860-42f2-84e8-c4b0f29dd0d1.png)
