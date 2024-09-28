# Planning

## Slide decks:
- Introduction to Temporal SQL (SQL 2011)
- Policy Management
- Claims Management
- High level benefits (synergy POC?)

## Talk about how we get data into the system

- XTDB Features to talk about:
  - Schema-less
  - Temporal Joins
  - "Auto-versioning"

## Questions:
- Should you include a "status" field?
- Why are we "as of now" by default (non standard)?
-

## Actions to explore:
- Renewing a policy
- Making a claim
- Detecting fraud
- Gap in cover (query find the gaps)
- (_system_from - _valid_from) How far in the past was information entered?
- Simple premium recalculation
  - Just based on points on license
  - Find out late someone got points
  - How much have they underpaid?
- Sheduling a new policy (to avoid gaps)
- Updating policy/claim details
  - When was each thing true (period intersection + overlaps)
- No need for an audit log
- Notifying policy holders of important date
  - time to renew, claim status changed recently
- Offering discounts
  - Loyalty (Who has been an uninterupted customer for greater than n years?)
- Compliance and regulatory reporting
- Upselling (Given `Home`, `Life`, and `Health` who is missing one or more?)
- Agreeing how the policy is paid for
  - Payment schedules
- Use "business insurance" for a more generic name

## Ideas:
- Simple premium calculator
  - Apply the calculator to an individual over time
    - For an example how does their premium change over time
  - Debug "Why did their premium go above x value?"
  - The past can be updated by setting `VALID_TIME`, how can we see what we would have calculated their premium as x days ago?
  - Idea:
    - Calculate the claim like (100 * <some bool value> + 10 * <number of claims>)
    - Let the users play with the data and see how the premium changes
    - Maybe make this a project?
- Auditing
  - What kinds of questions need to be answered?
    - Why did you accept this person's claim when they no longer fit the criteria?
  - How can we answer a question with the information we knew at a particular date?
  - How can we do without an audit table?
    - Correlate transaction time and system_time
- Late arriving data
  - How can we ensure that data that arrives late makes it into the database so that it's represented properly?
  - https://docs.xtdb.com/tutorials/financial-usecase/time-in-finance.html#3-interleaving-upstream-sources-whose-timestamp
- Upselling/analytics
  - Given the history of a set of users
  - Who hasn't made a claim?
  - Who has made the most claims?
  - Who has doesn't have Life insurance?
  - Who has has **never** had Life insurance?
  - Who has had claims deleted?
  - Notifying policy holders of important dates
    - Who's policy is going to expire in one month?
    - Who's policy has changed stated recently?
      - Follow up email
- Complex valid time
  - Automated record expiration
  - Readings data
  - Scheduled changes
  - Queries where tables have different `AS OF`s
    - How would this have returned with last weeks claims, but this weeks pricing changes?
  - What do you do if you have more than one "timeline" for the same entity?
    - Advice: Don't model in system time (like we have in our examples)
      - It has limited modeling capabilities
    - N-temporal modeling
    - Split out into an entity per timeline
  - Maybe put these as bonus questions on the end of all of the tasks?
- Introduce DELETE & ERASE
  - A user leaves the company
  - GDPR for ERASE



# Agenda

## Session 1 (start) (1h 30m)

### Intro

Presentation:
 - Who are you?
 - What industry to you work in?
 - What do you want to learn today?
 - How much experience do you have with SQL?


### What is Temporal SQL?

Presentation:
- What features is in it?
  - New temporal types
    - `PERIOD`
  - SYSTEM_TIME & VALID_TIME
  - Temporal predicates
    - `CONTAINS`, `OVERLAPS`, `SUCCEEDS` etc
- What problems does it solve?
  - Audit by default
  - Allow updating our knowledge of the past while maintaining Auditablity
  - Just show the "Time in Finance" page?
- Where can you use it? (Ask @jdt)
  - CockroachDB
    - `AS OF SYSTEM TIME` (only against recent changes)
  - Oracle
    - `AS OF TIMESTAMP` (only against recent changes)
  - Microsoft SQL Server
    - Using `SYSTEM_VERSIONING` (no `VALID_TIME`)
  - MariaDB
    - Pretty complete support
  - PostgreSQL
    - Using the `temporal_tables` extension
