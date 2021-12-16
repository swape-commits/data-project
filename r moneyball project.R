library(data.table)
library(ggplot2)
library(dplyr)
batting <- fread('Batting.csv')
batting$BA <- batting$H/batting$AB
batting$OBP <- (batting$H + batting$BB + batting$HBP)/(batting$AB + batting$BB + batting$HBP + batting$SF)
batting$X1B <- batting$H - batting$`2B`- batting$`3B` - batting$HR
batting$SLG <- ((batting$X1B) + (2*batting$`2B`) +(3*batting$`3B`) + (4*batting$HR))/batting$AB
sal <- fread('Salaries.csv')
#reassigning batting to contain data from 1985 and onwards
batting <- subset(batting,batting$yearID >= 1985)
#merging batting and sal dataframe
combo <- merge(batting,sal,by = c('playerID','yearID'))
lost_players <- subset(combo,playerID %in% c('giambja01','damonjo01','saenzol01'))
# reassigning lost players dataframe to grab data only after year 2001
lost_players <- subset(lost_players,lost_players$yearID == 2001)
# reducing the dataframe to required columms only
lost_players <- lost_players[,c('playerID','H','2B','3B','HR','OBP','SLG','BA','AB')]
#subsetting the combined data frame
combo <- subset(combo,yearID==2001)
# finding the replacements
#constraints
# salary <= 15 M
# combined AB >= 1469
# combined OBP >= 0.364
# using visualization
pl <- ggplot(combo,aes(OBP,salary)) + geom_point()
print(pl)
# from the visualization subseting the data
combo <- subset(combo,salary < 8000000 & OBP >0)
# further subseting the data onbasis of AB
combo <- subset(combo,AB >= 450)
list <- (arrange(combo,desc(OBP),10))
a <- list[,c('playerID','AB','salary','OBP')]
print(head(a,10))