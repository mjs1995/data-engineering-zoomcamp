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
- Initialize dbt project 눌러서 프로젝트를 초기화합니다.
  - ![image](https://user-images.githubusercontent.com/47103479/233840151-e61dfd03-c89a-4e5b-9bbe-402477d23d65.png)
- schema.yml 파일에는 버전, 소스 이름, 데이터베이스, 스키마 및 테이블이 포함되어 있습니다. yml 파일을 이용해서 단일 위치에서 모든 모델에 대한 연결을 변경할 수 있습니다.
  - ![image](https://user-images.githubusercontent.com/47103479/233846968-03bd4d2c-744e-43ca-a417-03bfa44a8e7b.png)
  - ```yml
    version: 2

    sources:
        - name: staging
          database: dtc-de-382512
          schema: trips_data_all

          tables:
              - name: green_tripdata
              - name: yellow_tripdata
    ```
  - ```sql
    {{ config(materialized='table') }}

    SELECT *
    FROM {{ source('staging','green_tripdata') }}
    ```
  - ![image](https://user-images.githubusercontent.com/47103479/233847108-5f702ea6-814f-4798-b3f5-1f4106aef6fc.png)
- Macros
  - ```sql
    {{ config(materialized='table') }}

    SELECT 
        case payment_type
            when 1 then 'Credit card'
            when 2 then 'Cash'
            when 3 then 'No charge'
            when 4 then 'Dispute'
            when 5 then 'Unknown'
            when 6 then 'Voided trip'
        end as payment_type_description
    FROM {{ source('staging','green_tripdata') }}
    WHERE vendorid is not null
    ```
  - ![image](https://user-images.githubusercontent.com/47103479/233992835-05408372-cab6-477c-b41e-afafc8b7f870.png)
  - payment_type 의 값을 매개변수로 받고 해당 값을 반환 하는 것을 확인 하는 get_payment_type_description 매크로를 만듭니다.
  - ```sql
     {#
    This macro returns the description of the payment_type 
    #}

    {% macro get_payment_type_description(payment_type) -%}

        case {{ payment_type }}
            when 1 then 'Credit card'
            when 2 then 'Cash'
            when 3 then 'No charge'
            when 4 then 'Dispute'
            when 5 then 'Unknown'
            when 6 then 'Voided trip'
        end

    {%- endmacro %}
    ```
  - ```sql
    {{ config(materialized='table') }}

    SELECT 
        {{ get_payment_type_description('payment_type') }} as payment_type_description
    FROM{{ source('staging','green_tripdata') }}
    WHERE vendorid is not null
    ```
  - ![image](https://user-images.githubusercontent.com/47103479/233994947-9e697e51-2292-4337-8ee7-9f8bbc45674d.png)
- packages
  - 다른 프로그래밍 언어의 라이브러리나 모듈과 유사하게 서로 다른 프로젝트 간에 매크로를 재사용할 수 있습니다. 
  - 프로젝트에서 패키지를 사용하려면 dbt 프로젝트의 root 디렉토리에 packages.yml 구성 파일을 생성해야 합니다.
  - ```yml
    packages:
      - package: dbt-labs/dbt_utils
        version: 0.8.0
    ```
  - > dbt deps : 프로젝트 내 패키지의 모든 종속성 및 파일을 다운로드하는 명령을 실행합니다. 완료되면 프로젝트에 dbt_packages/dbt_utils 디렉토리가 생성됩니다
    - ![image](https://user-images.githubusercontent.com/47103479/233995888-3eb1f76f-5ce8-4f77-9a42-f2135e3ae7de.png)
  - ![image](https://user-images.githubusercontent.com/47103479/233995588-4ce8dc9d-4753-4398-a3c3-d80beec700fd.png)
- Variables 
  - ```sql
    {{ config(materialized='table') }}

    SELECT *
    FROM {{ source('staging','green_tripdata') }}
    {% if var('is_test_run', default=true) %}

        limit 100

    {% endif %}
    ```
  - ![image](https://user-images.githubusercontent.com/47103479/233996540-09269444-ad3f-4603-9507-6257e39df6e7.png)
  - > dbt build --var 'is_test_run: false' : 모델을 빌드할 때 명령줄에서도 사용 가능합니다. 
  - > dbt run --var 'is_test_run: false'
  - ![image](https://user-images.githubusercontent.com/47103479/233997699-4c3c66b3-d638-4b6e-922e-da27dcbc09f8.png)
  - ![image](https://user-images.githubusercontent.com/47103479/233998047-0be1e3d6-2a15-4afd-9983-ffa8ea454674.png)
- seed
  - 시드를 생성하려면 저장소 의 /seeds 디렉토리에 CSV 파일을 업로드하고 명령을 실행하기만 하면 됩니다. 
  - dbt seed taxi_zone_lookup.csv. 실행하면 dbt seed디렉토리의 모든 CSV가 데이터베이스에 로드됩니다.
  - ![image](https://user-images.githubusercontent.com/47103479/233998864-39abdb56-c290-4c6e-bf29-03639d917bd9.png)
  - ```yaml
    seeds: 
      taxi_rides_ny:
          taxi_zone_lookup:
              +column_types:
                  locationid: numeric
    ```
  - ![image](https://user-images.githubusercontent.com/47103479/233999620-4cc70dbe-a43b-4222-89d8-e17716234ddf.png)
  - > dbt seed : dbt 프로젝트의 시드 데이터를 생성
  - ![image](https://user-images.githubusercontent.com/47103479/233999555-131ad7cb-fe85-4090-bf96-4368599ff6f0.png)
  - ![image](https://user-images.githubusercontent.com/47103479/233999795-26a01008-c9da-407b-a552-184d98344471.png)
  - > dbt seed --full-refresh : dbt 프로젝트의 시드 데이터를 다시 생성할 때 사용됩니다. --full-refresh 옵션은 시드 데이터를 완전히 새로 고침하고 기존 데이터를 모두 삭제한 후, 새로운 시드 데이터를 다시 생성
  - ![image](https://user-images.githubusercontent.com/47103479/233999991-3ec249cd-8105-4fb7-82a5-ec2323e56e8b.png)

# dbt test
- dbt 모델의 유효성을 검사하는 데 사용됩니다. dbt test는 dbt 모델이 데이터의 정합성과 일관성을 보장하는지 검증하는 데 사용되는 유용한 도구입니다.
- dbt test는 모델을 실행하기 전에 실행됩니다. 모델의 실행 결과가 올바른지 확인하고, 예상한 결과와 실제 결과가 일치하는지 검증합니다. 예를 들어, 모델이 특정 조건에 대해 올바른 값을 반환하는지 확인하거나, 특정 테이블에서 유일한 값을 가져오는지 확인할 수 있습니다.
- ```yml
  columns:
    - name: tripid
      description: Primary key for this table, generated with a concatenation of vendorid+pickup_datetime
      tests:
          - unique:
              severity: warn
          - not_null:
              severity: warn
    - name: Pickup_locationid
      description: locationid where the meter was engaged.
      tests:
        - relationships:
            to: ref('taxi_zone_lookup')
            field: locationid
            severity: warn
    - name: Payment_type 
      description: >
        A numeric code signifying how the passenger paid for the trip.
      tests: 
        - accepted_values:
            values: "{{ var('payment_type_values') }}"
            severity: warn
            quote: false
  ```
- dbt test는 모델을 실행할 때 테스트 쿼리를 실행합니다. 이 쿼리는 모델의 실행 결과를 검증하는 데 사용됩니다. 테스트 쿼리는 SQL 또는 jinja 템플릿으로 작성할 수 있습니다. dbt test는 이러한 테스트 쿼리를 실행하여 검증 결과를 반환합니다.
- ![image](https://user-images.githubusercontent.com/47103479/234008631-8c33e8be-eeb2-4aa6-a9e2-5c7da07e1c44.png)
- > dbt test --select stg_green_tripdata
- ![image](https://user-images.githubusercontent.com/47103479/234008735-22a36fe5-792d-436a-a8a1-54123a9d3fe8.png)

# Build the First dbt Models 
- dbt는 데이터베이스를 위한 오픈 소스 SQL 모델링 도구입니다. 데이터 파이프라인의 구성 요소를 버전 관리하고 테스트하고 문서화하는 데 사용할 수 있습니다.
- dbt run은 모델을 실행하는 것이며, dbt build는 모델을 실행하고 결과를 데이터베이스에 적재하는 것입니다.
- dbt run
  - dbt 프로젝트에서 정의한 SQL 모델들을 실행하는 명령어입니다.
  - 모델을 실행하면 해당 모델이 참조하는 모든 종속성이 자동으로 실행됩니다.
  - 실행 중에 발생하는 오류 및 경고를 표시합니다.
  - 명령어를 실행하면 데이터베이스에 정의된 모든 모델이 최신 상태로 업데이트됩니다.
- dbt build
  - dbt 프로젝트에서 정의한 SQL 모델들을 실행하고 결과를 데이터베이스에 적재하는 명령어입니다.
  - 실행 중에 발생하는 오류 및 경고를 표시합니다.
  - 명령어를 실행하면 데이터베이스에 정의된 모든 모델이 최신 상태로 업데이트되며, 이전 결과가 삭제되고 새로운 결과가 적재됩니다.
- dbt 모델의 fact_trips 의 계보를 확인 하고 소스 레이어에서 스테이징 및 마지막으로 최종 테이블까지의 flow를 확인합니다.
- ![image](https://user-images.githubusercontent.com/47103479/234006306-61d24570-439c-4577-a5fe-f6eac9ec7bdb.png)
- > dbt run 
  - ![image](https://user-images.githubusercontent.com/47103479/234007809-8bbb31bb-5eea-4699-970f-d5c4be0140b3.png)
- > dbt build 
  - ![image](https://user-images.githubusercontent.com/47103479/234007938-9ebceba9-3948-4134-80e1-4494405d91cf.png)
- ![image](https://user-images.githubusercontent.com/47103479/234008091-749da201-1465-4f6e-b43c-274987163538.png)

# Deployment Using dbt Cloud
- ![image](https://user-images.githubusercontent.com/47103479/234021073-ab0ff278-e5ae-4a49-b8c3-1b9a836daf4e.png)
- [dbt](https://www.getdbt.com/product/what-is-dbt/)를 사용하면 CI/CD를 구성하여 모델을 프로덕트에 배포 할 수 있습니다. 
- 개발 환경과 배포 환경을 분리하면 프로덕트에 영향을 주지 않고 모델을 구축하고 테스트할 수 있습니다. 
- ![image](https://user-images.githubusercontent.com/47103479/234029918-54cfe32a-ea67-4d66-a0d3-fcc6a7d5ab12.png)
- 신규 job을 생성해줍니다.
  - ![image](https://user-images.githubusercontent.com/47103479/234030487-079cc1bf-bf02-4bfc-967a-495feba3483c.png)
  - ![image](https://user-images.githubusercontent.com/47103479/234030607-68244a8e-8965-499d-adc3-10ea5bfd2ab9.png)
  - ![image](https://user-images.githubusercontent.com/47103479/234030829-1acbbdc7-c4c5-41ab-b7e3-efe33808eb9e.png)
  - ![image](https://user-images.githubusercontent.com/47103479/234030887-8cd6d83d-e4f3-4510-8083-3614017eb611.png)
- ![image](https://user-images.githubusercontent.com/47103479/234595602-2941d542-4b67-4352-9ac7-73daf0446378.png)
- ![image](https://user-images.githubusercontent.com/47103479/234595934-269e97c2-1e25-4b3f-bbe5-02a11aebe341.png)
- ![image](https://user-images.githubusercontent.com/47103479/234021073-ab0ff278-e5ae-4a49-b8c3-1b9a836daf4e.png)

# 구글 데이터 스튜디오
- https://lookerstudio.google.com/u/1/navigation/reporting
- 사용자가 Google Analytics, Google Ads, Google Sheets, 데이터베이스 등과 같은 여러 데이터 소스에 연결하여 보고서를 생성할 수 있는 Looker Studio 기반 데이터 시각화 및 보고 도구입니다
- 데이터 소스
  - 데이터 소스 만들기를 선택한 후에 BigQuery를 선택합니다.
  - ![image](https://user-images.githubusercontent.com/47103479/234596548-f22f48d5-7332-4f1b-9fe1-fede19c4ad93.png)
  - ![image](https://user-images.githubusercontent.com/47103479/234597077-0ab75e04-ae2d-4112-a78a-b69548a04d47.png)
  - 데이터 소스로 사용할 테이블을 선택합니다.
  - ![image](https://user-images.githubusercontent.com/47103479/234597781-cde821cf-e2a3-4e35-84ed-78bb9e9b1128.png)
  - ![image](https://user-images.githubusercontent.com/47103479/234598160-cdc4107e-4bc9-4862-a705-2bd5987101c3.png)
- 보고서 만들기
  - ![image](https://user-images.githubusercontent.com/47103479/234598505-2fe036d1-ca5c-42e6-a3b8-f0b4a3f3d933.png)
  - 차트를 추가해줍니다.
    - ![image](https://user-images.githubusercontent.com/47103479/234598894-41608977-dce6-4eb8-9b6b-90d6d1c4e22a.png)
    - ![image](https://user-images.githubusercontent.com/47103479/234599212-ed3fa6f8-941e-414f-8a19-7c497c779d89.png)
  - 컨트롤 추가에서 기간 컨트롤을 추가해줍니다.
    - ![image](https://user-images.githubusercontent.com/47103479/234599391-e0a9fe52-6fb8-487a-b363-0abf0585c0cf.png)
  - 계산된 필드를 만들어줍니다.
    - ![image](https://user-images.githubusercontent.com/47103479/234602984-0fae4c2b-fe17-4a97-871e-77a492a7900c.png)
- ![image](https://user-images.githubusercontent.com/47103479/234604394-9ac12a2a-9076-4b2a-bb4b-61b83611b0c6.png)
