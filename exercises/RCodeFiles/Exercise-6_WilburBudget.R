#Visualizing Monthly Expenses
library(tidyverse)
library(dplyr)
library(ggplot2)
df<-WilburExpenses_Checking1_csv
custom_colors<-c('plum3','mediumpurple','mediumpurple4','slateblue1','lightsteelblue','darkblue')
#Need to add rent
# Create a new row as a data frame
new_row <- data.frame(Place = "Landlord", Type = "Rent", Amount = -324)
# Add the new row to your existing data frame
df <- rbind(df, new_row)

#First messy visual
ggplot(df, aes(x="", y=Amount, fill=Type)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) +theme_classic()


#Let's Isolate Spending
Spending<-df%>%filter(Type %in% c('Food', 'Bills', 'Rec', 'Rent', 'Travel','Med'))
#Average spending for each Type
Spending_summary <- Spending %>%
  group_by(Type) %>%
  summarize(Total_Amount = sum(Amount))
#Total Amount Spending
total_sum<-sum(Spending_summary$Total_Amount)
#Pie chart of the percentage spent by type
ggplot(Spending_summary, aes(x = "", y = Total_Amount, fill = Type, label = scales::dollar(Total_Amount))) +
  geom_bar(stat = "identity") +
  geom_text(aes(x = 1.2, label = scales::percent(Total_Amount / sum(Total_Amount))), position = position_stack(vjust = 0.5)) +
  coord_polar("y", start = 0) +
  theme_void() +
  labs(title = "Expense Breakdown by Type")+theme(plot.title = element_text(hjust = 0.5))
#Pie chart of the sum spent by type


#From our isolated spending df, let's see the spending break down within type
food<-df%>%filter(Type %in% 'Food')%>%
  group_by(Place) %>%
  summarize(Total_Amount = sum(Amount))
#Pie chart of the totals spent on food by place
ggplot(food, aes(x = "", y = Total_Amount, fill = Place, label = scales::dollar(Total_Amount))) +
  geom_bar(stat = "identity") +
  geom_text(aes(x = 1.2, label = scales::dollar(Total_Amount), y = Total_Amount), position = position_stack(vjust = 0.5)) +
  coord_polar("y", start = 0) +
  theme_void() +labs(title = "Expense Breakdown for Food by Place") + theme(plot.title = element_text(hjust = 0.5))+scale_fill_manual(values =custom_colors)

#Your turn!
#Add column for deposits or withdrawals

dwcolors<-c(Deposit='chartreuse3',Withdrawal='brown3')

