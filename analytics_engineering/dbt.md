# Analytics Engineering
- 분석 엔지니어의 요구 스택 
  - 데이터 스토리지 : 데이터 웨어하우징, Azure Blob Storage, Amazon S3 또는 Google Cloud Storage와 같은 클라우드 스토리지 시스템.
  - 데이터 처리 : Apache Hadoop, Apache Spark, Apache Flink.
  - 프로그래밍 언어 : Python, SQL, Java.
  - 데이터 분석 라이브러리 : Pandas, Numpy, Matplotlib 등
  - 데이터 시각화 : Tableau, Power BI, QlikView, Looker.
  - 협업 및 프로젝트 관리 : Azure DevOps, Github, JIRA, Confluence, Asana.
  - 데이터 수집 : Apache NiFi, Apache Airflow, Prefect, Talend.

# dbt
- ![image](https://user-images.githubusercontent.com/47103479/233097856-1c204bec-732b-4b12-bec3-4ac75f8a8c7e.png)
- dbt(Data Build Tool)는 개발자가 BigQuery, Snowflake, Redshift 등과 같은 최신 데이터 웨어하우스에서 변환을 정의, 오케스트레이션 및 실행할 수 있도록 하여 데이터 모델 구축을 간소화하는 Python 오픈 소스 라이브러리입니다. 
- ETL/ELT 프로세스의 T에 초점을 맞춘 거버넌스 도구라고 말할 수 있습니다. 이를 통해 SQL에서 모든 데이터 변환을 중앙 집중화하고 구축하여 재사용 가능한 모듈(모델)로 구성할 수 있습니다 
- 소프트웨어 엔지니어링 관행에서 영감을 받아 검증 테스트를 만들고 데이터 파이프라인에서 전체 CI/CD 주기를 구현할 수 있습니다. 
- dbt의 주요 기능
  - 코드 재사용 : 데이터 모델의 정의 및 패키지의 변환 구성을 허용합니다.
  - 품질 검사에 대한 강조 – 데이터 품질을 보장하고 변환 오류를 방지하기 위해 자동화된 테스트의 사용을 권장합니다.
  - 버전 제어 및 협업 – Git, Bitbucket 등과 같은 버전 제어 시스템과 함께 작동하도록 설계되어 변경 사항을 쉽게 추적하고 개발 파이프라인에서 협업할 수 있습니다.
  - 확장성 – BigQuery, Snowflake, Redshift 등과 같은 최신 데이터 웨어하우스와 함께 작동하도록 설계되어 대용량 데이터 처리를 쉽게 확장할 수 있습니다.
- dbt 사용
  - dbt Core: 로컬 또는 자체 서버에 설치된 오픈 소스 버전입니다. CLI 콘솔을 통해 이루어집니다.
  - dbt Cloud: Core 버전에 추가 기능(실행 예약, BI, 모니터링 및 경고)을 제공하는 클라우드(SaaS)에서 호스팅되는 플랫폼입니다. GUI가 있어 사용하기가 더 쉽습니다. 유료 요금제 외에도 개발자를 위한 제한된 무료 버전을 제공합니다.

# dbt cloud 
- dbt[https://www.getdbt.com/pricing/]에 신규 프로젝트를 만듭니다.
- ![image](https://user-images.githubusercontent.com/47103479/233101912-b6613f73-3fff-4a20-ab1e-70d4d054153d.png)
- gcp iam의 service account에서 json키를 업로드 해줍니다.
  - ![image](https://user-images.githubusercontent.com/47103479/233103124-b7a01dc8-9cca-44f9-bb35-b56aaa46d99c.png)
  - ![image](https://user-images.githubusercontent.com/47103479/233103336-0441da19-c413-4d2c-841e-0e03b361ce5a.png)
- github의 리지스토리를 추가해줍니다.
  - > ssh-keygen -t rsa : 터미널 명령어를 입력해서 키를 생성해줍니다.
  - > cat {키이름}.pub : 위에서 생성된 키 식을 복사합니다.
    - <img width="910" alt="image" src="https://user-images.githubusercontent.com/47103479/233106405-a3aff6e8-007f-4206-8e6d-8298470f1bb8.png">
  - 설정에서 Deploy keys를 추가해주고 write access 허용을 해줍니다.
  - ![image](https://user-images.githubusercontent.com/47103479/233104213-3cc78293-5f1e-4205-b684-ac6858702800.png)
  - ![image](https://user-images.githubusercontent.com/47103479/233103602-0e7cb240-b9e6-4f99-b5d3-e02d828fe9aa.png)
  - ![image](https://user-images.githubusercontent.com/47103479/233107844-a427547a-19b9-4b93-9b88-fb9257d9d196.png)

