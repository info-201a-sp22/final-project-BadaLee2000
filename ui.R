library(plotly)
library(ggplot2)
library(dplyr)
library(rsconnect)
library(shiny)

depression_df <- read.csv("depression_anxiety_data.csv", stringsAsFactors = FALSE)

intro_tab <- tabPanel(
  titlePanel("My Shiny App"),
  mainPanel(
    h1("P03: Final Deliverable"),
    h2("Depression and Anxiety Data"),
    h3("Authors"),
    p(""),
    h3("Date"),
    h3("The purpose/importance of the project")
  
  )
)

interactive_tab <- tabPanel(
  
  h1("Interactive Visualization")
  
)

# conclusion_tab 