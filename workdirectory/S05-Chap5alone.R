library("tidyverse")
rna <- read_csv("data/rnaseq.csv")
str(rna)
View(rna)
select(rna, gene, sample, tissue, expression)
# The first argument to this function is the data frame (rna)
select(rna, -organism, -strain)
# selects all in RNA except orga and strain cause of -

filter(rna, sex == "Male")
#filters rows based on criterias, here its a male

filter(rna, sex == "Male" & infection == "NonInfected")


# PIPES %>% or |> (ctrl+shift+m)
rna %>% 
  filter(sex == "Male") %>% #keeps only rows where sex is male
  select(gene, sample, tissue, expression) # selects the column gene, sample...
# OR
rna |>
  filter(sex == "Male") |>
  select(gene, sample, tissue, expression)

rna_ex <- rna %>% 
  filter(expression > 50000 & time == 0 & sex == "Male") %>% 
  select(gene, sample, time, expression, age)
rna_ex

# MUTATE, create new columns based on other ones
rna %>% 
  mutate(time_hours = time*24) %>% 
  select(time_hours, time)

# Create a new column in the same mutate
rna %>% 
  mutate(time_hours = time*24, time_mn = time_hours*60) %>% 
  select(time, time_hours, time_mn) %>% 
  head()


rna %>% 
  select(gene, hsapiens_homolog_associated_gene_name) %>% 
  filter(!is.na(hsapiens_homolog_associated_gene_name))

# autosome veut dire tout chr sauf x et y
rna_ex2 <- rna %>% 
  mutate(log_expression = log(expression)) %>% 
  filter(!is.na(phenotype_description) & chromosome_name != "X" & chromosome_name != "Y")  %>% 
  select(gene, chromosome_name, phenotype_description, sample, expression, log_expression)

rna_ex2

# pulling a vae

mini_rna <- head(rna)
mini_rna %>% select(gene) #returns a one column tibble
# VS
mini_rna %>% pull(gene) #returns a vector, so can't be used for a fct expection a tibble

# split-apply-combine data analysis
rna %>% 
  group_by(gene)
# groups genes together so here we have 32428 grouped in 1474 groups
grouped_rna <- rna %>% 
  group_by(gene)
grouped_rna
# contraire:
ungroup(rna)

# summarize()
rna %>%
  group_by(gene) %>%
  summarize(mean_expression = mean(expression))

rna %>% 
  group_by(gene, infection, time) %>% 
  summarize(mean_expression = mean(expression),
            count = n(),
            median_expresssion = median(expression)) %>% 
  print(n = 15)

# parfois utile de ranger le tout:
rna %>%
  group_by(gene, infection, time) %>%
  summarize(mean_expression = mean(expression),
            median_expression = median(expression)) %>%
  arrange(mean_expression) # range dans l'ordre croissant de la moyenne d'expression

# pour l'ordre décroissant:
rna %>%
  group_by(gene, infection, time) %>%
  summarize(mean_expression = mean(expression),
            median_expression = median(expression)) %>%
  arrange(desc(mean_expression))



# Count()
rna %>% 
  count(infection)
# Equivaut a:
rna %>%
  group_by(infection) %>%
  summarise(count = n())
# count donne des argument comme trier:
rna %>% 
  count(infection, sort = T)
# Peut etre utilisé pour compter un combinaison de facteur:
rna %>% 
  count(infection, time) %>% 
  # arrange(time)#range dans lordre croissant de temps
  arrange(n) #range dans l'ordre croissant de compte


# exo
rna %>% 
  count(sample)

rna %>% 
  group_by(sample) %>% 
  summarise(seq_depth=sum(expression)) %>% 
  arrange(desc(seq_depth))
rna %>% 
  filter(gene == "Dok3") %>% 
  group_by(time) %>% 
  summarise(mean(expression)) %>% 
  arrange(time)
rna %>% 
  filter(sample == "GSM2545336") %>% 
  group_by(gene_biotype) %>% 
  count(gene_biotype) %>% 
  arrange(desc(n))
rna %>% 
  group_by(gene, time) %>% 
  filter(phenotype_description == "abnormal DNA methylation") %>% 
  summarise(log(mean(expression))) %>% 
  arrange()





# Reshaping
rna_exp <- rna %>% 
  select(gene, sample, expression)
rna_exp

rna_wide <- rna_exp %>%
  pivot_wider(names_from = sample,
              values_from = expression)
rna_wide

rna_exp %>% pivot_wider(names_from = sample, values_from = expression) 
#names from la collone sample deviennent les nouvelles collones 
# et les valeurs de la colones expression deviennent les nouvelles valeurs

