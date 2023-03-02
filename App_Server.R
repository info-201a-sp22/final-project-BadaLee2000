#chart 1
gender_df <- mentalhealth_df %>% group_by(gender) %>% select(depression_severity)

# Creates a bar chart and uses color for gender
output$chart1 <- renderPlotly({
  ggplot(data = gender_df) +
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
})
