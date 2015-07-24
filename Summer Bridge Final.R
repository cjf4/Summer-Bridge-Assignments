library(XML)
library(stringr)


nfl_teams <- c("bills", "dolphins", "jets", "patriots",
               "browns", "steelers", "bengals", "ravens",
               "colts", "jaguars", "texans", "titans",
               "chargers", "chiefs", "raiders", "broncos",
               "eagles", "giants", "redskins", "cowboys",
               "packers", "lions", "bears", "vikings",
               "falcons", "panthers", "saints", "buccaneers",
               "rams", "seahawks", "49ers", "cardinals")

years <- c( "2001", "2002", "2003", "2004", "2005", 
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
    
    return(rbind(df, team_sals))
}

#getting error, put try catch on rbind right above
for (i in nfl_teams) {
  for ( j in years) {
    salary_data <- download_data(nfl_teams[i], years[j], salary_data)
  }
}

#data is in a table, and labelled as a list element
giants <- readHTMLTable('http://content.usatoday.com/sportsdata/football/nfl/Giants/salaries/2009-10')

#double bracket to access the first element of the list directly
bsals <- giants[['team-salaries']]

#turn the first 6 col vectors into character vectors, leave the 7th as a factor
#glue them back together
bsals <- cbind(lapply(bsals[1:6], as.character), bsals[7], stringsAsFactors = FALSE)

#prepare the numeric data to be converted via regex removal of non digits
#change this to a loop or lapply
bsals$'BASE SALARY' <- as.numeric(gsub("[^[:digit:]]", "", bsals$'BASE SALARY'))
bsals$'SIGN BONUS' <- as.numeric(gsub("[^[:digit:]]", "", bsals$'SIGN BONUS'))
bsals$'ALL BONUSES' <- as.numeric(gsub("[^[:digit:]]", "", bsals$'ALL BONUSES'))
bsals$'CAP VALUE' <- as.numeric(gsub("[^[:digit:]]", "", bsals$'CAP VALUE'))
bsals$'SALARY' <- as.numeric(gsub("[^[:digit:]]", "", bsals$'SALARY'))

str(bsals)

#next steps
#loop through url to download all teams/seasons
#set up database
#connect to it
#dump data into DB