- Intro to XTDB
  - Full SQL:2011
  - Build with temporal indexes in mind
  - Extends SQL:2011
    - TODO
  - PostgreSQL compatible


### Setup

VSCode & Github Codespaces


### SQL Referesher (Exercises)

Notes:
> - What do we want to teach here?
>   - SQL Tools
>   - SQL Refresher
>   - XTDB syntax & features
>     - Schemaless database
>     - Inserting RECORDS

Exercises:
- Do an INSERT
  - XTDB is schemaless
- To refresh on:
  - SELECT
  - WHERE
  - ORDER BY
  - LIMIT
  - Aggregate functions
    - count, sum, avg, min, max
  - JOIN & friends
  - Subqueries
  - DML
    - INSERT
    - UPDATE
    - DELETE
  - Set operations?
- Provide some data and ask them to answer some questions
  - Provide: INSERT statement for policy data
  - Write a new INSERT to add a record for `John Smith`
  - Write an UPDATE statement
  - Write a DELETE statement
  - How many policies are there?
  - How many health policies?
  - How many policies does `Jane Smith` have?
  - Provide: Second table
  - JOIN on this table
  - Do the other joins?


## Session 2 (post coffee) (1h 15m)

### System Time

Presentation:
- Provide a use case
- Use as `updated_at` (monitoring a table, table with audit)
- NOTE: That updates **can only** happen **AS OF NOW**
- Exercises
  - Proide some example data
  - Query for `_system_from`
  - Do some inserts
  - See how `_system_from` has changed
- Show `FOR SYSTEM_TIME ALL` and other filters

Exercises:
- Run `FOR SYSTEM_TIME ALL` on your previous query
- Why are some row duplicated?
- Query for `_system_from` *and* `_system_to`
- What does `_system_to` mean?
  - A: When did this row stop being `present`
- What does `_system_from` mean?
  - A: When did this row start being `present`
  - A: It's just `updated_at`
- Run a query with `FOR SYSTEM_TIME FROM x TO y`
- Run a query with `FOR SYSTEM_TIME AS OF x`
- Run a query with `FOR SYSTEM_TIME AS OF NOW`
  - This is implicit if it's not specified
  - Penny drop moment 🪙
- Query for `_system_time` (not `_from` or `_to`)

### Temporal Types

Presentation:
- Timestamps
- Introducing Period
  - What is it?
- Introducing Interval & Duration
- Introducing Date & Timestamp
- Temporal operators

Exercises:
- What is the difference between these two dates?
- How many weeks are there?
  - Round up
- Allen Algebra
  - Is this date a month before this other date?
  - Does this date fall within this range?
  - Do these two periods overlap?
- What is the start date of this period?
- Return all the periods that are longer than 1 month
- Order these period by length
- Group by 5m intervals, how many per interval?
  - Average reading
- Which one of these dates is in Febuary?
- What's the intersection between these two periods?


## Session 3 (post lunch) (1h 30m)

### Valid Time

> What do we want to teach
> - Inserting data

Presentation:
- It's the same as SYSTEM_TIME
- Here are the differences
  - You can update it
    - Show an INSERT
    - Show that we default to NOW same as SYSTEM_TIME
  - Why?
    - All SYSTEM_TIME says is:
      - "The database learned this fact at this time"
      - "This fact will continue to be true until a new fact arrives"
    - Very rigid (intentially so)
    - 
  - You are modeling: The truth of a fact
    - "When did this fact become true?"
    - "When did this stop being true?"
    - "Do we currently think this will ever stop being true?"

Exercises:
- 

### Bitemporality

> Key take aways:
> - 

- Combining these two ideas
- Do two inserts, why are there 3 rows (`FOR VALID_TIME ALL FOR SYSTEM_TIME ALL`)
- When is it useful to compare them?
- 

## Session 4 (post coffee) (2h 15m)

### Project

> Ideas:
> - Build a *simple* employee managemen system
> - 

### Advanced Topics

- Updating a row in the past
- Scheduling change/insertion
- Temoral Joins
- Tri-temporality
- Readings
- ERASE
- Whatever Mat thinks