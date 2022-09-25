SELECT 
    DISTINCT event_name

FROM `lok-home-challenge.lok.front_end_events`

WHERE event_name in ('time_out', 'error_404')