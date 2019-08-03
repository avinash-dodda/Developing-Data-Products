library(shiny)
library(shinyWidgets)

# Define UI for application 
shinyUI(pageWithSidebar(

    # Application title
    headerPanel("Breast Cancer Test Results"),

    # Sidebar with a slider input
    
        sidebarPanel(
            sliderTextInput("Clump_Thickness",
                        "Clump Thickness",
        choices = c("1","2","3","4","5","6","7","8","9","10"),
                        selected = c("5")),
            sliderTextInput("Uniformity_of_Cell_Size",
                        "Uniformity of Cell Size",
                        choices = c("1","2","3","4","5","6","7","8","9","10"),
                        selected = c("5")),
            sliderTextInput("Uniformity_of_Cell_Shape",
                        "Uniformity of Cell Shape",
                        choices = c("1","2","3","4","5","6","7","8","9","10"),
                        selected = c("5")),
            sliderTextInput("Marginal_Adhesion",
                        "Marginal Adhesion",
                        choices = c("1","2","3","4","5","6","7","8","9","10"),
                        selected = c("5")),
            sliderTextInput("Single_Epithelial_Cell_Size",
                        "Single Epithelial Cell Size",
                        choices = c("1","2","3","4","5","6","7","8","9","10"),
                        selected = c("5")),
            sliderTextInput("Bare_Nuclei",
                        "Bare Nuclei",
                        choices = c("1","2","3","4","5","6","7","8","9","10"),
                        selected = c("5")),
            sliderTextInput("Bland_Chromatin",
                        "Bland Chromatin",
                        choices = c("1","2","3","4","5","6","7","8","9","10"),
                        selected = c("5")),
            sliderTextInput("Normal_Nucleoli",
                        "Normal Nucleoli",
                        choices = c("1","2","3","4","5","6","7","8","9","10"),
                        selected = c("5")),
            sliderTextInput("mitoses",
                        "Mitoses",
                        choices = c("1","2","3","4","5","6","7","8","9","10"),
                        selected = c("5")),
            submitButton('Submit')
        ),

        
        mainPanel(
            
            tabsetPanel
            (
                tabPanel("Breast Cancer Test Results",
                         h3('Accroding to your test results, the prediction is:'),
            verbatimTextOutput("prediction"),
            h3('and accuracy of prediction is'),
            verbatimTextOutput("accuracy")),
                
                tabPanel(
                    "Documentation",
                    p(h3("Breast Cancer Test Results Application")), 
                    p(h4("Application Summary")),
                    
                    helpText("This application predicts whether the Breast Cancer test results indicate positive cancer or not."),
                    p(h4("User Inputs")),
                    helpText("This application takes the following inputs from a Breast Cancer test", 
                             HTML(
            "<ul><li>Clump Thickness</li>
            <li>Uniformity of Cell Size</li>
            <li>Uniformity of Cell Shape</li>
            <li>Marginal Adhesion</li>
            <li>Single Epithelial Cell Size</li>
            <li>Bare Nuclei</li>
            <li>Bland Chromatin</li>
            <li>Normal Nucleoli</li>
            <li>Mitoses</li></ul>")),
                
                helpText("All above inputs are integer levels ranging from 1-10 with default input at 5."),
            
            p(h4("How To Use App")),
            
            helpText("Use sliders provided for each user input and set the values. Click on Submit. The output of results will be shown in the", strong("Breast Cancer Test Results"), "tab."),
            p(h4("Interpreting Output")),
            
            helpText("If the output of results is", strong("Yes Breast Cancer"), "then the tumor is Malignant."),
            helpText("If the output of results is", strong("Not Breast Cancer"), "then the tumor is Benign."),
            helpText("The", strong("Accuracy"), "of the prediction model is also shown in output."),
            
            p(h4("Source Code and Data Reference")),
            p(HTML("<a>Source Code<a>")),
            p(HTML("<a>Data Reference<a>"))
            
        ))
    )
))
