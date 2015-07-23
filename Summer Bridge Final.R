library(XML)

#data is in a table, and labelled as a list element
giants <- readHTMLTable('http://content.usatoday.com/sportsdata/football/nfl/Giants/salaries/2009-10')

#double bracket to access the first element of the list directly
bsals <- giants[['team-salaries']]

bsals <- cbind(lapply(bsals[1:6], as.character), bsals[7], stringsAsFactors = FALSE)
