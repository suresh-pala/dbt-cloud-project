with customers as(
    select * from {{ref('stg_customers')}}
),

orders as(
    select * from {{ref('stg_orders')}}
),

customer_orders as
(
    select
        customer_id,

        min(order_date) first_order_date,
        max(order_date) most_recent_order_date,
        count(order_id) number_of_orders,
        sum(price) lifetime_value


    from orders
    group by all
),
final as
(
    select
        customers.customer_id,
        customers.customer_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders,0) number_of_orders,
        customer_orders.lifetime_value

    from customers

    left join customer_orders using (customer_id)

)

select * from final