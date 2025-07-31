-- models/example.sql

with source as (
    select 1 as id, 'hello_dbt' as message
)

select * from source
