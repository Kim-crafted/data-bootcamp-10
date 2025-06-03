library(tidyverse)
library(nycflights13)

#View Datas sets in the package
data(package = "nycflights13")
?flights

#review structure
glimpse(flights)
glimpse(airlines)
glimpse(airports)
glimpse(planes)
glimpse(weather)

##which month has the most flights?
flights %>%
  count(month)%>%
  arrange(desc(n))%>%
  head(1)

##Top 3 destination airport in July 
flights %>%
  left_join(airports, by = c("dest"="faa"))%>%
  filter(month == 7)%>%
  group_by(dest, airports_name = name)%>%
  summarise(flights = n())%>%
  arrange(desc (flights))%>%
  head(3)


##Which Airlines have the highest average departure delay in 2013?
flights%>%
  left_join(airlines, by = "carrier")%>%
  select(carrier, airlines_name = name, contains("delay"))%>%
  group_by(airlines_name)%>%
  summarise(n_flights = n(),
            mean_dep_delay = mean(dep_delay, na.rm = TRUE))%>%
  arrange(-mean_dep_delay)%>%
  head(1)


##Add Quarter and Flights Status column 
flights_add <- flights %>%
mutate(Q = if_else(month %in% 1:3, "Q1", 
                    if_else(month %in% 4:6, "Q2",
                            if_else(month %in% 7:9, "Q3", "Q4"))))%>%
mutate(dep_status = if_else( dep_delay > 15, "Delayed", "On-time"), #Consider 15 minutes late as delayed flight
        dep_status = replace_na(dep_status, "Cancelled"))


##How many flights in each departure status?
flights_add%>%
  group_by(dep_status)%>%
  summarise(n = n())%>%
  mutate(pct = round(n/sum(n)*100))


##How many flights had daparted NYC quarterly?
flights_add%>%
  group_by(Q)%>%
  summarise(n = n())%>%
  mutate(pct = n/sum(n)*100)

##Flights Status Quarterly 
flights_StatusQ <- flights_add%>%
  group_by(Q, dep_status)%>%
  summarise(n = n())%>%
  mutate(pct = round(n/sum(n)*100))  

##Which quarter has the most "on-time" flights? 
flights_StatusQ%>%
  filter(dep_status == "On-time")%>%
  rename(each_Q_pct = pct)%>%
  arrange(-n)%>%
  head(1)
