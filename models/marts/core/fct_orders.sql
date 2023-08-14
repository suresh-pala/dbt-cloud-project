with orders as
(
    select * from {{ref('stg_payments')}}
)
select
    order_id,
    customer_id,
    amount

from orders