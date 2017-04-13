# setwd("/Users/nowakchr/Desktop/testplots")
library(shiny)


shinyUI(pageWithSidebar(
  titlePanel(title = div(img(src='UU_logo.jpeg', align="bottom",width=100,height=100),"Metabolites during OGTT")),
  # headerPanel("Metabolites during OGTT"),
  sidebarPanel(
    selectInput("variable", "Metabolite:",
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
    checkboxInput("quartile", "Insulin resistance (red) vs. insulin sensitive (blue)*", F),
    helpText(""),
    helpText("*Men in the lowest quartile (RED, most insulin resistant, n=117) compared to highest
             quartile (BLUE, least insulin resistance, n=117) of hyperinsulinaemic-euglycaemic
             clamp M/i", style= "color:darkblue; font-style:italic;font-size:11px")
    ),
  mainPanel(
    h3(textOutput("caption")),
    plotOutput("mpgPlot"),
    span(textOutput("message"), style="color:#0020C2; font-style:italic;font-size:12px"),
    span(htmlOutput("message_space"), style="color:darkblue; font-style:italic;font-size:12px"),
    span(htmlOutput("message1"), style="color:darkblue; font-style:normal;font-size:12px"),
    span(htmlOutput("message2"), style="color:darkblue; font-style:normal;font-size:12px"),
    span(htmlOutput("message3"), style="color:darkblue; font-style:normal;font-size:12px"),
    span(htmlOutput("message4"), style="color:darkblue; font-style:normal;font-size:12px")
  )
))





