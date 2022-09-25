WITH 

sla_list as

(select event_name from sla_ref)

SELECT 
    user_id
   ,event_name
   ,count(*) event_count

FROM `lok-home-challenge.lok.front_end_events`

where event_name in sla_list
and TIME_DIFF(NOW(), time, MINUTE) <=7.2

group by user_id, event_id
having count(*) >= 5