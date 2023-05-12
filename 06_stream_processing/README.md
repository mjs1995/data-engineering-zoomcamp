# 가이드
- [kafka.md](kafka.md) : 프로젝트 구축에 대한 가이드

# Python Stream Processing
- 다양한 파이썬 라이브러리(`kafka-python`,`confluent-kafka`,`pyspark`)를 사용한 스트림 처리에 대해 진행하였습니다.
- 파이썬 모듈의 구성입니다.

## Running Spark and Kafka Clusters on Docker
- Docker 모듈은 Kafka와 Spark를 도커 컨테이너에서 실행하기 위한 Dockerfile 및 docker-compose 정의입니다. 
- 필요한 서비스를 설정하는 것은 다음 모듈을 실행하기 전에 사전 요구 사항입니다.
- Spark 이미지 빌드하기
- ```bash
  # Build Spark Images
  ./build.sh
  ```
- Docker 네트워크 및 볼륨 생성
- ```bash
  # Create Network
  docker network  create kafka-spark-network

  # Create Volume
  docker volume create --name=hadoop-distributed-file-system
  ```
- Docker에서 서비스 실행하기
- ```bash
  # Start Docker-Compose (within for kafka and spark folders)
  docker compose up -d
  ```
- Docker에서 서비스 중지하기
- ```bash
  # Stop Docker-Compose (within for kafka and spark folders)
  docker compose down
  ```
- 삭제하기
- ```bash
  # Delete all Containers
  docker rm -f $(docker ps -a -q)

  # Delete all volumes
  docker volume rm $(docker volume ls -q)
  ```

## PySpark Streaming
- 도커 볼륨과 네트워크 확인
- ```bash
  docker volume ls # hadoop-distributed-file-system
  docker network ls # kafka-spark-network
  ```
- 프로듀서 스크립트 실행
- ```bash
  python producer.py
  ```
- 컨슈머 스크립트 실행
- ```bash
  python consumer.py
  ```
- Streaming 스크립트 실행
- ```bash
  ./spark-submit.sh streaming.py 
  ```