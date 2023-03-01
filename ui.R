library(plotly)
library(ggplot2)
library(dplyr)
library(rsconnect)
library(shiny)

depression_df <- read.csv("depression_anxiety_data.csv", stringsAsFactors = FALSE)

intro_tab <- tabPanel(
  
  h1("Introduction"),
  p("blahblah")
  
)

interactive_tab <- tabPanel(
  
  h1("Interactive Visualization")
  
)
