library(shiny)
buydata <- read.csv("data/buysData.csv")
shinyUI(fluidPage(
  
  titlePanel("Computer Purchase Prediction App"),
  
  navlistPanel(    
    tabPanel("Introduction",
             h3("Objective:"),
             p("Our main goal of this project is to develop a shiny App which predicts the person can buy the computer or not based on the LVQ model created using our training set data ."),
             h3("LVQ Classification:"),
             p("The Learning Vector Quantization (LVQ) will be used in all examples because of its simplicity. It is like k-nearest neighbors, except the database of samples is smaller and adapted based on training data."),
             h3("Sample Dataset:"),
             p("For this App I used the training dataset which was collected from 42 person whose features such as age, income, student,
and credit are stored and the output class label is 'buy' which contains values either yes/no based on the person purchase computer."),
             h3("Data Preprocessing:"),
             p("The dataset can be preprocessed as part of the parameter tuning. It is important to do this within the sample used to evaluate each model, to ensure that the results account for all the variability in the test. As the attributes in this dataset are all in the same units, so normalization and standardization are not really necessary."),
             h3("Prediction:"),
             p("LVQ model is created using training dataset and later our ShinyAPP is used to Predict whether the person with the input feature will buy the computer or not after click of Predict button.")
             
    ),
    tabPanel("Training data ",
             p( "Source from where training data is collected:",  a("Link to Paper",  target="_blank",   href="http://cis.poly.edu/~mleung/FRE7851/f07/naiveBayesianClassifier.pdf")
             ),
             tableOutput("table")), 
    tabPanel("Data Exploration",  
             h3("Feature Selection:"),
             p("Identify the important variable to consider to explore."),
             br(),
             plotOutput('plotimp', width = "50%", height = "200px") ,   
             p("As we found credit and student are the main feature we plot them against each other with 'buy' attribute as color "),
             plotOutput('plot21', width = "50%", height = "200px")    
    ), 
    tabPanel("PredictTool",             
               
               mainPanel(
                 tags$style(type='text/css', '#text1 {background-color: rgba(0,0,0,0.10); color: blue;}'), 
                 h4("Select the characteristic of the person :"),
                 selectInput("age", 
                             label = "Age:",
                             choices = c("senior", "youth",
                                         "middle-aged"),
                             selected = "senior"),
                 selectInput("income", 
                             label = "Income:",
                             choices = c("high", "medium",
                                         "low"),
                             selected = "high"),
                 selectInput("student", 
                             label = "Student:",
                             choices = c("yes", "no"),
                             selected = "yes"),
                 selectInput("credit", 
                             label = "Credit:",
                             choices = c("fair", "excellent" ),
                             selected = "fair"),
                 br(),
                 tags$head(
                   tags$style(HTML('#Predict{background-color:gray}'))
                 ),
                 p("Click to Predict:",actionButton("Predict", "Predict!")),
               
                 h3("Prediction Result: ",
                 textOutput("text1", container=strong)), 
                 br(),
                 br(),
                 h5("Hint: "),
                 p(" -- All aged person with low income are always not much interested "),
                 p(" -- Youth person always interested to buy irrespective of other credit")
                 
                 
              )
             )  
  )
  
))
