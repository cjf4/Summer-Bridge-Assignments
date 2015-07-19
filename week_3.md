# Chris Fenton Week 3 Assignment

First, I load the data in using read.table:


```r
week3 <- read.table("week3.data", sep = ",", header = FALSE)
```

Next, I'll take a look at the data structure:

```r
str(week3)
```

```
## 'data.frame':	8124 obs. of  23 variables:
##  $ V1 : Factor w/ 2 levels "e","p": 2 1 1 2 1 1 1 1 2 1 ...
##  $ V2 : Factor w/ 6 levels "b","c","f","k",..: 6 6 1 6 6 6 1 1 6 1 ...
##  $ V3 : Factor w/ 4 levels "f","g","s","y": 3 3 3 4 3 4 3 4 4 3 ...
##  $ V4 : Factor w/ 10 levels "b","c","e","g",..: 5 10 9 9 4 10 9 9 9 10 ...
##  $ V5 : Factor w/ 2 levels "f","t": 2 2 2 2 1 2 2 2 2 2 ...
##  $ V6 : Factor w/ 9 levels "a","c","f","l",..: 7 1 4 7 6 1 1 4 7 1 ...
##  $ V7 : Factor w/ 2 levels "a","f": 2 2 2 2 2 2 2 2 2 2 ...
##  $ V8 : Factor w/ 2 levels "c","w": 1 1 1 1 2 1 1 1 1 1 ...
##  $ V9 : Factor w/ 2 levels "b","n": 2 1 1 2 1 1 1 1 2 1 ...
##  $ V10: Factor w/ 12 levels "b","e","g","h",..: 5 5 6 6 5 6 3 6 8 3 ...
##  $ V11: Factor w/ 2 levels "e","t": 1 1 1 1 2 1 1 1 1 1 ...
##  $ V12: Factor w/ 5 levels "?","b","c","e",..: 4 3 3 4 4 3 3 3 4 3 ...
##  $ V13: Factor w/ 4 levels "f","k","s","y": 3 3 3 3 3 3 3 3 3 3 ...
##  $ V14: Factor w/ 4 levels "f","k","s","y": 3 3 3 3 3 3 3 3 3 3 ...
##  $ V15: Factor w/ 9 levels "b","c","e","g",..: 8 8 8 8 8 8 8 8 8 8 ...
##  $ V16: Factor w/ 9 levels "b","c","e","g",..: 8 8 8 8 8 8 8 8 8 8 ...
##  $ V17: Factor w/ 1 level "p": 1 1 1 1 1 1 1 1 1 1 ...
##  $ V18: Factor w/ 4 levels "n","o","w","y": 3 3 3 3 3 3 3 3 3 3 ...
##  $ V19: Factor w/ 3 levels "n","o","t": 2 2 2 2 2 2 2 2 2 2 ...
##  $ V20: Factor w/ 5 levels "e","f","l","n",..: 5 5 5 5 1 5 5 5 5 5 ...
##  $ V21: Factor w/ 9 levels "b","h","k","n",..: 3 4 4 3 4 3 3 4 3 3 ...
##  $ V22: Factor w/ 6 levels "a","c","n","s",..: 4 3 3 4 1 3 3 4 5 4 ...
##  $ V23: Factor w/ 7 levels "d","g","l","m",..: 6 2 4 6 2 2 4 4 2 4 ...
```

Now, I'll rename the columns according to the dataset description found [here](https://archive.ics.uci.edu/ml/machine-learning-databases/mushroom/agaricus-lepiota.names).

```r
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
```

Next, I'll subset the data on gill attributes and edibility:


```r
week3_gills <- subset(week3, select=c("edibility", 
                                      "gill-attachment", 
                                      "gill-spacing",
                                      "gill-size",
                                      "gill-color"))
```

I'm going to use the plyr package to rename the factor levels. First, I'll load the package:

```r
library(plyr)
```

I'll start with the mapvalues() function:


```r
week3_gills$edibility <- mapvalues(week3_gills$edibility, 
                                   from = c("e", "p"), 
                                   to = c("edible","poisonous"))
```
For the attribute/column names, I had to start subsetting by brackets because I used hypens in the column names. I did that to stay consistent with the dataset description, but in the future I would probably convert the hyphens to underscores to make the dataframe easier to work with.

I also decided to include factor levels mentioned in the description, but had no instances in the dataset, in case I added data that had those factors in the future.

```r
week3_gills[,"gill-attachment"] <- mapvalues(week3_gills[,"gill-attachment"],
                                         from = c("a","d","f","n"),
                                         to = c("attached", "descending",
                                                "free", "notched"))
```

```
## The following `from` values were not present in `x`: d, n
```


```r
week3_gills[,"gill-spacing"] <- mapvalues(week3_gills[,"gill-spacing"],
                                          from = c("c", "w", "d"),
                                          to = c("crowded", "wild", "distant"))
```

```
## The following `from` values were not present in `x`: d
```
Here I tried **revalue()** (also from plyr) just to switch things up.

```r
week3_gills[,"gill-size"] <- revalue(week3_gills[,"gill-size"], 
                                     c("b"="broad","n"="narrow"))
```
Here we have the opposite situation as above. There was a factor level, "u", that was not mentioned in the data set description for gill-color. I guessed that it meant "unknown" and named it as such, but couldn't find any information in the description that would indicate one way or another.

```r
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
```

```
## The following `from` values were not present in `x`: c
```
Finally, I take a look at the structure of my subset to make sure everything looks good.


```r
str(week3_gills)
```

```
## 'data.frame':	8124 obs. of  5 variables:
##  $ edibility      : Factor w/ 2 levels "edible","poisonous": 2 1 1 2 1 1 1 1 2 1 ...
##  $ gill-attachment: Factor w/ 2 levels "attached","free": 2 2 2 2 2 2 2 2 2 2 ...
##  $ gill-spacing   : Factor w/ 2 levels "crowded","wild": 1 1 1 1 2 1 1 1 1 1 ...
##  $ gill-size      : Factor w/ 2 levels "broad","narrow": 2 1 1 2 1 1 1 1 2 1 ...
##  $ gill-color     : Factor w/ 12 levels "buff","red","gray",..: 5 5 6 6 5 6 3 6 8 3 ...
```
*fin*
