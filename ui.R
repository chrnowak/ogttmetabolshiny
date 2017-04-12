##### GITHUB TEST VERSION ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####   ######
##### Chris Nowak 12 April 2017  ##### ##### ##### ##### ##### ##### ##### ##### ##### #####  ######
library(shiny)

## setwd("/Users/nowakchr/Desktop/testplots")

##### Shiny user interface function
shinyUI(pageWithSidebar(
  
  headerPanel("Plasma metabolites during oral glucose challenge"),
  
  sidebarPanel(
    selectInput("variable", "Variable:",
                list("C10-carnitine" = "c10",
                     "C12-carnitine" = "c12",
                     "Oleic acid" = "ol",
                     "Palmitoleic acid" = "pal",
                     "Hexose" = "hex",
                     "Dexoxycholic acid-glycine" = "doca",
                     "LysoPE(18:1)" = "l181",
                     "LysoPE(18:2)" = "l182",
                     "LysoPE(20:4)" = "l204",
                     "L-carnitine" = "lc",
                     "C2-carnitine" = "c2",
                     "C8-carnitine" = "c8",
                     "C14-carnitine" = "c14",
                     "C16-carnitine" = "c16",
                     "C18-carnitine" = "c18")),

    checkboxInput("SD_show", "SD narrow?", FALSE),
    checkboxInput("colour", "Coloured?", F),
    checkboxInput("quartile", "Insulin resistance (red) vs. insulin sensitive (blue)", F)
    ),
  
  mainPanel(
    h3(textOutput("caption")),
    plotOutput("mpgPlot")
  )
))


