# 가이드 
- [prefect_gcp.md](https://github.com/mjs1995/data-engineering-zoomcamp/blob/main/02_workflow_orchestration/prefect_gcp.md) : 프로젝트 구축에 대한 가이드 
- [prefect 개요](https://github.com/mjs1995/muse-data-engineer/blob/main/doc/workflow/prefect_base.md) : prefect에 대한 설명 

# Prefect
- `Prefect` : 데이터 파이프라인 관리 도구로, ETL, ML, 데이터 엔지니어링 작업 등 다양한 작업을 관리하고 스케줄링할 수 있다.
- `Installing Prefect` : Prefect를 설치하는 과정으로, pip을 이용하여 설치할 수 있다.
- `Prefect flow` : Prefect에서 실행되는 단일 작업 유닛으로, 여러 작업(task)들의 조합으로 구성된다.
- `Creating an ETL` : Extract, Transform, Load 작업을 구성하는 것으로, 데이터를 추출하고 전처리한 후 목적에 맞게 저장하는 작업이다.
- `Prefect task` : Prefect flow 안에서 실행되는 각각의 작업 단위를 의미한다.
- `Blocks and collections` : Prefect에서 제공하는 데이터 파이프라인을 구성하는 블록들과 이들을 조합한 데이터 컬렉션을 의미한다.
- `Orion UI` : Prefect의 시각화 도구로, 실행 중인 파이프라인의 상태를 실시간으로 모니터링하고 다양한 정보를 확인할 수 있다.

# Flow 
- GCP 및 Prefect를 이용한 ETL
- 구글 클라우드 스토리지(Google Cloud Storage)에서 빅쿼리(BigQuery)로 데이터 이전을 위한 ETL 작업
- Flow의 파라미터화 및 배포 - Flow를 파라미터화하고 배포를 위해 도커(Docker) 이미지를 사용합니다.
- 스케줄과 인프라 관리를 위한 스토리지 - Flow 실행 스케줄과 인프라 관리를 위해 도커 스토리지를 사용합니다.
