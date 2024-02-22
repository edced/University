5 + 11
2 + 12
5 + 5

#CTRL+ENTER : exec code sur la ligne du curseur
#CTRL+L : clear console
#alt+- : makes <-

x <- 5 + 5.75
x

y <- "hello"
y

ls()
#affiche le nom de toutes les variables crées, on peut aussi aller dans l'onglet environement

class(y)
#class(var) tells what type of variable it is (numeric, character, etc.)


# exercice

mass <- 47.5
age <- 122
mass <- mass * 2.0
age <- age - 20
mass_index <- mass/age

mass
age
mass_index
ls()


## FUNCTIONS

round(3.14, 1)
# round(number/var, digits)
?round #ouvre le page de doc de la fct

## Vector


w <- c(50, 65, 78, 63)
# 4 valeurs combiné dans un vecteur, ici w
w
class(w) #type de var ds vecteur
length(w) #longueur du vect


mol <- c("dna","rna","protein")
mol
class(mol)
length(mol)

str(w) #fonction qui nous donne structure
# class [taille_min:taille_max] x y z
str(mol)

test <- c("dna", 8, "arnm", 5.23, x)
test
str(test)
#transforme les valeurs numeriques en charactere, tous les vect doivent etre de la meme classe

as.numeric("1") #transforme le 1 qui est un charactere en numerique

#ex ajouter 99 a la fin de w

w2 <- append(w, 99)
w2
w3 <- append(99, w)
w3

##subsetting

length(w2)

w2[2] #va chercher le 2e element du vecteur
# !! vs python ou element 0 est le premier de la liste, ici 1 est le premier

##extraire les 2e et 3e elements
w2[c(2,3)]
w2[2:3]

w2[c(1,1,2)]

#ex
fruits <- c("apple", "orange", "grape")
# fruits <- c(fruits, "melon", "pineapple")
# fruits
# ?sort
# sort(fruits)

# To be faster:
sort(c(fruits, "pineapple", "melon"))

x <- sort(c(fruits, "pineapple", "melon"))[c(1,3)]

append(fruits, "banane")

##logicals
TRUE #vrai
FALSE #faux
1 > 2
1 > -1
1 == 1
!TRUE
c( TRUE, FALSE, TRUE)

w2
-c(3, 5)
w2[c(1, 2, 4)]
w2[-c(3, 5)]
# le - rends 3 et 5 negatif, ce qui veut dire qu'on ne prends PAS les valeurs 3 et 5

# on veut ts les elements de w2 plus petit que 70
w2[c(TRUE, TRUE, FALSE, TRUE, FALSE)]
w2[c(T,T,F,T,F)]
w2 < 70 #te retourne le TRUE, TRUE, ...
w2[w2 < 70]

# si le nombre de true/false n'est pas bon r repete (si true, false, il va prendre le premier nombre car true, PAS le deuxieme car false, puis pour le troisieme il va retourner a true le 4e false, etc.)


w2[w2<64 | w2>70 ]
# "|" signifie ou 
# "&" signifie et
w2[w2<64 & w2>70]


mol == "dna" | mol == "rna"

mol[mol %in% c("dna", "rna")]
# voire in comme un diagrame de venn 