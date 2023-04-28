# GCP 환경 세팅
- 프로젝트 생성
  - ![image](https://user-images.githubusercontent.com/47103479/229352920-8d1b9d59-e73d-4049-a769-850fd3919714.png)
## SSH gen
- 참고 링크 : https://cloud.google.com/compute/docs/connect/create-ssh-keys?hl=ko
- > ssh-keygen -t rsa -f ~/.ssh/KEY_FILENAME -C USERNAME -b 2048
- > ssh-keygen -t rsa -f ~/.ssh/gcp -C mjs -b 2048
- <img width="457" alt="image" src="https://user-images.githubusercontent.com/47103479/229353806-4067a032-12a9-48f1-bd95-fbf383f93c33.png">

## Compute Engine
- ![image](https://user-images.githubusercontent.com/47103479/229353825-0092dfe0-6f19-415b-b0c2-3849cd6a389b.png)
- > cat gcp.pub - ssh-rsa 코드를 metadata에 추가해줍니다.
- <img width="1000" alt="image" src="https://user-images.githubusercontent.com/47103479/229353888-2b86ae02-6ea9-4b6b-919f-f41f12dce9f8.png">
- ![image](https://user-images.githubusercontent.com/47103479/229353963-8ff825dc-9b5f-4e62-99aa-e842c6b6e897.png)

## VM 인스턴스 
- ![image](https://user-images.githubusercontent.com/47103479/229354283-3037e6db-78f4-49ba-b68e-aec828be87e1.png)
- 부팅 디스크 변경
  - ![image](https://user-images.githubusercontent.com/47103479/229354534-53abe986-95b0-4eb6-95a1-7eafc7dce109.png)
- > ssh -i ~/.ssh/gcp {ssh키 생성시 입력한 ID}@{VM 생성시 외부IP}
- > htop : 연결 확인
  - <img width="733" alt="image" src="https://user-images.githubusercontent.com/47103479/229354960-f5e4cfc5-09c2-4f27-9c11-44e9eee4d536.png">
- <img width="251" alt="image" src="https://user-images.githubusercontent.com/47103479/229355004-901e04f2-da52-44f9-9694-a96a0e44c30b.png">  
- 인스턴스를 사용하지 않을 때는 중지하기 

## 아나콘다 설치
- https://www.anaconda.com/products/distribution#Downloads
- > wget https://repo.anaconda.com/archive/Anaconda3-2023.03-Linux-x86_64.sh
- <img width="1007" alt="image" src="https://user-images.githubusercontent.com/47103479/229355137-5d3106ed-e3c0-4998-a7e9-a51f8ce470ed.png">
- > bash Anaconda3-2023.03-Linux-x86_64.sh 
  - Enter를 누른뒤에 yes입력
  - <img width="582" alt="image" src="https://user-images.githubusercontent.com/47103479/229355246-220802cd-8573-4f21-9bf6-0f0b5aced5e1.png">
- > touch config : config 파일 생성 
- > code config : 코드 위치 열기 
- <img width="264" alt="image" src="https://user-images.githubusercontent.com/47103479/229355482-5343483e-3daf-4fe1-b175-cd105e96d393.png">
- <img width="270" alt="image" src="https://user-images.githubusercontent.com/47103479/229355563-97d1dc67-fd56-4a89-ac5f-886f5cae3aa3.png">
- <img width="381" alt="image" src="https://user-images.githubusercontent.com/47103479/229355700-cf8f555e-484d-4735-a731-4e82a9394145.png">
- <img width="358" alt="image" src="https://user-images.githubusercontent.com/47103479/229355763-14b60cb3-7415-4dbb-a1cd-00bf3f3cb8df.png">
- <img width="577" alt="image" src="https://user-images.githubusercontent.com/47103479/229355817-c5ddbe79-a94a-4ede-9718-e26b0281732b.png">

## 도커 설치 
- <img width="891" alt="image" src="https://user-images.githubusercontent.com/47103479/229355873-e5f35a9a-3bbb-43ab-92c9-790e501fd4b0.png">
- <img width="995" alt="image" src="https://user-images.githubusercontent.com/47103479/229355912-2bf541d8-5e40-40e5-aa53-edefb7957285.png">
- <img width="926" alt="image" src="https://user-images.githubusercontent.com/47103479/229355953-7c458a47-395a-448a-9868-4d98aac2a78d.png">
- <img width="594" alt="image" src="https://user-images.githubusercontent.com/47103479/229356047-1b66be67-05fe-4357-a779-656e52220980.png">
- <img width="594" alt="image" src="https://user-images.githubusercontent.com/47103479/229356070-a929a531-9a62-4ba8-8305-2821fb99ddee.png">
- <img width="355" alt="image" src="https://user-images.githubusercontent.com/47103479/229356159-d532ffc3-28fa-4343-b4ab-f62ef38c60d9.png">

## Git 
- > git clone https://github.com/DataTalksClub/data-engineering-zoomcamp.git
  - <img width="623" alt="image" src="https://user-images.githubusercontent.com/47103479/229356500-6fdfec98-3590-4b1f-98cc-aff94d745b97.png">
- <img width="1000" alt="image" src="https://user-images.githubusercontent.com/47103479/229356551-a4fcc8c2-f5ec-40fc-81a8-b60d55e641e0.png">
- sudo 명령어 없이 도커 명령어 쓰기
  - https://github.com/sindresorhus/guides/blob/main/docker-without-sudo.md
  - <img width="340" alt="image" src="https://user-images.githubusercontent.com/47103479/229356827-aebf0346-8ff5-4b8d-92c2-54081ced0b2f.png"> 
- exit 후에 다시 ssh de-zoomcamp로 로그인해서 명령어를 실행하면 sudo 권한없이 잘 실행된다.
- <img width="660" alt="image" src="https://user-images.githubusercontent.com/47103479/229356791-a7830a9c-55e3-4ed1-831e-db8e9ebd600c.png">

## Docker Compose
- https://github.com/docker/compose/releases
- https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64
- ![image](https://user-images.githubusercontent.com/47103479/229358848-eab3a5a6-34a7-4859-9363-4e195626b5f1.png)
- > mkdir bin
- > cd bin
- > wget https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64 -O docker-compose
- > chmod +x docker-compose : 실행 가능한 파일로 변경
- > ./docker-compose version 
  - <img width="311" alt="image" src="https://user-images.githubusercontent.com/47103479/229359320-7932d743-c27b-4752-b8a0-cc6236823f68.png">
- mac에서 ctrl+v 로 맨 끝으로 이동 후 경로를 추가해주기
  - > export PATH="${HOME}/bin:${PATH}"
  - <img width="966" alt="image" src="https://user-images.githubusercontent.com/47103479/229359427-208ab442-7d62-4d63-a738-8d6bc283b04f.png">
  - ctrl+o로 저장후 Enter를 치고 ctrl+x 로 나오기 
  - > source .bashrc : 변경 사항 반영 
  - <img width="268" alt="image" src="https://user-images.githubusercontent.com/47103479/229359642-790ee114-7adc-4eca-94c4-fd8b455577e6.png">
- > cd data-engineering-zoomcamp/week_1_basics_n_setup/2_docker_sql/
- > docker-compose up -d
- <img width="1005" alt="image" src="https://user-images.githubusercontent.com/47103479/229509119-9c3e184e-37ce-4ddf-8599-581138a1e51f.png">
- > docker ps
- 새로운 창에서 pgcli를 설치합니다.
  - > cd data-engineering-zoomcamp/
  - > pip install pgcli
  - > pgcli -h localhost -U root -d ny_taxi
  - <img width="1002" alt="image" src="https://user-images.githubusercontent.com/47103479/229510321-8ee4ecff-ac7a-4e0c-bd10-4640650caa1d.png">
  - 에러가 발생하여 해결하기 위해 psycopg-binary 라이브러리를 설치하고 다시 root로 로그인합니다.
  - > pip install psycopg-binary
  - <img width="852" alt="image" src="https://user-images.githubusercontent.com/47103479/229510580-4878b760-65fd-44f0-869e-08a55462f244.png">
  - <img width="297" alt="image" src="https://user-images.githubusercontent.com/47103479/229511915-81151ff1-e799-4de9-8653-b11fef122a6d.png">
- > pip uninstall pgcli
- > conda install -c conda-forge pgcli
  - <img width="584" alt="image" src="https://user-images.githubusercontent.com/47103479/229512237-e8aa42f2-d5c0-4367-bb9c-e74ea59d096e.png">
  - 여기서 더 이상 넘어가지 않고 failed with initial frozen solve. Retrying with flexible solve 에러가 발생했습니다.
  - <img width="489" alt="image" src="https://user-images.githubusercontent.com/47103479/229513238-2f8392fc-8505-4ffd-b262-eb25a8445a0c.png">
  - conda로 패키지를 다운받을 때 최신 버전이 아니여서 생기는 에러중 하나였습니다.
  - > conda update --all
  - > conda install -c conda-forge pgcli
  - <img width="630" alt="image" src="https://user-images.githubusercontent.com/47103479/229517693-2d722e14-95a5-438d-9109-29892be5224f.png">
  - > pgcli -h localhost -U root -d ny_taxi 
  - 이제 아무 문제 없이 잘 작동하는걸 확인할 수 있습니다.
  - <img width="488" alt="image" src="https://user-images.githubusercontent.com/47103479/229517940-a4b8a42e-766e-43e3-8a93-a13618ea7127.png">

## 로컬 머신에서 포트 포워딩 
- VM과 연결되어있는 vscode에서 ctrl+`로 터미널을 엽니다.
- 5432 포트와 8080 포트를 열어줍니다.
- <img width="938" alt="image" src="https://user-images.githubusercontent.com/47103479/229526943-dcb9795c-41a3-4737-83d2-bcf33b2a653e.png">
- 관련해서 터미널의 pgcli와 localhost:8080가 잘 연결되는지 확인합니다.
- <img width="461" alt="image" src="https://user-images.githubusercontent.com/47103479/229527189-68bba8fa-b360-4d5b-bfc9-149a92e2386c.png">
- ![image](https://user-images.githubusercontent.com/47103479/229527074-55af4b01-c9e9-488a-8a41-484111feac23.png)

## Jupyter Notebook 
- > pip install jupyter notebook
- 8888 포트를 열어줍니다.
- <img width="989" alt="image" src="https://user-images.githubusercontent.com/47103479/229528510-39ffd1c9-6d95-4cc7-bf15-163f39068842.png">
- > wget https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2022-01.parquet : 원본 데이터를 다운로드 받습니다.
- <img width="1001" alt="image" src="https://user-images.githubusercontent.com/47103479/229529046-09efe374-e068-4f46-9e69-ac1c1986dbff.png">
- jupyter notebook에서 필요한 라이브러리들을 설치합니다.
  - ![image](https://user-images.githubusercontent.com/47103479/229531278-72dc9911-7c81-496a-b9a1-1740274a823c.png)
  - ![image](https://user-images.githubusercontent.com/47103479/229531495-1f383a57-54d3-48fd-866b-d09a75cf4fb1.png)
- 주피터 노트북에서 postgreSQL로 table을 생성하고 데이터를 인입합니다.
- <img width="518" alt="image" src="https://user-images.githubusercontent.com/47103479/229539313-2631426e-84b9-4b53-ba8a-1edad1b0b65b.png">

## Terraform 설치
- https://developer.hashicorp.com/terraform/downloads
- ![image](https://user-images.githubusercontent.com/47103479/229540760-8a34c8e1-dbb0-4742-8914-45eb7e4ea5c9.png)
- <img width="990" alt="image" src="https://user-images.githubusercontent.com/47103479/229541013-ba48e94b-d962-4132-847c-c9194580029f.png">
- > cd bin/
- > wget https://releases.hashicorp.com/terraform/1.4.4/terraform_1.4.4_linux_amd64.zip
- > sudo apt-get install unzip
- > unzip terraform_1.4.4_linux_amd64.zip
  - <img width="997" alt="image" src="https://user-images.githubusercontent.com/47103479/229541531-1f7cd72f-c021-468f-87c7-27d330709883.png">
- > rm terraform_1.4.4_linux_amd64.zip
- > terraform --version : 테라폼 버전을 확인해서 설치가 잘 되었는지 확인합니다.
- <img width="274" alt="image" src="https://user-images.githubusercontent.com/47103479/229542242-f07ed9ce-cbbb-4725-8a3e-1f8cc4a8ce4f.png">

## sftp 설정 
- IAM 서비스계정 생성
  - dtc-de-user 계정 이름으로 뷰어 생성
  - 키 관리에서 JSON 키추가
  - ![image](https://user-images.githubusercontent.com/47103479/229353141-2de9d376-59c3-4209-9eef-f42615ec9795.png)
  - ![image](https://user-images.githubusercontent.com/47103479/229353167-1c8e5f63-8021-4907-b687-b9b0e24311ec.png)
  - 위에서 받은 .JSON 파일을 ny-rides.json으로 변경해줍니다.
- VM인스턴스에 연결을 하려고 했는데 Google Compute Engine ssh: connect to host <IP> port 22: Operation timed out 에러가 발생하였다.
  - <img width="550" alt="image" src="https://user-images.githubusercontent.com/47103479/229796819-7543cedd-62b7-4d65-ae15-708e66020d5b.png">
  - https://serverfault.com/questions/953290/google-compute-engine-ssh-connect-to-host-ip-port-22-operation-timed-out
  - vm 인스턴스를 종료한 뒤에 수정을 누르고 자동화 부분에 해당 코드를 입력하고 인스턴스를 다시 시작합니다.
  - ![image](https://user-images.githubusercontent.com/47103479/229803267-1ed30a83-47eb-4710-bba6-41b65f65c6ca.png)
  - ```shell
    #! /bin/bash
    sudo ufw allow 22
    ```
  - 이 경우에도 에러가 해결이 안될때가 있습니다.
  - > cd ~/.ssh
  - > code config
  - <img width="256" alt="image" src="https://user-images.githubusercontent.com/47103479/229808488-6dbb8811-69d4-4400-b84a-99d2233c0785.png">
  - 인스턴스 정지 후 다시 시작하면 ip가 종종 바뀌게 되는데 이때 다시 수정을 해주고 연결해봅니다.
  - <img width="638" alt="image" src="https://user-images.githubusercontent.com/47103479/229809008-a81a021f-880d-4593-971a-8ac73d3093b0.png">
- 위에서 받은 ny-rides.json 파일을 .gc 위치로 옮겨줍니다.
  - > mkdir .gc 
  - > mv ~/Downloads/ny-rides.json ~/.gc
  - <img width="332" alt="image" src="https://user-images.githubusercontent.com/47103479/229836556-6ace219e-0ff4-4e87-9e8c-96bdf793ccb1.png">
- sftp로 연결후에 파일을 업로드 해줍니다.
  - <img width="998" alt="image" src="https://user-images.githubusercontent.com/47103479/230390750-c42f8f9d-265f-4ea8-bbe2-868bf347b093.png">
- > export GOOGLE_APPLICATION_CREDENTIALS=~/.gc/ny-rides.json : VM에 있는 json 파일을 환경변수로 설정해줍니다. 
- > gcloud auth activate-service-account --key-file $GOOGLE_APPLICATION_CREDENTIALS : google cloud cli로 인증 설정을 해줍니다.
  - <img width="774" alt="image" src="https://user-images.githubusercontent.com/47103479/230391526-37c8923d-e4a4-4c25-ae93-a4fea29b28cb.png">

## Terraform 실행
- cd data-engineering-zoomcamp/week_1_basics_n_setup/1_terraform_gcp/terraform/ 에서 terraform init 명령어를 실행합니다. 
- > terraform plan 에서 GCP의 프로젝트 ID를 입력해줍니다.
  - <img width="878" alt="image" src="https://user-images.githubusercontent.com/47103479/230392756-77a22f23-c35a-412e-b84e-b4bafc937eba.png">
  - ![image](https://user-images.githubusercontent.com/47103479/230392430-2ee6a6c7-f36c-4d5a-8b15-9bfff2315b29.png)
  - 프로젝트 ID인 dtc-de를 입력하고 엔터를 누릅니다.
  - <img width="994" alt="image" src="https://user-images.githubusercontent.com/47103479/230393130-73cb3017-d72d-4815-8808-0f11d8f23b54.png">
  - variables.tf 파일을 수정해서 default값으로도 추가가 가능합니다.
  - <img width="600" alt="image" src="https://user-images.githubusercontent.com/47103479/230393989-d5dd908c-6803-44fa-b1d9-fb6e9f94abff.png">
  - region의 경우 asia-northeast3 이므로 해당 코드도 수정해 줍니다.
    - <img width="617" alt="image" src="https://user-images.githubusercontent.com/47103479/230395453-a450bf98-4a43-4c33-b132-170c47d817ca.png">
  - > terraform apply 명령을 수행합니다.
