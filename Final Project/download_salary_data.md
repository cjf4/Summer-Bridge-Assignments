# Chris Fenton Summer Bridge Final Project
## Part I: NFL Data Acquisition

[Github Repo](https://github.com/cjf4/Summer-Bridge-Assignments/tree/master/Final%20Project)

For my final project, I will be looking at NFL Salary Data from 2002 to 2009 from [USA Today](http://content.usatoday.com/sportsdata/football/nfl/salaries/team), and comparing it to peformance for those same years. The performance data comes from [Pro Football Reference individual team pages](http://www.pro-football-reference.com/teams/buf/).

I started with 2002 for simplicity, because that is when the Houston Texans came into the league, and the teams have been consistent since than. 2009 was the last year of data provided.

First, I loaded the packages I will use later, declared two vectors that I used to build URLs that contain the salary data, and declared an empty data frame to put everything in.


```r
library(XML)
library(plyr)

nfl_teams <- c("bills", "dolphins", "jets", "patriots",
               "browns", "steelers", "bengals", "ravens",
               "colts", "jaguars", "texans", "titans",
               "chargers", "chiefs", "raiders", "broncos",
               "eagles", "giants", "redskins", "cowboys",
               "packers", "lions", "bears", "vikings",
               "falcons", "panthers", "saints", "buccaneers",
               "rams", "seahawks", "49ers", "cardinals")

years <- c("2002", "2003", "2004", "2005", 
           "2006", "2007", "2008", "2009-10")

salary_data <- data.frame()
```

Next, I wrote a function that downloads the data and binds it to the data frame. **readHTMLTable** from the **XML** package let me download table data from HTML pages. Then all needed to do was access the correct element of the list and clean the data up a bit.

```r
download_data <- function(team, year, df) {
    team_list <- readHTMLTable(sprintf('http://content.usatoday.com/sportsdata/football/nfl/%s/salaries/%s', team, year))
    team_sals <- team_list[['team-salaries']]
    team_sals <- cbind(lapply(team_sals[1:6], as.character), 
                       team_sals[7], stringsAsFactors = FALSE)
    
    team_sals$'BASE SALARY' <- as.numeric(gsub("[^[:digit:]]", "", team_sals$'BASE SALARY'))
    team_sals$'SIGN BONUS' <- as.numeric(gsub("[^[:digit:]]", "", team_sals$'SIGN BONUS'))
    team_sals$'ALL BONUSES' <- as.numeric(gsub("[^[:digit:]]", "", team_sals$'ALL BONUSES'))
    team_sals$'CAP VALUE' <- as.numeric(gsub("[^[:digit:]]", "", team_sals$'CAP VALUE'))
    team_sals$'SALARY' <- as.numeric(gsub("[^[:digit:]]", "", team_sals$'SALARY'))
    
    team_sals$TEAM_NAME <- rep(team, nrow(team_sals))
    team_sals$YEAR <- rep(year, nrow(team_sals))
    
    return(rbind(df, team_sals))
}
```

Than, I used a nested loop to go through each team/year combination and call it with of the parameters.

```r
for (i in 1:32) {
  for ( j in 1:8) {
    salary_data <- download_data(nfl_teams[i], years[j], salary_data)
  }
}
```

I used **mapvalues** from the **plyr** package to modify the last factor level, to make it more consistent with the other table of data.

```r
salary_data$YEAR <- mapvalues(salary_data$YEAR, from = "2009-10", to = "2009")
```
I wrote the data frame to a csv to be loaded by my Postgres database.


```r
write.csv(salary_data, file="salary_data.csv", row.names=FALSE, na = "")
```

For the performance data from Pro Football Reference, I downloaded the .csv files manually. I attempted to write a script, but to get the csv format it looked like the page used some javascript. I could have probably figured it out if I had more time, but there were only 32 different files (one for each team) instead of 288 in the case of the salary data, so this was ok.

[Here is the link for the SQL statements](https://github.com/cjf4/Summer-Bridge-Assignments/blob/master/Final%20Project/create_salaries_table.sql) that create the tables for the data to live, and that marshal the data in. I created the tables to match the files, making this step pretty straightforward.

Finally, [I wrote a query that tied the data from the two tables together](https://github.com/cjf4/Summer-Bridge-Assignments/blob/master/Final%20Project/nfl_data_query.sql) in a way that would make it easy to work with in R. Basically what I'm doing is summing all of each team players from a season together (ex 2009 Bills) and using both the team and year fields to join it with the performance data from the 'seasons' table.

The other thing of note I did here was a bunch of conditional sums for each row in the query. So for the 2009 Bills, I wanted to see what they spent that year on each position group. Using the SUM() function with case statements I was able to accomplish this.

Finally, I wrote it to a .csv file to be loaded in to R and were at last ready for some analysis.

### Points or Wins?

First, I just wanted to see if NFL tradition of ranking NFL defenses by yards allowed was really a better measure than points against.


```r
plot(def$'Def.Rank.Yds', def$'Wins')
```

```
## Error in plot(def$Def.Rank.Yds, def$Wins): object 'def' not found
```
