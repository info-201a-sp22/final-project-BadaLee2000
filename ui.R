library(plotly)
library(ggplot2)
library(dplyr)
library(rsconnect)
library(shiny)

mentalhealth_df <- read.csv("https://raw.githubusercontent.com/info-201a-wi23/exploratory-analysis-BadaLee2000/main/depression_anxiety_data.csv")

intro <- tabPanel(
  titlePanel("Introduction"),
  mainPanel(
    h1("P03: Final Deliverable"),
    h2("Depression and Anxiety Data"),
    img("", src = "https://www.apa.org/images/2022-10-feature-campus-crisis-tile_tcm7-309786.jpg",
        width = "600", height = "300", align = "center"),
    h3("Authors"),
    p("Jason Cabusao, Jamie Kim, Bada Lee, and Tamia Ouch"),
    
    h3("Date"),
    p("March 9, 2023 (Winter 2023) "),
    
    h3("Abstract"),
    p("Our main question is if students' mental health has been affected in a negative way based on the factors including age, gender, and class standing. This question is important because depression and anxiety are very common among students these days which affect their studies and social well-being. Accordingly, we plan to compare each factor with depression, depression severity, depression diagnosis, anxiety, anxiety diagnosis, suicide, and etc."),
    
    h3("The purpose/importance of the project"),
    p("The motivation behind the research questions is the success of students in both well-being and academic performances. With the variables that make students different such as age, gender, and class standing, it is possible to find out in what age, in which gender, and in which school year, the students get the most depression and anxiety. More specifically, the factors, age, gender, and class standing, will be compared with depression severity, depression diagnosis, and anxiety diagnosis. For example, if there is a specific age or school year or gender that most students get stressed, depressed, or anxious, it is a great idea for their parents, teachers, siblings to take care of the students more attentively since the students' acquaintances and the environment influence them a lot."),
    p("It is really important for students to have good mental health because it affects how we think, feel, and act. Mental health can also affect their education, social life, and emotional well-being. It is also important for students to realize that mental health is not something to be ashamed of. To produce better academic performances as students, it is essential to keep their mental health strong and stable. Looking into the data set will give us an idea of how many students feel the lots of pressure to put into academics over mental health. Hopefully, we find out what groups struggle the most and find a way to offer help."),
    
    h3("Main Questions"),
    p("1) Does gender affect students' mental health?"),
    p("2) Does age affect students' mental health?"),
    p("3) Does class standing affect students' mental health?"),
    p("4) Which age group struggle the most from depression or anxiety?"),
    p("5) Which gender has been more influenced by the factors including depression, depression severity, anxiety, or anxiety severity?"),
    
    h3("The Dataset"),
    p("The data is found on the website called Kaddle which is an online platform for data scientists and even learners. https://www.kaggle.com/datasets/shahzadahmad0402/depression-and-anxiety-data?resource=download."), 
    p("The data was collected by Shahzad Ahmed from undergraduate students at the University of Lahore where there were 787 participants."), 
    p("The data was generated from the inspiration of the Beck Depression and Beck Anxiety inventories."),
    p("The data was collected to evaluate different machine learning methods and to compare the different machine learnings classification approaches."),
    
    h3("Ethical Questions and Limitations"),
    p("Possible limitations for approaching this data will be due to lack of explanations and the context behind it. 
    It is often complicated to measure someone’s mental health and usually it is associated with personal backgrounds and possibly from their childhood. Considering this fact, measuring someone’s mental health within 19 features might not yield an ideal outcome for this project. 
    Furthermore, some of the features have only two options to represent the status of a student, which are ‘TRUE’ and ‘FALSE.’ Therefore, these might also function as two extreme classifications representing an individual’s status."),
    p("Another possible limitation can be due to the gender classification of its data. 
    There are only two categories to represent the identity of a student, which is excluding the possible factors that could function as a crucial factor to explain the mental health of a student. 
    Our chosen data does not provide a holistic view of each student’s life. We have to be very careful when dealing with data that doesn’t share a characteristic of qualitative data. Lastly, although the data shows a large number of students with high levels of anxiety-severity, only a small part of the data shows they are diagnosed as depressed or getting treatment for it."),
    
    p("One broad challenge we might need to address in regard to gender affecting a students mental health is the dismantling of gender stereotypes and gender normative behavior. 
    Because of societies’ views and the environment it fosters when discussing gender, it can be damaging to those who fit, or fail to fit, in those gender binary ideologies."),
    p("Folks who identify as a man may face conflict with other men in their environment when they don’t partake in traditional masculine activities. 
    This goes the same for folks who do identify as a woman. If they fail to conform to what society deems as feminine, they may be outcasted or viewed differently. 
    These gender stereotypes are only damaging the mental healths of students who are struggling to fit into these boxes."),
    p("One limitation policy makers might run into is successfully implementing systems that will ultimately aid and support folks struggling with mental health problems. 
    Because this topic is so polarizing and lacks bipartisanship, it can be hard to convince policymakers of one party to come to an agreement regarding mental health care."),
    p("Another limitation we should be aware of is the faults that come with using BMI as a gauge to determine a student’s health status. 
    Because BMI only takes into consideration weight and height, it exposes us to a big margin of error. Disregarding the muscle mass of an individual can greatly skew and misinterpret the BMI of an individual."),
    p("Another important challenge is the classifications of sex and its intricacies. The data set only looks at males and females, and disregards college students who are intersex. It forces those that are unsure into a gender binary."),
    p("An additional challenge we need to look at is deciphering whether a college student's actual sex influenced their mental health, or if their environment and attitudes towards their sex is to blame. Because of societies’ views and the environment it fosters when discussing a person's sex, it can be damaging to those who fit, or fail to fit, in those gender binary ideologies. 
    Folks who identify as a man may face conflict with other men in their environment when they don’t partake in traditional masculine activities. This goes the same for folks who do identify as a woman. If they fail to conform to what society deems as feminine, they may be outcasted or viewed differently. These gender stereotypes are only damaging the mental health of students who are struggling to fit into these boxes.")
    
    
  )
)
#interactive tab 1
interactive_tab1 <- tabPanel(
  titlePanel("Visualization 1"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "analysis_var",
        label = "Choose a Gender",
        choices = c("female", "male"),
        selected = "female"),
  ),
  mainPanel(
  plotlyOutput("chart1"),
  h2("What the Chart Represents and Concludes", align = "center"),
  textOutput("chart1_analysis")
)
)
)
#interactive tab 2
interactive_tab2 <- tabPanel(
  titlePanel("Visualization 2"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "slider",
        label = "Year range:",
        min = 17, 
        max = 31,
        value = c(17,31))
    ),
    
    # Display the map and table in the main panel
  mainPanel(
  plotlyOutput("chart2"),
  h2("What the Chart Represents and Concludes", align = "center"),
  textOutput("chart2_analysis")
)
)
)

# Variables for interactive tab 3
new_mh_df <- mentalhealth_df %>% select(school_year, depression_severity)

na_mh_df <- na.omit(new_mh_df)

levels(as.factor(na_mh_df$depression_severity))

# Interactive tab 3
year_select <- selectInput(
  inputId = "user_year_selection", 
  label = "Select a college year",
  choices = unique(na_mh_df$school_year),
  selected = "1",
  multiple = TRUE
)

interactive_tab3 <- tabPanel(
  titlePanel("Visualization 3"),
  sidebarPanel(year_select),
  mainPanel(plotlyOutput("chart3"),
            br(),
            h2("What the Chart Represents and Concludes", align = "center"),
            textOutput("chart3_analysis")
            )
  )

#conclusion tab
conclusion_tab <- tabPanel(
  titlePanel("Conclusion"),
  mainPanel(
    h3("Takeaways"),
    p("We aimed to investigate the relationship between depression severity and various variables including age, gender, and class standing."),
    p("According to our first graph, while men have higher number of 'none' to 'none-minimal depression', women have higher number of 'mild' to 'severe depression'. 
      This visualization is significant because it highlights the gender differences in depression prevalence among college students.
      Although both male and female students may experience depression, the data suggests that female students are more likely to report moderate to severe symptoms.
      Overall, the chart shows the difference in trends between male and female students."),
    p("According to our second graph, it is important to notice that depression often peaks between ages of 19-22. 
      This is important because it can help destigmatize that individuals with depression in their early twenties are alone. 
      This data visualization helps combat the notion that young individuals should be embarrassed to face depression."),
    p("According to our last graph, it shows that the higher year of college doesn't increase a students depression severity. 
      There are actually more first year college students with severe depression than fourth year college students with severe depression."), 
    h3("Insights"),
    p("Through the analysis, we were able to learn the levels of students' depression severity based on their gender (female or male), 
    ages (between 17 years old to 31 years old), and the college years (freshman to senior years). The most important insight
      includes estimating the prevalence of depression of students, the factors that cause depression, and the impact of depression on academic performances as well as students' well-being."), 
    p("In more details, the first graph provides insights into the gender based trends in depression among college students. 
    The second graph provides insights into the age related trends in depression among college students and can help to promote greater awareness of mental health issues among young adults.
    The third graph provides insights into the relationship between college year and depression severity among college students."),
    p("The trends and patterns of the charts can be useful to find out the type of therapy that students need or which specfic age group needs more care than the other.
    The insights gained from analyzing data on students' depression can provide valuable information for creating interventions and support services 
      for the students who are struggling with depression. This not only can help improve their mental health and well-being but also help students improve their academic performance and success."),
    h3("Implications"),
    p("The insights from the data on depression of students can have broad implications for addressing mental health concerns. 
      With the number of students who experience depression, the factors that contribute to depression, and the impacts on academic performance, 
      those who are in charge of taking care of students including parents, teachers, schools, and other organizations can provide better supports for students with depression. 
      The insights can also influence the policies aimed at promoting students' healthy mental health and well-being. For example, the program to reduce students' stress or depression can be created for schools."),
    p("Additionally, understanding of the impact of depression on students, schools and other organizations can work to reduce the negative attitudes and stereotypes on mental illness. 
    This can promote a more supportive environment where students can think that mental illness is not something that they need to hide. 
    This can allow students feel more comfortable seeking help and support, which will eventually improve students' mental health and well-being, not only among students but also in society."),
  
  )
)
intro_tab <- navbarPage(
  "INFO201",
  intro,
  interactive_tab1,
  interactive_tab2,
  interactive_tab3,
  conclusion_tab
)



