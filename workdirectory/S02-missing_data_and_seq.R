# Question 1
v1 <- c(70,86,100,5,90,9,31,67,41,32)
mean(v1)
median(v1)

# Question 2
let1 <- c("d","f","j","s")
let2 <- c("y","i","p","m","u","g","c","h")

let_tot <- c(let2, let1)
let_tot[10]

# Question 3

verbs <- c("hate", "am crazy about", "love", "???", "have doubts about")

ans <- c(LETTERS[9], verbs[3], LETTERS[18])
ans
# Au lieu de compter sur les doigts:
which(LETTERS == "I" | LETTERS == "R")
# >9 18 -> I est en 9 et R en 18



# Question 4

res <- c(11L, 0L, 11L, 12L, 17L, 0L, 8L, 1L, 2L, 0L, 17L, 4L, 9L, 10L, 
  18L, 15L, 14L, 6L, 15L, 17L, 18L, 3L, 18L, 2L, 1L, 12L, 3L, 19L, 
  5L, 2L, 20L, 20L, 7L, 4L, 4L, 18L, 11L, 6L, 13L, 16L, 1L, 16L, 
  10L, 13L, 7L, 0L, 1L, 9L, 1L, 5L, 12L, 11L, 2L, 7L, 0L)

nom <- c("Crystal", "Isaac", "Shannon", "Miles", "Stacie", "Dhaahir", 
  "Megan", "Alicia", "Alexander", "Christina", "Haley", "Mariano", 
  "Abdul Baasid", "Connor", "Kyle", "Amos", "Ariyya", "Saabiqa", 
  "Saleem", "Baahir", "Raul", "Madison", "Jonathan", "Derek", "Reba", 
  "Whitney", "Sireen", "Imraan", "Francisco", "Nicholas", "Bethany", 
  "Haarith", "Tiffani", "Paden", "Samuel", "Abby", "Ghaada", "Breanne", 
  "Musheer", "Krystal", "Ariel", "Shabeeba", "Sarah", "Misfar", 
  "Crystal", "Julie", "Micheal", "Tayler", "Andreana", "Taryn", 
  "Makayla", "Joshua", "Sean", "Zubair", "Hannah")

nom[res>16]

names(res) <- nom
res
names(res[res > 16])
res[c(1, 3, 5)]
res[c("Haarith", "Shabeeba")]

## missing data
NA

x <- c(15, 16, 11, NA, 12)
length(x) #NA compte dans la longueure
mean(x) #>NA donc les operations math. qd valeur manquante seront NA
# on peut retirer les valeurs manquantes
is.na(x) #est ce que ma valeur est manquante, donne en boolean

!is.na(x) #est ce que ma valeur est PAS manquante
x[!is.na(x)]
# prends toutes les valeurs pas manquante


###OPTION 1
mean(x[!is.na(x)])
# moyenne de x en ayant retirer les valeurs manquante

###OPTION 2
na.omit(x) #omits les valeurs NA
mean(na.omit(x))

###OPTION 3
mean(x, na.rm = TRUE)


anyNA(x) # Y a-t-il un NA

table(is.na(x))#compte et te dis combien de true et de false il y a
sum(is.na(c(NA, 2, NA, 3, 4))) #ajoute le nombre de na et te donne le nombre total


# exercice

heights <- c(12, 16, 18, 12, 19, NA, 17, 81, 19, NA, 21, 32)
length(heights)
table(is.na(heights))

# mean de heights stocké dans mn
mn <- mean(heights, na.rm = TRUE)
mn <- mean(heights[c(!is.na(heights))])
mn
# creer un nouveau vecteur H2 qui contient les valesr de heights > mn

h2_withNA <- c(heights[heights>mn])
h2_withNA
h2 <- c(heights[heights>mn & !is.na(heights)])
h2



##### generer des valeurs

numeric(10) #valeur par defaut est 0
character(5) #defaut est rien ""
logical(3) #defaut est FALSE

rep(12, 3) #repete 12 trois (3) fois
rep(c(1,2,3), 3) #repete 1, 2, 3 trois (3) fois

# pour faire 1 1 1 2 2 2 3 3 3
c(rep(1, 3), rep(2,3), rep(3, 3))
# OU ALORS
rep(c(1,2,3), each = 3)

seq(1, 5, 1)
seq(from = 1, to = 5, by = 1) # 1 2 3 4 5
seq(from = 1, to = 5, by = 2) # 1 3 5
seq(from = 1, to = 6, length.out = 3) #length.out veut dire longeure final de 3

# racourcis
1:5 # equivaut a seq(1, 5, 1)
1:1000
100:1000

seq(from = 10, to = 1, by= -3) #seq qui descend

sample(80, 1) # de 1 a 80, choisis un nombre
sample(5, 10) #a problem ya pas assez
# Error in sample.int(x, size, replace, prob) : 
# cannot take a sample larger than the population when 'replace = FALSE'
sample(6, 100, replace = TRUE)


rnorm(100, mean = 5, sd = 2) # prends de la norme (courbe de gauss), defaut mean = 0, sd = 1

