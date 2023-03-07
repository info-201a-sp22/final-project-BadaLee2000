library(plotly)
library(ggplot2)
library(dplyr)
library(rsconnect)
library(shiny)
library(plotly)
library("scales")

mentalhealth_df <- read.csv("https://raw.githubusercontent.com/info-201a-wi23/exploratory-analysis-BadaLee2000/main/depression_anxiety_data.csv")
mentalhealth_df2 <- mentalhealth_df %>% group_by(gender, depression_severity) %>% summarize(count = length(depression_severity))
my_server <- function(input,output){
  #chart 1
  
  # Creates a bar chart and uses color for gender
  output$chart1 <- renderPlotly({
    input_gender <- mentalhealth_df2 %>% filter(gender == input$analysis_var)
    line_plot <- ggplot(data = input_gender) +
      geom_point(aes(x = depression_severity,
                     y = count,
                     color = gender)) +
      geom_line(aes(x = factor(depression_severity),
                    y = count,
                    color = gender,
                    group = gender)) +
      labs(title = "Depression Severity Based on Gender of College Students",
           x = "Depression Severity",
           y = "Count",
           color = "Gender") +
      scale_color_manual(values=c("black"))
    ggplotly(line_plot)
  })

  #chart 1 analysis
  output$chart1_analysis <- renderText({ 
    "This chart is a data visualization that shows the different trends between gender and depression severity in college students. 
    It shows that while men have higher none to none-minimal depression, women have higher mild to severe depression. 
    This data visualization is important because it shows how while both women and men face depression, college students who identify as women 
    have predominantly worse depression. Overall this chart shows the difference in trends between male and female students."
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
    labs(title = "Severity of Depression in College Students Based on Age", x = "Age", y = "Student Count", fill = "Depression Severity")
  ggplotly(chart2)
  })
  
  #chart 2 analysis
  output$chart2_analysis <- renderText({ 
    "This chart is a data visualization that shows the correlation between age and depression severity in college students. 
    It is important to notice that depression often peaks between age 19-22. This is important because it can help destigmatize that 
    individuals with depression in their early twenties are alone. This data visualization helps combat the notion that young individuals should be embarrassed to face depression.
    The fact there are significantly less students with depression after age 24, can also be explained by the fact
    there aren't many students over the age of 24 in the data set."
  })
  
  
  # Chart 3
  
    
    new_mh_df <- mentalhealth_df %>% select(school_year, depression_severity)
    
    na_mh_df <- na.omit(new_mh_df)
    
    levels(as.factor(na_mh_df$depression_severity))
    
    
    
    output$chart3 <- renderPlotly({
      
      selected_year <- na_mh_df %>% 
        filter(school_year %in% input$user_year_selection)
    
      chartplot3 <- ggplot(selected_year, aes(y = school_year,
                                         fill = factor(depression_severity, 
                                                       levels = c("none", "None-minimal", "Mild", "Moderate", 
                                                                  "Moderately severe", "Severe")),
                                         text = paste("Depression Severity:", depression_severity, "<br>",
                                                      "Percent of Students:"))) +
        geom_bar(stat = "count",
                 position = "fill") +
        scale_fill_brewer(palette = "Oranges") +
        labs(title = "Severity of Depression in College Students",
             x = "Percent of College Students",
             y = "Year of College",
             fill = "Depression Severity") +
        scale_y_continuous(breaks = c(1, 2, 3, 4))
      
      
      ggplotly(chartplot3, tooltip = "text")
  })
  
  # Chart 3 analysis
    output$chart3_analysis <- renderText({
    "This chart is a data visualization that shows the correlation between class standing and depression severity in college students. We wanted to see if certain college years made a students depression more severe. Since coursework tends to get harder the further you are into college, we wanted to determine if the severity of depression gets worse too? From the graph, it shows that the higher year of college doesn't increase a students depression severity. There are actually more first year college students with severe depression than fourth year college students with severe depression. With the selection choices on the left-hand side, users are able to choose which years they want to compare."
    })
      
}
