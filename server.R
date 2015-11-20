library(shiny) 
library(e1071)
library(ggplot2)
library(caret)
library(pROC)
buydata <- read.csv("data/buysData.csv")
mod <- naiveBayes(buy ~ ., data = buydata)
control <- trainControl(method="repeatedcv", number=10, repeats=3)
model <- train(buydata$buy~., data=buydata, method="lvq", preProcess="scale", trControl=control)

# Define server logic for random distribution application
shinyServer(function(input, output) { 
  
  # Generate a summary of the data
  output$summary <- renderPrint({
    summary(buydata)    
  })
  output$plot21 = renderPlot({
    q<-qplot(buydata$credit, buydata$student, data = buydata, color = buydata$buy)
    q<-q + geom_point(size=I(3), xlab="XX", ylab="YY") 
    print(q)
  })
  output$plotimp = renderPlot({
   importance <- varImp(model, scale=FALSE) 
  plot(importance)
  })
  # Generate an HTML table view of the data
  output$table <- renderTable({   
    data.frame( (buydata))
  })
  
  ntext <- eventReactive(input$Predict, {
    toTest<-data.frame(age=input$age,income=input$income,student=input$student,credit=input$credit,buy="yes")
    Prediction<-predict(model,toTest[,-5])
    Prediction 
  })
  


  output$text1 <- renderText({ 
    paste(" ",ntext())
  })
  
  
})