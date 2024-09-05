-- @conn xtdb

-- Slide decks:
-- - Introduction to Temporal SQL (SQL 2011)
-- - Policy Management
-- - Claims Management
-- - High level benefits (synergy POC?)

-- Talk about how we get data into the system

-- - XTDB Features to talk about:
--   - Schema-less
--   - Temporal Joins
--   - "Auto-versioning"

-- Questions:
-- - Should you include a "status" field?
-- - Why are we "as of now" by default (non standard)?
-- -

-- Actions to explore:
-- - Renewing a policy
-- - Making a claim
-- - Detecting fraud
-- - Gap in cover (query find the gaps)
-- - (_system_from - _valid_from) How far in the past was information entered?
-- - Simple premium recalculation
--   - Just based on points on license
--   - Find out late someone got points
--   - How much have they underpaid?
-- - Sheduling a new policy (to avoid gaps)
-- - Updating policy/claim details
--   - When was each thing true (period intersection + overlaps)
-- - No need for an audit log
-- - Notifying policy holders of important date
--   - time to renew, claim status changed recently
-- - Offering discounts
--   - Loyalty (Who has been an uninterupted customer for greater than n years?)
-- - Compliance and regulatory reporting
-- - Upselling (Given `Home`, `Life`, and `Health` who is missing one or more?)
