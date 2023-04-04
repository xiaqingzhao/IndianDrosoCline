shinyUI(fluidPage(
  
  titlePanel("DrosoCline"), 
  
  sidebarLayout(sidebarPanel(
    
    selectInput("Cline", label = "Cline", 
                choices = list("Altitude", "Latitude"), 
                selected = "Altitude"), 
    
    selectInput("Species", label = "Species", 
                choices = list("Drosophila ananassae", "Drosophila bipectinata", "Drosophila buskii", "Drosophila immigrans", "Drosophila kikkawai", "Drosophila melanogaster", "Drosophila nasuta", "Drosophila nepalensis", "Drosophila repleta", "Drosophila takahashii"), 
                selected = "Drosophila melanogaster"), 
    
    selectInput("Phenotype", label = "Phenotype", 
                choices = list("Desiccation Tolerance (hours)", "Starvation Tolerance (hours)", "Copulation Period (minutes)", "Ovariole Number", "Fecundity (number of eggs laid)", "Chill-coma Recovery (minutes)", "Abdomen Pigmentation (%Melanization)", "Heat-knockdown (minutes)", "Trident Pigmentation (arbitrary unit)", "esterase-6 allele frequency", "alcohol dehydrogenase F allele frequency", "Body Weight (mg*100)", "Thorax Length (mm*100)", "Wing Length (mm*100)", "Sternopleural Bristles (number)", "Abdominal Bristles (number)", "Total Lipids (ug per fly)", "Trehalose (ug per fly)"), 
                selected = "Desiccation"), 
    
    selectInput("Sex", label = "Sex", 
                choices = list("Female", "Male"), 
                selected = "Female"), 
    
    downloadButton('downloadData', 'Download') 
    
  ), mainPanel(plotOutput("clineplot"))), verbatimTextOutput("summary")
  
))