library(ggplot2)
library(data.table) 
# loaded the data into df dataframe
df <- fread('Economist_Assignment_Data.csv')
# plotted the data using ggplot and added the needed asthetics  
pl <- ggplot(df,aes(x=CPI,y=HDI)) + geom_point(aes(color = Region),shape = 1,size = 4)
pl2 <- pl + geom_smooth(aes(group = 1),method = 'lm',formula = y ~ log(x),se = FALSE,color ='red')

# to take only the required countries  
pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

pl3 <- pl2 + geom_text(aes(label = Country), color = "gray20", 
                       data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE)

pl4 <- pl3 + theme_bw() + scale_x_continuous(name = 'Corruption Perception Index,2011(10 = least corrupt)',limits = c(.9,10.5),breaks = 1:10)

pl4 <- pl4 + scale_y_continuous(name = 'Human Development Index,2011 (1 = Best)',limits = c(0:1),breaks = 1:10) 

pl4 <- pl4 + ggtitle('Corruption and Human Development')

print(pl4)