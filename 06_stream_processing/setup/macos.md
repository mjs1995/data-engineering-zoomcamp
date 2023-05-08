# macos 환경 설정 
## java 설치
- homebrew 완료되었지만 "Warning: /opt/homebrew/bin is not in your PATH"와 같은 경고가 표시되었다면, Homebrew를 실행하기 위해 쉘 환경 변수에 경로를 추가해야 합니다.
- ```bash
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
  ```
- java 설치 
- ```bash
  xcode-select –install
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  brew install java
  ```
- 다음 환경 변수를 .bash_profile 또는 .zshrc에 추가합니다.
- ```bash
  export JAVA_HOME=/usr/local/Cellar/openjdk@11/11.0.12
  export PATH="$JAVA_HOME/bin/:$PATH"
  ```
- java가 설치된 위치 확인
- ```bash
  brew info java
  ```
- <img width="879" alt="image" src="https://user-images.githubusercontent.com/47103479/236845717-994f7ca7-22e8-4c97-b33f-f57dadcc9dcd.png">
- java 버전을 확인해 줍니다.
- ```bash
  java -version
  ```
- <img width="936" alt="image" src="https://user-images.githubusercontent.com/47103479/236847717-e245e5a2-e66e-4423-8b0d-d061f41d5df8.png">

## spark 설치
- 스칼라를 설치합니다.
- ```bash
  brew install scala
  ```
- <img width="1353" alt="image" src="https://user-images.githubusercontent.com/47103479/236845646-da58b016-32a0-4ea3-9186-a56961c06193.png">
- 아파치 스파크를 설치합니다.
- ```bash
  brew install apache-spark
  ```
- <img width="1365" alt="image" src="https://user-images.githubusercontent.com/47103479/236846003-0cf134bb-7efb-4327-aa66-639856db49a0.png">
- 환경 변수에 추가해 줍니다.
- ```bash
  export SPARK_HOME=/usr/local/Cellar/apache-spark/3.2.1/libexec
  export PATH="$SPARK_HOME/bin/:$PATH"
  ```