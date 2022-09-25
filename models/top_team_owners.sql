with

owners as (
    SELECT
        user_id
       ,team_id

     FROM `lok-home-challenge.lok.users`

     where invited_by is null
)

select 
    owners.user_id
   ,top_customers.*    

from owners

inner join top_customers
on owners.team_id = top_customers.team_id