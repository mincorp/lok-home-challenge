Take home challenge - Panagiotis Mintzas

## Design and create a model for Lokalise product teams

## 1.1 Structure

#### 1.1.1 What is the model?

Lokalise offers a guarantee for [uptime 99.5% or higher] (https://lokalise.com/pricing), meaning than in the course of a day if a customer cannot use the app for 7.2 minutes or more an SLA may be triggered.
For enterprise customers this may be a big issue and can inflict some reputational damage to Lokalise if not SLA costs only. For example, a type of downtime could be the app timing out for no reason (managed to find a semi-relevant 
[issue] (https://github.com/lokalise/lokalise-cli/issues/2) in GitHub).

The model is an early alert system for the Lokalise SRE team. It detects events that trigger SLA clauses and warns the SRA team to fix the issue before costs are incurred. 
The SLA events are ranked by customer importance on a revenue basis, i.e. events happening to top customers get prioritised. More specifically, the model is restricted to users that are 
team owners, i.e. important stakeholders. The model has been built for a limited number of events, but can easily be expanded to include many more as new issues are identified or exclude as resolved.


#### 1.1.2 Why is it impactful?

Enterprise customers make heavy use of the app and it is to be expected that they may need support. Good customer service is of paramount importance for customer retention. 
An SLA events alert system is a good way to jump on the issue even before it becomes a problem, by identifying and resolving production glitches before customers become upset. 
Prioritising by revenue means that we are focusing on our top customers and retaining our biggest contracts. All customers are important but with limited SRE resources we will HAVE to prioritise.

#### 1.1.3 Structure of the model

Step 1 - **sla_ref** list of SLA events to be used in the model. Includes "time out" and "page not found", can be expanded to any number of events.

Step 2 - **sla_events** get all cases of multiple (5) SLA events per user in the last 7.2 minutes (to keep 99.5% uptime)

Step A (parallel to Step 1) - **top customers** get ranked list of **current** customers by revenue

Step B (parallel to Step 2) - identify team owners of our top customers

Final step /Model - **alert_list** get the user_id, team_id, event_name, and event_court for all qualifying SLA events and users. List is ranked by 1)customer rank and 2)event count (descending).

The model was developed in dbt cloud.

#### 1.1.4 Model use

The model could be used with an AWS Lambda function, which would be triggered for every new entry. The ouput could be a notification or email to the SRE team with importance rating, 
but can be customised to fit the team needs and structure. Also, an SLA event dashboard could be built to visualise such events and status (resolved/unresolved/won't do).

Next steps: In time we would have enough resolved issues to build a predictive model that could give us a severity score. 
For example, we might see that when a user has started twenty new sessions in five minutes that is almost certainly a problem, whereas other events usually are resolved by customers. 
This means our SRE team would spend 100% or us much of theuir time on actual problems and not false positives. Initially, the model could only use simple predictors susch us event type 
and event count.

#### 1.1.5 Model output

| Column      | Type    | Description                                      | Tests                                 |
|-------------|---------|--------------------------------------------------|---------------------------------------|
| user_id     | integer | User ID - project owners                         | NOT NULL, user_id in users table      |
| team_id     | integer | Team ID - can be all teams                       | NOT NULL, team_id in teams table      |
| event_name  | string  | Event name                                       | NOT NULL, event name in sla_ref table |
| event_count | integer | Number of events per user ID in last 7.2 minutes | NOT NULL, event_count>0               |


## 1.2 Model computation

Model developed in dbt cloud using BigQuery . Code in `models` folder.

