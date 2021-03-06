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

for (i in 1:32) {
  for ( j in 1:8) {
    salary_data <- download_data(nfl_teams[i], years[j], salary_data)
  }
}

salary_data$YEAR <- mapvalues(salary_data$YEAR, from = "2009-10", to = "2009")

write.csv(salary_data, file="salary_data.csv", row.names=FALSE, na = "")

