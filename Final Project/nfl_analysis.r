library(ggplot2)

nfl <- read.csv('salary_season.csv', stringsAsFactors=FALSE)

# 1. combine lbs

total_lbs <- nfl[,'LB.Cost'] + nfl[,'OLB.Cost'] + nfl[,'MLB.Cost']
nfl <- cbind(nfl, tLB.Cost = total_lbs)

# 2. get a defense total p/team

total_d <- nfl[,'tLB.Cost'] + nfl[,'DE.Cost'] + nfl[,'DT.Cost'] 
                            + nfl[,'CB.Cost'] + nfl[,'S.Cost']
nfl <- cbind(nfl, tD.Cost = total_d)

# 3. create ratio of each defensive position of defense as a whole

lb_pct <- nfl[,'tLB.Cost'] / nfl[,'tD.Cost']  
dt_pct <- nfl[,'DT.Cost'] / nfl[,'tD.Cost']  
de_pct <- nfl[,'DE.Cost'] / nfl[,'tD.Cost']  
cb_pct <- nfl[,'CB.Cost'] / nfl[,'tD.Cost']  
s_pct <- nfl[,'S.Cost'] / nfl[,'tD.Cost']  

nfl <- cbind(nfl, lb_pct, dt_pct, de_pct, cb_pct, s_pct)

# 4. trim the data down to defense only

def <- subset(nfl,select=c("team_name",
                           "year",
                           "Wins",
                           "Points.Against",
                           "Def.Rank.Pts",
                           "Def.Rank.Yds",
                           "lb_pct",
                           "dt_pct",
                           "de_pct",
                           "cb_pct",
                           "s_pct"))

plot(def$'Def.Rank.Yds', def$'Wins')
plot(def$'Def.Rank.Pts', def$'Wins')