library(dplyr)
library(ggplot2)
data <- read.table("data/DrosoCline.txt", sep="\t", header=T) 

shinyServer(function(input, output) {
  
  datasetInput <- reactive({
    
    filter(data, Cline==switch(input$Cline, "Altitude"="Altitude", "Latitude"="Latitude"), 
           Species==switch(input$Species, "Drosophila ananassae"="Drosophila ananassae", "Drosophila bipectinata"="Drosophila bipectinata", "Drosophila buskii"="Drosophila buskii", "Drosophila immigrans"="Drosophila immigrans", "Drosophila kikkawai"="Drosophila kikkawai", "Drosophila melanogaster"="Drosophila melanogaster", "Drosophila nasuta"="Drosophila nasuta", "Drosophila nepalensis"="Drosophila nepalensis", "Drosophila repleta"="Drosophila repleta", "Drosophila. takahashii"="Drosophila. takahashii"),
           Sex==switch(input$Sex, "Female"="Female", "Male"="Male"),
           Phenotype==switch(input$Phenotype, "Desiccation Tolerance (hours)"="Desiccation", "Starvation Tolerance (hours)"="Starvation", "Copulation Period (minutes)"="Copulation", "Ovariole Number"="OvarioleNum", "Fecundity (number of eggs laid)"="Fecundity", "Chill-coma Recovery (minutes)"="ChillComa", "Abdomen Pigmentation (%Melanization)"="Melanization", "Heat-knockdown (minutes)"="HeatKnockdown", "Trident Pigmentation (arbitrary unit)"="Trident", "esterase-6 allele frequency"="Est6", "alcohol dehydrogenase F allele frequency"="Adh", "Body Weight (mg*100)"="BodyWeight", "Thorax Length (mm*100)"="ThoraxLength", "Wing Length (mm*100)"="WingLength", "Sternopleural Bristles (number)"="SternoBristles", "Abdominal Bristles (number)"="AbdominalBristles", "Total Lipids (ug per fly)"="TotalLipids", "Trehalose (ug per fly)"="Trehalose")
    )
    
  })
  
  output$clineplot <- renderPlot({
    
    subset <- datasetInput()
    ggplot(subset, aes(x=switch(input$Cline, "Altitude"=subset$Altitude_meters_above_sea_level, "Latitude"=subset$Latitude_degree_North), y=Data))+geom_point()+stat_smooth(method=lm)+xlab(switch(input$Cline, "Altitude"="Altitude", "Latitude"="Latitude"))
    
    
  })
  
  output$summary <- renderPrint({
    
    subset <- datasetInput()
    x <- select(subset, switch(input$Cline, "Altitude"=Altitude_meters_above_sea_level, "Latitude"=Latitude_degree_North))[,1]
    y <- subset$Data 
    
    if(length(y)==0) {print("Data not available for the above combination")} else {
      
      print(summary(lm(y~x)))
      
    }
    
  })
  
  output$downloadData <- downloadHandler(
    filename = function() { paste(input$Cline, input$Species, input$Phenotype, input$Sex, ".csv", sep="_")},
    content = function(file) {
      write.csv(datasetInput(), file)
    }
  )
  
  
})