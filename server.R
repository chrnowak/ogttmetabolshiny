##### GITHUB TEST VERSION ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####   ######
##### Chris Nowak 12 April 2017  ##### ##### ##### ##### ##### ##### ##### ##### ##### #####  ######
library(shiny)

############################################################################################# ######
########## on local machine: file prep ###################################################### ######
# setwd("/Users/nowakchr/Desktop/testplots")
##### upload metabolite data 
## c10 <- read.table( "C10-carnitine")
## c12 <- read.table("C12-carnitine")
## ol <- read.table( "Oleic acid")
## pal <- read.table( "Palmitoleic acid")
## l181 <- read.table( "LysoPE(18:1)")
## l182 <- read.table( "LysoPE(18:2)")
## l204 <- read.table( "LysoPE(20:4)")
## hex <- read.table( "Hexose")
## doca <- read.table( "Deoxycholate-glycine")
## c2 <- read.table( "C2-carnitine")
## c8 <- read.table( "C8-carnitine")
## c14 <- read.table( "C14-carnitine")
## c16 <- read.table( "C16-carnitine")
## c18 <- read.table( "C18-carnitine")
## lc <- read.table( "L-carnitine")

##### Function for mean, se per time pt across all
m_fun2 <- function(file){
  n <- deparse(substitute(file))
  v <- (unlist(aggregate(file$value ~ file$variable, FUN = mean)[2])[c(1,3,2)])
  v2 <- (unlist(aggregate(file$value ~ file$variable, FUN = sd)[2])[c(1,3,2)])
  m <- matrix(c(v,v2 / sqrt(117)), ncol = 1, nrow = 6)
  colnames(m) <- n
  return(data.frame(m))
}
## masterdata2 <- cbind(m_fun2(c10), m_fun2(c12), m_fun2(ol), m_fun2(pal),m_fun2(hex), m_fun2(doca), m_fun2(l181),
##                      m_fun2(l182), m_fun2(l204), m_fun2(c2), m_fun2(c8), m_fun2(c14), m_fun2(c16), m_fun2 (c18), m_fun2(lc))

##### Function for mean, se per time pt for Q1 and Q4
m_fun3 <- function(file){
  n <- deparse(substitute(file))
  v <- (unlist(aggregate(file$value[which(file$clampQuartile == "Q1")] ~ file$variable[which(file$clampQuartile == "Q1")],
                         FUN = mean)[2])[c(1,3,2)])
  v2 <- (unlist(aggregate(file$value[which(file$clampQuartile == "Q1")] ~ file$variable[which(file$clampQuartile == "Q1")],
                          FUN = sd)[2])[c(1,3,2)])
  w <- (unlist(aggregate(file$value[which(file$clampQuartile == "Q4")] ~ file$variable[which(file$clampQuartile == "Q4")],
                         FUN = mean)[2])[c(1,3,2)])
  w2 <- (unlist(aggregate(file$value[which(file$clampQuartile == "Q4")] ~ file$variable[which(file$clampQuartile == "Q4")],
                          FUN = sd)[2])[c(1,3,2)])
  m <- matrix(c(v, v2 / sqrt(117), w, w2 / sqrt(117)), ncol = 1, nrow = 12)
  colnames(m) <- n
  return(data.frame(m))
}

## masterdata3 <- cbind(m_fun3(c10), m_fun3(c12), m_fun3(ol), m_fun3(pal), m_fun3(hex), m_fun3(doca), m_fun3(l181),
##                      m_fun3(l182), m_fun3(l204), m_fun3(c2), m_fun3(c8), m_fun3(c14), m_fun3(c16), m_fun3 (c18), m_fun3(lc))

##### Instead for GITHUB test, upload summary results already calculated

masterdata2 <- read.table("masterdata2")
masterdata3 <- read.table("masterdata3")

##### Shiny Serve function 
pl <- function(input, output){
  
  formulaText1 <- reactive({
    masterdata2[1:3, as.character(input$variable)] ~ c(0,30,120)
    })
  formulaText2 <- reactive({
    masterdata3[1:3, as.character(input$variable)] ~ c(0,30,120)
    })
  formulaText3 <- reactive({
        masterdata3[7:9, as.character(input$variable)] ~ c(0,30,120)
    })
  
  output$mpgPlot <- renderPlot({
    if(input$colour == F){
      col1 = "black"
      col2 = "black"
      col3 = "black"
    } else {
      col1 = sample(colours(),1)
      col2 = "firebrick" 
      col3 ="dodgerblue4"
    }

    if(input$SD_show == F){
      lo <- -2.5
      hi <- 2.5
    } else { 
      if(input$quartile == F){
      lo <- min(masterdata2[1:3, as.character(input$variable)]) - 0.2
      hi <- max(masterdata2[1:3, as.character(input$variable)]) + 0.2
      } else {
        lo <- min(masterdata3[c(1:3,7:9), as.character(input$variable)]) - 0.3
        hi <- max(masterdata3[c(1:3,7:9), as.character(input$variable)]) + 0.3
      }
    }
    
    if(input$quartile == F){
    plot(as.formula(formulaText1()),
         data = masterdata2,
         ylim = c(lo, hi), pch = 19, col = col1,
         ylab = "Signal intensity, SD-unit, 95% CI",
         xlab = "Sampling during OGTT, min",
         cex = 2, cex.lab = 1.4)
    lines(as.formula(formulaText1()),
          col = col1, lwd = 3)
    segments(c(0,30,120), y0 = (masterdata2[1:3, as.character(input$variable)] - 
                                  (1.96 * masterdata2[4:6, as.character(input$variable)])),
             y1 = masterdata2[1:3,as.character(input$variable)] + (1.96 * masterdata2[4:6,as.character(input$variable) ]),
             lwd = 3, col = col1)
    } else {
      plot(as.formula(formulaText2()),
           data = masterdata3,
           ylim = c(lo, hi), pch = 19, col = col2,
           ylab = "Signal intensity, SD-unit, 95% CI",
           xlab = "Sampling during OGTT, min",
           cex = 2, cex.lab = 1.4)
      lines(as.formula(formulaText2()),
            col = col2, lwd = 3)
      segments(c(0,30,120), y0 = (masterdata3[1:3, as.character(input$variable)] - 
                                    (1.96 * masterdata3[4:6, as.character(input$variable)])),
               y1 = masterdata3[1:3,as.character(input$variable)] + (1.96 * masterdata3[4:6,as.character(input$variable) ]),
               lwd = 3,col = col2)
      points(as.formula(formulaText3()),
             data = masterdata3,
             pch = 19, col = col3, cex = 2)
      lines(as.formula(formulaText3()),
            col = col3, lwd = 3)
      segments(c(0,30,120), y0 = (masterdata3[7:9, as.character(input$variable)] - 
                                    (1.96 * masterdata3[10:12, as.character(input$variable)])),
               y1 = masterdata3[7:9,as.character(input$variable)] + (1.96 * masterdata3[10:12,as.character(input$variable) ]),
               lwd = 3,col = col3)
    }
    })
}

