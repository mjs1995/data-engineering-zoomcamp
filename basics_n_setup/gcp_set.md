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

## IAM 서비스계정 생성
- dtc-de-user 계정 이름으로 뷰어 생성
- 키 관리에서 JSON 키추가
- ![image](https://user-images.githubusercontent.com/47103479/229353141-2de9d376-59c3-4209-9eef-f42615ec9795.png)
- ![image](https://user-images.githubusercontent.com/47103479/229353167-1c8e5f63-8021-4907-b687-b9b0e24311ec.png)
