library(plotly)
library(ggplot2)
library(dplyr)
library(rsconnect)
library(shiny)
library(plotly)

mentalhealth_df <- read.csv("https://raw.githubusercontent.com/info-201a-wi23/exploratory-analysis-BadaLee2000/main/depression_anxiety_data.csv")

my_server <- function(input,output){
  #chart 1
  gender_df <- mentalhealth_df %>% group_by(gender) %>% select(depression_severity)
  
  # Creates a bar chart and uses color for gender
  output$chart1 <- renderPlotly({
    chart1 <- ggplot(data = gender_df) +
      geom_bar(aes(x = depression_severity,
                   fill = gender),
               position = "dodge") +
      scale_x_discrete(limits = c("none", "None-minimal", "Mild", "Moderate", "Moderately severe", "Severe")) +
      theme(axis.text = element_text(size = 8)) +
      scale_fill_manual(values = c("#DE3163","#0096FF")) +
      labs(title = "Severity of Depression in College Students",
           x = "Depression Severity", 
           y = "Count of College Students",
           fill = "Gender")
    ggplotly(chart1)
  })

  #chart 2
  age_df <- mentalhealth_df %>% group_by(age) %>% select(depression_severity)

  output$chart2 <- renderPlotly({
    low_yr <- input$slider[1]
    high_yr <- input$slider[2]
    input_df <- age_df %>% filter(age >= low_yr & age <= high_yr)
    chart2 <- ggplot(data = input_df) +
    geom_histogram(aes(
      x = age, 
      fill = depression_severity)) +
    labs(title = "Severity of Depression in College Students", x = "Age", y = "Student Count", fill = "Depression Severity")
  ggplotly(chart2)
  })
  
}
