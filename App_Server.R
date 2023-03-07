#chart 1
gender_df <- mentalhealth_df %>% group_by(gender, depression_severity) %>% select(depression_severity) %>% summarize(count = sum(length(depression_severity)))

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

mentalhealth_df <- read.csv("https://raw.githubusercontent.com/info-201a-wi23/exploratory-analysis-BadaLee2000/main/depression_anxiety_data.csv")
mentalhealth_df2 <- mentalhealth_df %>% group_by(gender, depression_severity) %>% summarize(count = length(depression_severity))
line_plot <- ggplot(data = mentalhealth_df2) +
  geom_point(aes(x = depression_severity,
                y = count,
                color = gender)) +
  geom_line(aes(x = factor(depression_severity),
                 y = count,
                 color = gender,
                group = gender)) +
  labs(title = "Depression Severity Based on Gender",
       x = "Depression Severity",
       y = "Count",
       color = "Gender")
ggplotly(line_plot)

