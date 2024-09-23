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