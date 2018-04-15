library(shiny)
library(shinydashboard)
library(shinyBS)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  observeEvent(input$submit2,{
    if(input$average!=0 && input$word !=0){
      data1<-data
      data$estimatedSalary[data$estimatedSalary<(input$salary)]=0
      data$estimatedSalary[data$estimatedSalary>=(input$salary)]=1
      data<-data[which(data[,"normTitleCategory"] == as.character(input$job)),]
      fit1 = glm(estimatedSalary ~  descriptionWordCount + avgOverallRating +   experienceRequired + licenseRequiredJob+educationRequirements,
                 data = data,family = binomial)
        fit2 = lm(estimatedSalary ~  descriptionWordCount + avgOverallRating +   experienceRequired + licenseRequiredJob+educationRequirements,
                   data = data1)
      p1<-summary(fit1)
       p2<-summary(fit2)
      
      if (input$license == "Yes"){
        license<-1
      }
      else if(input$license == 'No') {
        license<-0
        
      }
      if(input$education =="High School"){
        x<-0
          x1<-0
      }
      else if(input$education =="Higher Education"){
        x<- p1$coefficients[6,1]
            x1<-p2$coefficients[6,1]
      }
      else if(input$education =="None"){
        x<- p1$coefficients[7,1]
            x1<-p2$coefficients[7,1]
      }
      probability = ((exp(p1$coefficients[1,1]+p1$coefficients[2,1] * as.numeric(input$word) + p1$coefficients[3,1] * as.numeric(input$average)+
                           p1$coefficients[4,1]* as.numeric(input$experience) + p1$coefficients[5,1] * license +x ))/
        (1 + (exp(p1$coefficients[1,1]+p1$coefficients[2,1] * as.numeric(input$word) + p1$coefficients[3,1] * as.numeric(input$average)+
                    p1$coefficients[4,1]* as.numeric(input$experience) + p1$coefficients[5,1] * license + x))))*100
       salaryshould = p2$coefficients[1,1] + p2$coefficients[2,1] * as.numeric(input$word) +  p2$coefficients[3,1] * as.numeric(input$average)+
                    p2$coefficients[4,1]* as.numeric(input$experience) + p2$coefficients[5,1] * license + x1 
      output$prob<-renderText({
        print(probability)
        
      })
      output$estimatedsalary<-renderText({
       
        print(salaryshould)
      })
    }
    else {
      data1<-data
      data$estimatedSalary[data$estimatedSalary<(input$salary)]=0
      data$estimatedSalary[data$estimatedSalary>=(input$salary)]=1
      data<-data[which(data[,"normTitleCategory"] == as.character(input$job)),]
      fit1 = glm(estimatedSalary ~ experienceRequired + licenseRequiredJob+educationRequirements,
                 data = data,family = binomial)
      fit2 = lm(estimatedSalary ~  experienceRequired + licenseRequiredJob+educationRequirements,
                data = data1)
      p1<-summary(fit1)
      p2<-summary(fit2)
     
      if (input$license == "Yes"){
        license<-1
      }
      else if(input$license == 'No') {
        license<-0
        
      }
      if(input$education =="High School"){
        x<-0
        x1<-0
      }
      else if(input$education =="Higher Education"){
        x<- p1$coefficients[4,1]
        x1<- p2$coefficients[4,1]
      }
      else if(input$education =="None"){
        x<- p1$coefficients[5,1]
        x1<- p2$coefficients[5,1]
      }
      probability = ((exp(p1$coefficients[1,1]+p1$coefficients[2,1]* as.numeric(input$experience) + p1$coefficients[3,1] * license + x))/
        (1 + (exp(p1$coefficients[1,1]+p1$coefficients[2,1]* as.numeric(input$experience) + p1$coefficients[3,1] * license + x))))*100
      salaryshould = p2$coefficients[1,1]+p2$coefficients[2,1]* as.numeric(input$experience) + p2$coefficients[3,1] * license + x1 
      output$prob<-renderText({
        print(probability)
       
      })
      output$estimatedsalary<-renderText({
        
        print(salaryshould)
      })
    }
    
  })
  
  
})

