with 

customers as (
    SELECT 
    team_id
   ,JSON_EXTRACT_SCALAR(metadata, '$.amount_raised') AS revenue 

FROM `lok-home-challenge.lok.teams`

where cancelled_at is null
)

SELECT
    customers.*
   ,RANK() OVER(order by revenue desc) customer_rank

FROM customers

ORDER BY customer_rank