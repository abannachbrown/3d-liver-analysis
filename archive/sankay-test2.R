# sankey diagram

my.data = data.frame(Printer = c("A","A", "A", "B", "B"),
                     BioInk = c("Natural", "Natural", "Synthetic", "Natural", "Synthetic"),
                     Origin = c("Custom", "Custom", "Custom", "Custom", "Commercial"),
                     freq = 5:1)


usethis::create_github_token()

require(devtools)
install_github("Displayr/flipPlots", dependencies = NA)


library(flipPlots)
SankeyDiagram(my.data[, -4], # without frequency info
              link.color = "Source", 
              weights = my.data$freq) 