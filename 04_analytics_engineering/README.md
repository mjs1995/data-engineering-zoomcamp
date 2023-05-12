# 가이드 
- [dbt.md](dbt.md) : 프로젝트 구축에 대한 가이드
- [dbt 개요](https://github.com/mjs1995/muse-data-engineer/blob/main/doc/workflow/dbt_base.md) : dbt에 대한 설명 

# 사전 준비
- 구글 빅쿼리 또는 PostgreSQL과 같은 데이터 웨어하우스를 운영하고 있어야 합니다.
- [데이터](https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page)
  - Yellow taxi data - 2019년과 2020년
  - Green taxi data - 2019년과 2020년
  - FHV(For Hire Vehicle) 데이터 - 2019년

# 워크플로우
- ![image](https://user-images.githubusercontent.com/4315804/148699280-964c4e0b-e685-4c0f-a266-4f3e097156c9.png)

# dbt 프로젝트 
- ![image](https://user-images.githubusercontent.com/4315804/152691312-e71b56a4-53ff-4884-859c-c9090dbd0db8.png)
- 이 프로젝트는 [dbt starter project](https://github.com/dbt-labs/dbt-starter-project)를 기반으로 합니다.
  - dbt init
  - dbt run
  - dbt test
- 파일
  - dbt_project.yml: dbt 프로젝트를 구성하는 파일 
  - models, seeds, macros 폴더 아래의 *.yml 파일: 문서화 파일
  - seeds 폴더의 csv 파일: 소스 데이터
  - models 폴더 내부의 파일: sql 파일에는 staging, core, datamarts 모델을 실행하기 위한 스크립트가 포함되어 있습니다. 모델의 구조 staging -> core -> datamarts

# 프로젝트 실행
- 필요한 도구들을 설치하고 해당 레포지토리를 복제합니다.
- `$ cd [..]/taxi_rides_ny` : 커맨드 라인에서 프로젝트 디렉토리로 이동합니다.
- `$ dbt seed` : CSV 파일들을 데이터베이스에 로드합니다. 이 작업은 CSV 파일들을 타겟 스키마의 테이블로 구성합니다.
- `$ dbt run` : 모델을 실행합니다.
- `$ dbt test` : 데이터를 테스트합니다. 3개의 단계를 한번에 실행하려면 `$ dbt build`를 사용할 수 있습니다.
- `$ dbt docs generate` : 프로젝트 문서를 생성합니다.
- `$ dbt docs serve` : 프로젝트 문서를 확인합니다. 이 단계는 문서 페이지를 웹서버에서 열지만 http://localhost:8080에서도 확인할 수 있습니다.

# Lookerstudio
- ![image](https://user-images.githubusercontent.com/47103479/234604394-9ac12a2a-9076-4b2a-bb4b-61b83611b0c6.png)
