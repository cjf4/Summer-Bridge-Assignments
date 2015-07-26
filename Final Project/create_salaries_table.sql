DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS seasons;

CREATE TABLE salaries (
    PLAYER  text NOT NULL,
    "BASE SALARY" numeric,
    "SIGN BONUS"  numeric,
    "ALL BONUSES" numeric,
    "CAP VALUE"   numeric,
    SALARY  numeric,
    POSITION    text,
    TEAM_NAME   text NOT NULL,
    YEAR    text NOT NULL
);

CREATE TABLE season(
    "Year" numeric,
    "League" text,
    "Team" text,
    "Current Nickname" text,
    "Wins" numeric,
    "Losses" numeric,
    "Ties" numeric,
    "Playoffs" text,
    "Points For" numeric,
    "Points Against" numeric,
    "Pt Dif" numeric,
    "Coaches" text,
    "AV" text,
    "Passer" text,
    "Rusher" text,
    "Receiver" text,
    "Off Rank Pts" numeric,
    "Off Rank Yds" numeric,
    "Def Rank Pts" numeric,
    "Def Rank Yds" numeric,
    "TO Dif Rank" numeric,
    "Pt Dif Rank" numeric,
    "Yd Dif Rank" numeric,
    "Total Teams" numeric,
    "MoV" numeric,
    "SoS" numeric,
    "SRS" numeric,
    "OSRS" numeric,
    "DSRS" numeric
);

COPY salaries FROM '/Users/christopherfenton/Data Science/Summer Bridge/salary_data.csv' CSV HEADER
COPY seasons FROM '/Users/christopherfenton/Data Science/Summer Bridge/team_years.csv' CSV HEADER
