library(ggplot2) 
library(dplyr)
library(lubridate)
library(cowplot) 

# Create the data (I'm manually entering this data from Basketball Reference)
eval = c(105.3, 104.9, 104.2, 102.7, 100.5, 99.1, 100.3, 99.3, 97.5, 99.6)
pct_3 = c(38, 36, 34, 32, 29, 27, 26, 24, 23, 22)
fg_pct = c(45.9, 46.1, 46.0, 45.7, 45.2, 44.9, 45.4, 45.3, 44.8, 45.9)
yr = c("2020", "2019", "2018", "2017", "2016", "2015", "2014", "2013", "2012", "2011")
df = data.frame(eval, pct_3, fg_pct, yr)

# Create the three plots. Manual ylimits, no xlabels except plot3, and I prefer the line and points
plot1 = ggplot(data=df, aes(x=yr, y=pct_3)) + geom_line(aes(group=1)) + geom_point() +
  ylim(20, 40) +  
  theme(axis.title.x = element_blank(), axis.title.y = element_blank(),
        axis.text.x = element_blank())

plot2 = ggplot(data=df, aes(x=yr, y=fg_pct)) + geom_line(aes(group=1)) + geom_point() +
  ylim(40, 50) + 
  theme(axis.title.x = element_blank(), axis.title.y = element_blank(),
        axis.text.x = element_blank())

plot3 = ggplot(data=df, aes(x=yr, y=eval)) + geom_line(aes(group=1)) + geom_point() + 
  theme(axis.title.y = element_blank()) + xlab("Year")


# Draw the three plots aligned vertically, with equal relative heights. 
# Added 4th blank row because I want them to easily fit onto the page.
# Made some tweaks iteratively until I liked the positioning of the titles.
cowplot::plot_grid(plot1, plot2, plot3, 
                   labels=c("% of shots taken from 3pt range", "      % of all shots made", "Expected points per 100 shots"), 
                   label_size = 10, vjust=2.4, label_fontface = 4,
                   align = "v", ncol = 1, rel_heights = c(0.5, 0.5, 0.5), nrow=4)
