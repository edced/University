res <-  c(5, 10 ,11, 20)
name <- c("l", "j", "je", "m")
x <- c(1.1, 2.1, 3.1, 2.9)

dfr <-  data.frame(res, name, x)
dfr

# on va les charger d'un fichier

download.file(url = "https://raw.githubusercontent.com/UCLouvain-CBIO/WSBIM1207/master/data/rnaseq.csv",
              destfile = "data/rnaseq.csv")

rna <- read.csv("data/rnaseq.csv")
class(rna)
rna

dim(rna) #dimension de la dataframe, nombre d'observation (ligne) nombre de variables (colones)
nrow(rna)
ncol(rna)

names(rna) #nom des variables

head(rna) #montre les 6 premieres ligne
tail(rna) #montre les 6 dernieres ligne
View(rna) #ouvre le tableau

rna[, ] # tout avant la virgule = ligne, tout apres = colones
rna[c(1,2,3), c(1,3)] #ligne 1 2 et 3 et var en pos 1 er 3
dim(rna[c(1,2,3), c(1,3)])

# creer un nouveau df qui contient les ligne 1, 3, ... 15 et les colones gene expression et sample
df2 <- rna[seq(1, 15, 2),c("gene", "expression", "sample")]

rna[seq(1,15,2), ]#si on mets rien, ca veut dire tout ici tt les colones
dim(rna[seq(1,15,2), ])

rna[ ,c("gene", "expression", "sample")]

rna$expression #va chercher tout la colones expression
mean(rna$expression)

rna$sex
table(rna$sex)

str(df2)
summary(df2)

### rna2 avec les obs ayant des homologues chez l'humain (donc ou ya pas de NA ds la colones rna$hsapiens_...)
rna2 <- rna[!is.na(rna$"hsapiens_homolog_associated_gene_name"), ] #on veut toutes les variables, pas juste la colones hsapiens... -> rien apres la virgule
dim(rna2)
