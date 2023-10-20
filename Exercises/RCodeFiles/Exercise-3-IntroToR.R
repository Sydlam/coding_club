library(tidyverse)
library(dplyr)
library(ggplot2)
library(lattice)
library(MASS)

#Load our data
data (cats, packages="MASS")
df<-cats
print(df)
#Let's try and see what our data is structured like
str(cats) 
head(cats) #gives us the first values in our data frame 
tail(cats) #gives the last values in our data frame









#basic plot
ggplot(data=cats, aes(x=Hwt, y=Bwt))+geom_point()

basic<-ggplot(data=cats, aes(x=Hwt, y=Bwt))+geom_point() #creating an easy 









#with axis titles
less_basic<-basic+ xlab('Heart Weight (g)')+ylab('Birth Weight (kg)')+ 
  ggtitle('Heart Weight vs Birth Weight in Cats')

less_basic









#still needs some formatting!
snazzy<-less_basic+theme(plot.title = element_text(hjust = 0.5, margin=margin(t=10,b=10), lineheight=.8, face="bold", color='PaleVioletRed')) + geom_point(aes(color=Sex))

snazzy









#Let's use our lattice package!If this line of code scares you, worry not, it is explained in greater detail in our jupyterlab
xyplot(Hwt ~ Bwt | Sex, data=cats, type=c("p","g","r"),
       xlab="Body weight (kg)",
       ylab="Heart weight (g)")
