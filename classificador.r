library(rpart.plot)

# Importar CSV de dados limpos.
myFile <- read.csv(file = "cleanData.csv",
                   header=FALSE,
                   sep=",",
                   col.names = c("BI_RADS","Idade","Forma","Borda","Densidade","Severidade"))

# Construir árvore de classificação sem considerar o atributo Bi-Rads.
arvore_train <- rpart(Severidade ~ Idade + Forma + Borda + Densidade,
                      data = myFile,
                      method = "class")

# Construir árvore de classificação considerando o atributo Bi-Rads.
arvore_birads_train <- rpart(Severidade ~ BI_RADS + Idade + Forma + Borda + Densidade,
                      data = myFile,
                      method = "class")

# Plotar ambas as árvores.
prp(arvore_train, box.palette = "Reds", extra = 4)
prp(arvore_birads_train, box.palette = "Reds", extra = 4)

# Abrir arquivo CSV de testes.
myTestFile <- read.csv(file = "test.csv",
                   header=FALSE,
                   sep=",",
                   col.names = c("BI_RADS","Idade","Forma","Borda","Densidade","Severidade"))

# Aplicar arquivo de teste a ambas as árvores.
pred_noBirads <- predict(arvore_train, newdata = myTestFile, type = "class")
pred_birads   <- predict(arvore_birads_train, newdata = myTestFile, type = "class")


levels(pred_noBirads) <- c("Benigno", "Maligno")
levels(pred_birads) <- c("Benigno", "Maligno")

classes <- factor(myTestFile$Severidade)
levels(classes) <- c("Benigno", "Maligno")

# Matrizes de confusão.
confusionMatrix(pred_noBirads, classes)
confusionMatrix(pred_birads, classes)

