                                  #Snails!
#Load our packages
library(tidyverse)
library(dplyr)
library(ggplot2)
data.frame(snails, package = "MASS")
df<-snails
custom_colors<-c('lightsteelblue2','lightsteelblue4')

#Let's see our data
str(df)

ggplot(df, aes(x = Species, y = Deaths)) +
  stat_summary(fun = "mean", geom = "bar", fill = "blue") +
  labs(x = "Species", y = "Average Deaths") +
  theme_minimal()

#As temp increases, looks like deaths do too
ggplot(df, aes(x = Temp, y = Deaths, fill=Species)) +
  stat_summary(fun = "mean", geom = "bar", fill = "blue") +
  labs(x = "Species", y = "Average Deaths") +
  theme_minimal()+facet_wrap(~Exposure)

ggplot(df, aes(x = Temp, y = Deaths, fill = Species)) +
  exp4 <- df %>% filter(Exposure == 4) +
  labs(x = "Temperature", y = "Average Deaths") +
  theme_minimal() +
  facet_grid(Species ~ Exposure)+scale_fill_manual(values=custom_colors)


              #Ok looks like B has a much higher death rate...Let's see why
#Grid by exposure and species
ggplot(df, aes(x = Species, y = Deaths)) +
  stat_summary(fun = "mean", geom = "bar") +
  labs(x = "Species", y = "Average Deaths") +
  theme_classic()+facet_wrap(~Exposure)


#Looking into Exposure 4
#By Humidity
avg_deaths_by_relhum <- exp4 %>%
       group_by(Rel.Hum, Species) %>%
       summarize(Avg_Deaths = mean(Deaths))
ggplot(avg_deaths_by_relhum, aes(x= Rel.Hum, y= Avg_Deaths))+geom_point()+geom_line()+
  facet_wrap(~Species)+ggtitle("Deaths x Relative Humidity")+theme(plot.title = element_text(hjust = 0.5))

#By Temp
avg_deaths_by_temp <- exp4 %>%
  group_by(Temp, Species) %>%
  summarize(Avg_Deaths = mean(Deaths))
ggplot(avg_deaths_by_temp, aes(x= Temp, y= Avg_Deaths))+geom_point()+geom_line()+
  facet_wrap(~Species)+ggtitle("Deaths x Temp")+theme(plot.title = element_text(hjust = 0.5))
