

week3 <- read.table("week3.data", sep = ",", header = FALSE)

ncol(week3)

str(week3)

colnames(week3) <- c("edibility",
                     "cap-shape",
                     "cap-surface",
                     "cap-color",
                     "bruises?",
                     "odor",
                     "gill-attachment",
                     "gill-spacing",
                     "gill-size",
                     "gill-color",
                     "stalk-shape",
                     "stalk-root",
                     "stalk-surface-above-ring",
                     "stalk-surface-below-ring",
                     "stalk-color-above-ring",
                     "stalk-color-below-ring",
                     "veil-type",
                     "veil-color",
                     "ring-number",
                     "ring-type",
                     "spore-print-color",
                     "population",
                     "habitat")

week3_gills <- subset(week3, select=c("edibility", 
                                      "gill-attachment", 
                                      "gill-spacing",
                                      "gill-size",
                                      "gill-color"))

library(plyr)

week3_gills$edibility <- mapvalues(week3_gills$edibility, 
                                   from = c("e", "p"), 
                                   to = c("edible","poisonous"))

#had to switch to bracket subsetting because of the hyphens in column names
#also remapped factors "d" and "n" even though they didn't exist, because
#they were defined in the attribute information

week3_gills[,"gill-attachment"] <- mapvalues(week3_gills[,"gill-attachment"],
                                         from = c("a","d","f","n"),
                                         to = c("attached", "descending",
                                                "free", "notched"))

#similar to above, remapped "d" (distant) even though it didn't exist

week3_gills[,"gill-spacing"] <- mapvalues(week3_gills[,"gill-spacing"],
                                          from = c("c", "w", "d"),
                                          to = c("crowded", "wild", "distant"))

#can also use revalue()

week3_gills[,"gill-size"] <- revalue(week3_gills[,"gill-size"], 
                                     c("b"="broad","n"="narrow"))

week3_gills[,"gill-color"] <- revalue(week3_gills[,"gill-color"],
                                      c("k"="black",
                                        "n"="brown",
                                        "b"="buff",
                                        "h"="chocolate",
                                        "g"="gray",
                                        "c"="cinnamon",
                                        "o"="orange",
                                        "p"="pink",
                                        "e"="red",
                                        "w"="white",
                                        "y"="yellow",
                                        "u"="unknown"))

str(week3_gills)