library(HotDeckImputation)

# Leitura do arquivo CSV.
myFile <- read.csv(file = "dataset.csv",
                   header=FALSE,
                   sep=",",
                   col.names = c("BI_RADS","Idade","Forma","Borda","Densidade","Severidade"))

# Transformação do arquivo CSV em matriz.
myData <- as.matrix(myFile)

# Limpeza dos dados utilizando o método Hot-Deck.
# Os atributos serão imputados de acordo com o objeto mais parecido
#obtido pela distância euclidiana.
cleanData <- impute.NN_HD(DATA = myData,
                          distance = "eukl",
                          weights = c(0, 1, 1, 1, 1, 0),
                          attributes = "sim",
                          comp = "rw_dist",
                          donor_limit = Inf,
                          optimal_donor = "no",
                          list_donors_recipients = NULL,
                          diagnose = NULL)

# Geração do arquivo CSV contendo o dataset limpo.
write.table(cleanData,
            file = "cleanData.csv",
            row.names = FALSE,
            col.names = FALSE,
            sep = ",")
