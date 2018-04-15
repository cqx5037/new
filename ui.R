library(shiny)
library(shinydashboard)
library(shinyBS)
library(data.table)
data<-read.csv("sample.csv")
# Define UI for application that draws a histogram
shinyUI(
  dashboardPage(
    dashboardHeader(
      title = "DataFest & Indeed",
      titleWidth = 300
    ),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Introduction", tabName = "intro", icon = icon("dashboard")),
        menuItem("Calculator", icon = icon("th"), tabName = "cal",
                 badgeLabel = "new", badgeColor = "orange")
      )
    ),
    dashboardBody(
      tags$head(tags$style(HTML('
                              /* logo */
                                .skin-blue .main-header .logo {
                                background-color: #4351f4;
                                }
                                
                                /* logo when hovered */
                                .skin-blue .main-header .logo:hover {
                                background-color: #4351f4;
                                }
                                
                                /* navbar (rest of the header) */
                                .skin-blue .main-header .navbar {
                                background-color: #4351f4;
                                }        
                                
                                /* main sidebar */
                                .skin-blue .main-sidebar {
                                background-color:#4351f4;
                                }
                                
                                /* active selected tab in the sidebarmenu */
                                .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
                                background-color: #4351f4;
                                }
                                
                                /* other links in the sidebarmenu */
                                .skin-blue .main-sidebar .sidebar .sidebar-menu a{
                                background-color: #4351f4;
                                color: #000000;
                                }
                                
                                /* other links in the sidebarmenu when hovered */
                                .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover{
                                background-color: #ffae00;
                                }
                                /* toggle button when hovered  */                    
                                .skin-blue .main-header .navbar .sidebar-toggle:hover{
                                background-color: #4351f4;
                                }
                                '))),
      tabItems(
        # First tab content
        tabItem(tabName = "intro",
                fluidPage(
                  wellPanel(style = "background-color: #EAF2F8",
                            div(style = "text-align: center", h1("Salary Helper")),
                                h3("The salary calculator can help a job seeker to calculate the probability of getting a ideal salary,
                                   and estimate the most resonable salary based on his current situation. After the result, the job seeker may 
                                    have some basic idea on how to improve his salary and how to find a suitable job."),
                            br(),
                            br(),
                            br(),
                            br(),
                               h2("Special Thanks: "),
                                h3("we would like to thanks indeed company to supply theri past data. We want to also give the special
                                   thanks for all the helps given by DataFest ")
                            
)
                  
                )),
        tabItem(tabName = "cal",
      fluidPage(
        textOutput("hhh"),
        wellPanel(style = "background-color: #EAF2F8",
                  h1("Salary Calculator"),
                  h3("The calculator can help you calculate the probability to get your ideal salary and the most resonable salary based on your current situation"),
                  selectInput("job",label=h3("Please select the job title"),
                              choices=list("accounting","admin","agriculture","arch","arts",
                                           "aviation","care","childcare","construction","customer","driver",
                                           "education","engchem","engcivil","engelectric", "engid","engmech",
                                           "finance","food","hospitality","hr","install","insurance",
                                           "legal","management","manufacturing","marketing","math","meddental",
                                           "meddr","media","medinfo","mednurse","medtech","military",
                                           "mining","personal","pharmacy","project","protective","realestate",
                                           "retail","sales","sanitation", "science", "service socialscience",
                                           "sports","tech","techhelp","techinfo","techsoftware","therapy",
                                           "transport", "uncategorized","veterinary","warehouse" )
                  ),
                  div(style = "text-align: center" ,bsButton("submit1", "Ready!", style = "warning"))),
        fluidPage(
          conditionalPanel("input.submit1 !=0", 
                           wellPanel(style = "background-color: #EAF2F8",
                                     h1("Please enter the following infomration"),
                                     fluidRow(
                                       column(8,
                                              numericInput("salary", "Please enter your expected salary", min=0, value=0),
                                              numericInput("experience", "Please enter your job experience in years", min=0, value=0),
                                              
                                              radioButtons( "license", "Do you have at least one license for your job?", c("Yes","No")),
                                              radioButtons( "education", "What is your highest education level", c("None","High School", "Higher Education")),
                                              checkboxGroupInput("advance", "Advance search",c("Yes")),
                                              fluidPage(
                                                conditionalPanel("input.advance !=0", 
                                                                 sliderInput("average",label="Average overall Rating of a company",min=1,max=5,step=1, value=0),
                                                                 numericInput("word", "Please enter your expected length of job description word", min=0, value=0))
                                              ),
                                              div(style = "text-align: right" ,bsButton("submit2", "Calculate!", style = "warning"))
                                       ),
                                       column(4, 
                                              conditionalPanel("input.submit2 !=0",
                                                        h4("based on your current information, the probability that you can get you expected salary is:"),
                                              wellPanel(style = "background-color: #F4F6F6",
                                                        h2(textOutput("prob"),"%" )),
                                              h4("based on your current information, you are most likely to get: "),
                                              wellPanel(style = "background-color: #F4F6F6",
                                                        h2(textOutput("estimatedsalary")))
                                       )))))
          
        ))))
      )))
    
  
