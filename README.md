# Simplifying software with temporal SQL

Welcome to this 1-Day Masterclass, developed and delivered by JUXT for the GOTO (Copenhagen) conference.

This event takes place on Monday, September 30th 2024.

See https://gotocph.com/2024/masterclasses/470/simplifying-software-with-temporal-sql for more details.

Come join us and register today: https://gotocph.com/2024/register

## Workshop

- [Setup the database](./sql/setup_database.sql)


### Temporal

What would this course teach?

- What was the database like in the past?
  - `SETTING DEFAULT VALID_TIME AS OF DATE '2024-01-01'...`
- `NEST_ONE` + `NEST_MANY`
- How do I restore these `n` entities to how they looked
  - Last week
  - We've accidentially deleted this record
- Readings data


### [From wikipedia](https://en.wikipedia.org/wiki/SQL:2011):

For some ideas:

New features
One of the main new features is improved support for temporal databases.[2][3] Language enhancements for temporal data definition and manipulation include:

Time period definitions use two standard table columns as the start and end of a named time period, with closed set-open set semantics. This provides compatibility with existing data models, application code, and tools
Definition of application time period tables (elsewhere called valid time tables), using the PERIOD FOR annotation
Update and deletion of application time rows with automatic time period splitting
Temporal primary keys incorporating application time periods with optional non-overlapping constraints via the WITHOUT OVERLAPS clause
Temporal referential integrity constraints for application time tables
Application time tables are queried using regular query syntax or using new temporal predicates for time periods including CONTAINS, OVERLAPS, EQUALS, PRECEDES, SUCCEEDS, IMMEDIATELY PRECEDES, and IMMEDIATELY SUCCEEDS (which are modified versions of Allen’s interval relations)
Definition of system-versioned tables (elsewhere called transaction time tables), using the PERIOD FOR SYSTEM_TIME annotation and WITH SYSTEM VERSIONING modifier. System time periods are maintained automatically. Constraints for system-versioned tables are not required to be temporal and are only enforced on current rows
Syntax for time-sliced and sequenced queries on system time tables via the AS OF SYSTEM TIME and VERSIONS BETWEEN SYSTEM TIME ... AND ... clauses
Application time and system versioning can be used together to provide bitemporal tables