# creer un set de donne avec des valeurs manquante
rna_with_missing_values <- rna %>%
  select(gene, sample, expression) %>%
  filter(gene %in% c("Asl", "Apod", "Cyp2d22")) %>%
  filter(sample %in% c("GSM2545336", "GSM2545337", "GSM2545338")) %>%
  arrange(sample) %>%
  filter(!(gene == "Cyp2d22" & sample != "GSM2545338"))
rna_with_missing_values

# creer un wide table avec les données
rna_with_missing_values %>% pivot_wider(names_from = sample, values_from = expression)
# le Cyp2d22 qui manque est mis en NA
# Not what we always want
rna_with_missing_values %>% pivot_wider(names_from = sample,
                                        values_from = expression,
                                        values_fill = 0) #change les NA par des 0

wide_with_NA <- rna_with_missing_values %>%
  pivot_wider(names_from = sample,
              values_from = expression)
wide_with_NA

wide_with_NA %>%
  pivot_longer(names_to = "sample",
               values_to = "expression",
               -gene) #on ne touche pas a gene donc elle reste comme colone 

rna_wide %>%
  pivot_longer(names_to = "sample",
               values_to = "expression",
               cols = starts_with("GSM"))
rna_wide %>%
  pivot_longer(names_to = "sample",
               values_to = "expression",
               cols = starts_with("GSM")) #colonne = tout qui commence avec GSM

rna_wide %>%
  pivot_longer(names_to = "sample",
               values_to = "expression",
               GSM2545336:GSM2545380) # colonne reprends de gsm25...36 a gsm25...80

#exo

rna1 <- rna %>% 
  filter(chromosome_name == "Y" | chromosome_name =="X") %>% 
  group_by(sex, chromosome_name) %>% 
  summarise(mean = mean(expression)) %>% 
  pivot_wider(names_from = sex, values_from = mean)
rna1

rna1 %>% pivot_longer(
  names_to = "gender",
  values_to = "mean",
  -chromosome_name)

rna %>% 
  group_by(gene, time) %>% 
  summarise(mean = mean(expression)) %>% 
  pivot_wider(
    names_from = time,
    values_from = mean
    
  )
#si on veut voire la colone 4, le problem cest que ya une colonne apellé 4 donc pour avoir la numero quatre:
rna %>%
  group_by(gene, time) %>%
  summarize(mean_exp = mean(expression)) %>%
  pivot_wider(names_from = time,
              values_from = mean_exp) %>%
  select(gene, 4)#nous donne colonne numero 4

rna %>%
  group_by(gene, time) %>%
  summarize(mean_exp = mean(expression)) %>%
  pivot_wider(names_from = time,
              values_from = mean_exp) %>%
  select(gene, `4`)#donne la colonne apellé 4
# ou renommer colonne par qque chose qui commence pas par un nombre

rna_time <- rna %>%
  group_by(gene, time) %>%
  summarize(mean_exp = mean(expression)) %>%
  pivot_wider(names_from = time,
              values_from = mean_exp) %>% 
  mutate(time_8_to_0 = `8`/`0`, time_8_to_4 = `8`/`4`)
rna_time
rna_time %>% pivot_longer(names_to = "comparison",
                          values_to = "Fold_changes",
                          time_8_to_0:time_8_to_4)
rna_fc <- rna %>%
  mutate(expression_log = log(expression)) %>%
  # group_by(gene, time) %>%
  summarize(mean_exp = mean(expression_log)) %>%
  pivot_wider(names_from = time,
              values_from = mean_exp) %>%
  mutate(time_8_vs_0 = `8` - `0`, time_4_vs_0 = `4` - `0`) %>%
  select(gene, time_8_vs_0, time_4_vs_0)
write_csv(rna_fc, file = "data_output/rna_fc.csv")



##### Exercice sup 
library(rWSBIM1207)
data(beers)
View(beers)
is.na(beers)
beers_no_na <- na.omit(beers)
beers_no_na
View(beers_no_na)

beers_no_na %>% 
  mutate(date = ymd(paste(Year, Month, Day))) %>% 
  pull(date) %>% #tire date comme vecteur
  class() #donne la classe de date -> DATE
# why does select(date) not work ????

new_beers <- beers_no_na %>% 
  filter(Gender == "Female" & Work == "Employed" & Age>35) %>% 
  select(Record_ID, Work, Consumption, Gender, Age) %>% 
  arrange(desc(Consumption))
View(new_beers)
write.csv(new_beers, file = "data_output/new_beers.csv")

beers_no_na %>% 
  group_by(Work) %>% 
  summarise(mean = mean(Consumption))

beers_no_na %>% 
  group_by(Gender) %>% 
  summarise(mean = mean(Consumption))

beers_no_na %>% 
  group_by(Work, Gender) %>% 
  summarise(mean = mean(Consumption))

beers_no_na %>% 
  group_by(Work, Gender, Age) %>% 
  summarise(mean = mean(Consumption))
