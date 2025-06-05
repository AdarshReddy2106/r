install.packages('rsconnect')

rsconnect::setAccountInfo(name='adarsh-r',
                          token='A16FD02E4D484C041A959ED241271067',
                          secret='rgUGo9u9kfCkiArAgUaWt37NWgq6prh/6bvYa1sy')
library(rsconnect)
rsconnect::deployApp('A:/Shiny R/bmi-r')
