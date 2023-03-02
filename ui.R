library(plotly)
library(ggplot2)
library(dplyr)
library(rsconnect)
library(shiny)

mentalhealth_df <- read.csv("https://raw.githubusercontent.com/info-201a-wi23/exploratory-analysis-BadaLee2000/main/depression_anxiety_data.csv")

intro <- tabPanel(
  titlePanel("Main Page"),
  mainPanel(
    h1("P03: Final Deliverable"),
    h2("Depression and Anxiety Data"),
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
"Interactive Visualization",
  plotlyOutput("chart1")
)
#interactive tab 2
interactive_tab2 <- tabPanel(
  "Interactive Visualization 2",
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
  plotlyOutput("chart2")
)
)
)
#interactive tab 3
interactive_tab3 <- tabPanel(
  "Interactive Visualization 3"

)

#conclusion tab
conclusion_tab <- tabPanel(
  "Conclusion"
)
intro_tab <- navbarPage(
  "Our Shiny App",
  intro,
  interactive_tab1,
  interactive_tab2,
  interactive_tab3,
  conclusion_tab
)



