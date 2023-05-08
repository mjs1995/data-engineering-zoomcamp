# 윈도우 세팅
- [Gitbash](https://gitforwindows.org/) 를 다운로드 받습니다.
- [Java 11]([https://www.oracle.com/de/java/technologies/javase/jdk11-archive-downloads.html](https://www.oracle.com/de/java/technologies/javase/jdk11-archive-downloads.html)) 설치해줍니다. 
- ```bash
  export JAVA_HOME="/c/Program Files/Java/jdk-11"
  export PATH="${JAVA_HOME}/bin:${PATH}"
  java --version
  ```
- ```
  java 11.0.18 2023-01-17 LTS
  Java(TM) SE Runtime Environment 18.9 (build 11.0.18+9-LTS-195)
  Java HotSpot(TM) 64-Bit Server VM 18.9 (build 11.0.18+9-LTS-195, mixed mode)
  ```

# 하둡 설치  
- [hadoop-3.2.0](https://github.com/cdarlint/winutils/tree/master/hadoop-3.2.0)을 설치합니다.
- ```bash
  export HADOOP_HOME="/c/tools/hadoop-3.2.0"
  export PATH="${HADOOP_HOME}/bin:${PATH}"
  ```

# 스파크 설치 
- curl 명령어를 설치를 해준뒤에 파일 압축을 제거하고 경로를 지정해줍니다.
- ```bash
  curl -O https://dlcdn.apache.org/spark/spark-3.3.2/spark-3.3.2-bin-hadoop3.tgz

  tar xzfv spark-3.3.2-bin-hadoop3.tgz
  
  export SPARK_HOME="/c/tools/spark-3.3.2-bin-hadoop3"
  export PATH="${SPARK_HOME}/bin:${PATH}"
  ```
  - tar: tar 파일 관리를 위한 유틸리티
  - x: tar 파일을 압축 해제한다는 옵션
  - z: gzip으로 압축된 파일이라는 것을 나타내는 옵션
  - f: 다음에 나오는 이름의 파일에서 압축을 해제할 것을 지정하는 옵션
  - v: 압축 해제 과정에서 파일들의 이름을 출력하는 옵션
- spark-3.3.2-bin-hadoop3 디렉터리로 이동한 뒤에 실행합니다.
  - ```bash
    cd spark-3.3.2-bin-hadoop3
    ./bin/spark-shell.cmd
    ```
  - ![image](https://user-images.githubusercontent.com/47103479/234774557-459420f1-c51a-446e-94f8-8d36391b79be.png)

# pyspark 설치
- ```bash
  export PYTHONPATH="${SPARK_HOME}/python/:$PYTHONPATH"
  export PYTHONPATH="${SPARK_HOME}/python/lib/py4j-0.10.9-src.zip:$PYTHONPATH"
  
  setx SPARK_HOME "c:\tools\spark-3.3.2-bin-hadoop3"
  cd $SPARK_HOME/bin
  ```