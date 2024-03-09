rna <- read.csv("data/rnaseq.csv")
rna
View(rna)
str(rna)
dim(rna)
colnames(rna)
names(rna)
rownames(rna)
summary(rna)

str(rna)

sum(is.na(rna$hsapiens_homolog_associated_gene_name))
table(is.na(rna$hsapiens_homolog_associated_gene_name))

rna_200 <- rna[200, ]
nrow(rna)
rna_last <- rna[nrow(rna),]
tail(rna, 1)
rna_last

rna_middle <- rna[nrow(rna)/2,]
rna_head <- rna[1:6,]
# il demande avec le - donc
rna_head <- rna[-(7:nrow(rna)),] #la parenthese pour partager le -
rna_head <- rna[-7:-nrow(rna), ]

rna_head

write.csv(rna, file = "data_output/my_rnaseq.csv")

#### factors

genes <- factor(rna$gene)
levels(genes)
nlevels(genes)


sex <- factor(c("male", "female", "female", "male", "female"))
sex
sex <- factor(sex, levels = c("male", "female"))
sex
as.character(sex)
as.numeric(sex)
plot(sex)
levels(sex) <- c("M", "F")

levels(sex) <- c("Male", "Female")


animal_data <- data.frame(
  animal = c("dog", "cat", "sea cucumber", "sea urchin"),
  feel = c("furry", "furry", "squishy", "spiny"),
  weight = c(45, 8, 1.1, 0.8))

country_climate <- data.frame(
  country = c("Canada", "Panama", "South Africa", "Australia"),
  climate = c("cold", "hot", "temperate", "hot/temperate"),
  temperature = c(10, 30, 18, "15"),
  northern_hemisphere = c(TRUE, TRUE, FALSE, "FALSE"),
  has_kangaroo = c(FALSE, FALSE, FALSE, 1),
  stringsAsFactors = TRUE
)
str(country_climate)


### matrices 
m <- matrix(1:9, ncol = 3, nrow = 3)
m <- matrix(1:9, ncol = 3, nrow = 3, byrow= TRUE)
m

ip <- installed.packages()
ip

head(installed_package_m)
View(ip)

m_ex <- matrix(rnorm(3000), nrow = 1000, ncol = 3)
m_ex

#date
library("lubridate")
my_date <- ymd("2015-01-01")
str(my_date)
my_date <- ymd(paste("2015", "1", "1", sep = "-"))
str(my_date)

x <- data.frame(year = c(1996, 1992, 1987, 1986, 2000, 1990, 2002, 1994, 1997, 1985),
                month = c(2,  3,  3, 10,  1,  8,  3,  4,  5,  5),
                day = c(24,  8,  1,  5,  8, 17, 13, 10, 11, 24),
                value = c(4,  5,  1,  9,  3,  8, 10,  2,  6,  7))
x
paste(x$year, x$month, x$day, sep = "-")

ymd(paste(x$year, x$month, x$day, sep = "-"))
x$date <- ymd(paste(x$year, x$month, x$day, sep = "-"))
str(x)
summary(x$date)


#### Lists
l <- list(1:10, ## numeric
          letters, ## character
          installed.packages(), ## a matrix
          cars, ## a data.frame
          list(1, 2, 3)) ## a list
length(l)
l
str(l)
View(l)
l[[1]] 
l[1:2]
# l <- list(1:10,"numbers", ## numeric
#           letters, "alphabet", ## character
#           installed.packages(), "installed_packages", ## a matrix
#           cars, "cars", ## a data.frame
#           list(1, 2, 3), "random") ## a list
# l
# ITS WRONG TO ADD NAMES JUST USE
names(l) <- c("numbers", "alphabet", "installed_packages",
              "cars", "random")
names(l)
l
l_nomatrix <- l[-3]
l_nomatrix
l_onlycars <- l[4] #ou l["cars"]
l_onlycars                
# onlycars <- as.data.frame(l_onlycars)
# WRONG its not what is asked, just take the sublist
l[["cars"]]

# EXO SUPPLEMENTAIRE
# 1
molds <- c(1,2,5,8,10)
day <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday") 
molds_study <- data.frame(
  Day = day,
  Molds_count = molds)
str(molds_study)

molds_study_filter <- molds_study[molds_study$Molds_count>2, ] 
nrow(molds_study_filter)
sum(molds_study_filter$Molds_count)

names(molds_study)
molds_study$Molds_2 <- c(1,6,6,5,4)
names(molds_study)[2] <- "Molds_1"
str(molds_study)

molds_w1 <- sum(molds_study$Molds_1)
molds_w2 <- sum(molds_study$Molds_2)
molds_w1>molds_w2
?saveRDS()
save(molds_study, file = "data_output/ch4_ex_sup_1_molds_study.rda")

library("rWSBIM1207")
beers.csv()
beers <- read.csv2("C:/Users/cedri/AppData/Local/R/win-library/4.3/rWSBIM1207/extdata/beers.csv")
beers
read.delim("C:/Users/cedri/AppData/Local/R/win-library/4.3/rWSBIM1207/extdata/beers.csv", sep = ";")
summary(beers)
str(beers)
View(beers)
summary(beers$Record_ID)
summary(beers$Work)
summary(beers$Consumption)
summary(beers$Gender)
summary(beers$Age)
summary(beers$Day)
summary(beers$Month)
summary(beers$Year)

mean(beers$Age)
median(beers$Age)

men_drink <- beers[beers$Gender == "Male",]
mean_men_beer <- mean(men_drink$Consumption)
woman_drink <- beers[beers$Gender == "Female", ]
mean_woman_beer <- mean(woman_drink$Consumption[!is.na(woman_drink$Consumption)])
mean_woman_beer <- mean(woman_drink$Consumption, na.rm = T) # 2 option sont bonne
mean_men_beer>mean_woman_beer

table(beers$Gender, beers$Work)

beers_no_na <- beers[!is.na(beers)]
anyNA(beers_no_na)
beers_no_na
write.csv(beers_no_na, file = "data_output/CH4_ex2_beers_no_na")
