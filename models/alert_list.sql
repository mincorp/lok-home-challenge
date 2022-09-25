select 
    sla_events.user_id
   ,top_team_owners.team_id
   ,sla_events.event_name
   ,sla_events.event_count
   
from sla_events

inner join top_team_owners
on sla_events.user_id = top_team_owners.user_id

order by top_team_owners.customer_rank, sla_events.event_count desc