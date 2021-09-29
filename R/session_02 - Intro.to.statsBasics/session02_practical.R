# Installing packages -----------------------------------------------------
#install.packages("ACTCD")
# install.packages("tidyverse")
# install.packages("janitor")

# Loading packages --------------------------------------------------------
library(tidyverse)
library(janitor)
library(lubridate)
library(skimr)
library(Hmisc)
library(scales)
library(table1)
library(ggthemes)




# Loading datasets --------------------------------------------------------
# - birth_weight.csv
# - babies.csv
# - birth_weight-fup.csv

birth_weight <- read.csv("datasets/birth_weight.csv")
babies <- read.csv("datasets/babies.csv")
mod_birth <- read.csv("datasets/birth_weight-fup.csv")


# Transforming data from long to wide and back ----------------------------
# use modified birth weight follow up
# pivot_longer() ?pivot_longer
# pivot_wider() ?pivot_wider

month1 <- mod_birth %>%
  filter(visit == "Visit1") %>%
  rename_at(vars(-id), ~paste0(., "_m1"))

df <- month1 %>%
  mutate_all(as.character) %>%
  pivot_longer(cols = -id, names_to = "variable",
               values_to = "var_values")


# Variable transformations ------------------------------------------------
# creating factors
# Handling dates using lubridate()

glimpse(birth_weight)

# as.*; as.factor(), as.numeric(), as.integer()

birth_weight$sex <- as.factor(birth_weight$sex)

birth_weight$Gender <- factor(birth_weight$sex,
                              levels = c("Male", "Female"),
                              labels = c("M", "F"))
# dates
birth_weight <- birth_weight %>%
  mutate(
    date_birth = dmy(dob),
    adm_date = dmy(date_admn)
  )


# Functions to have a view of your data -----------------------------------

# summary(); table()[one-way and 2-way];  head(); tail(); nrow(); ncol()
# str(); glimpse()
# skim() and Hmisc::describe()

summary(birth_weight)
head(birth_weight, 2)
nrow(birth_weight); ncol(birth_weight)

glimpse(birth_weight)
str(birth_weight)

class(birth_weight$bweight)

skim(birth_weight)
describe(birth_weight)

# looking at few variables
birth_weight %>%
  skim(sex, Gender, matage)

# table
table(birth_weight$Gender)
table(birth_weight$id)
table(birth_weight$date_admn, useNA = "always")

# 2- way
table(birth_weight$Gender, birth_weight$agegrp)

table(Gender, agegrp)

# attach()
attach(birth_weight); detach(birth_weight)
attach(mod_birth); detach(mod_birth)

# with()

with(
  birth_weight,
  table(Gender, agegrp)
)

# %
table(birth_weight$Gender)/nrow(birth_weight) * 100


# Descriptive statistics (1/2) - numericals -------------------------------------
# mean(), median() and quantile()
# min(), max() and range()
# sd(), var() and uncertainty

mean(birth_weight$matage, na.rm = TRUE)
median(birth_weight$ht)

quantile(birth_weight$bweight,
         probs = c(0.25, 0.50, 0.75, 0.85))

IQR(birth_weight$bweight)

#
min(birth_weight$matage)
max(birth_weight$matage)

range(birth_weight$matage)

sd(birth_weight$gestwks)
var(birth_weight$bweight)




# Descriptive statistics (2/2) - expanded, by group -----------------------
# use of dplyr verbs to manually code
# Group summary
# Create simple contigency tables (wide and long data formats)

birth_weight %>%
  group_by(sex) %>%
  summarise(
    Total = n()
  ) %>%
  mutate(
    prop = percent(Total/nrow(birth_weight))
  )

# 2- way table
birth_weight %>%
  group_by(sex, agegrp) %>%
  summarise(
    Total = n(),
    prop = percent(Total/nrow(birth_weight))
  ) %>% select(-Total) %>%
  pivot_wider(names_from = agegrp, values_from = prop)

# mean, median ... multiple
birth_weight %>%
  group_by(agegrp) %>%
  summarise(across(c(gestwks, bweight, matage), mean))

birth_weight %>%
  group_by(agegrp) %>%
  summarise(across(c(gestwks, bweight, matage),
                   list(mean = mean,
                        sd = sd,
                        median = median), .names = "{.col}.{.fn}"))

#
birth_weight %>%
  group_by(agegrp) %>%
  summarise(
    total = length(which(ethnic == 1 | ethnic == 3))
  )

# Robust contingency tables using table1() package ------------------------
# step 1. label() your variables - give them meaningful names
# step 2. Decide on your grouping variable (top row)
# step 3 . Apply the function -- checkout ?table1::table1 with[topclass = "Rtable1-zebra"]

# --- For complex contingency tables, check out the qwraps2()


# label data
label(birth_weight$matage) <- "Maternal Age"
label(birth_weight$gestwks) <- "Gestation period (weeks)"
label(birth_weight$sex) <- "Gender"
label(birth_weight$agegrp) <- "Age Group"
label(birth_weight$bweight) <- "Birth Weight"

# Create a simple table (r x 1)
table1(~ matage + gestwks + sex + agegrp + bweight,
       data = birth_weight,
       overall = "Total",
       topclass = "Rtable1-zebra")

# Create a contingency table (rxc)
table1(~ matage + gestwks + sex + agegrp + bweight + ht |ethnic,
       data = birth_weight,
       overall = "Total",
       topclass = "Rtable1-zebra")

# qwraps2 (95%, 97%)


# Exploring data via visualizations ---------------------------------------
# main package -- ggplot()

# ++ Histogram -----
# numeric --- ggplot(data = , aes(x =, y =)) + geom_*

ggplot(data = birth_weight, aes(x=matage)) +
  geom_histogram(binwidth = 1,
                 fill = "steelblue",
                 col = "white") + labs(title = "Histogram")

ggplot(data = birth_weight, aes(x=gestwks)) +
  geom_histogram(binwidth = 1,
                 fill = "steelblue",
                 col = "white") + labs(title = "Histogram")

# ++ Density plot -----
ggplot(data = birth_weight, aes(x=matage)) + stat_density(geom = "line")+
   labs(title = "Histogram")

ggplot(data = birth_weight, aes(x=ht)) + stat_density(geom = "line")+
  labs(title = "Histogram")


# ++ Scatter plot -----
ggplot(data = birth_weight, aes(x = matage, y = gestwks)) +
  geom_point()

ggplot(data = birth_weight, aes(x = matage, y = gestwks)) +
  geom_point() + facet_wrap(~ethnic)


# ++ Box plot -----
ggplot(data = birth_weight, aes(x=1, y = matage)) + geom_boxplot()

ggplot(data = birth_weight, aes(x= sex,
                                y = matage,
                                fill = sex)) + geom_boxplot()

# ++ Bar plot -----
# Barplot requires categorical variables

ggplot(data = birth_weight, aes(x = agegrp)) +
  geom_bar(width = 0.7, fill = "palegreen4") + theme_hc()

# bar-plot of the mean age of enthnic group
birth_weight %>%
  group_by(ethnic) %>%
  summarise(
    mean_age = mean(matage)
  ) %>%
  ggplot(aes(x=ethnic, y = mean_age)) +
  geom_bar(stat = "identity", width = 0.7, fill = "palegreen4") + # note the additional argument stat = "identity". what does it mean?
  theme_hc()


# faceted bar plots
ggplot(data = birth_weight, aes(x = agegrp)) +
  geom_bar(width = 0.7, fill = "palegreen4") + theme_hc()+ facet_wrap(~sex)



# ++ Faceting plots -----
ggplot(data = birth_weight, aes(x= agegrp,
                                y = matage,
                                fill = sex)) + geom_boxplot() +
  facet_wrap(~sex)


# ++ Histogram and density plot
ggplot(data = birth_weight, aes(x=matage)) +
  geom_histogram(binwidth = 1,
                 fill = "steelblue",
                 col = "white",
                 aes(y = ..density..)) + # this is the difference (1/2)
  geom_density() + # this is the difference (2/2)
  labs(title = "Histogram and density plot")



# Useful links to materials required --------------------------------------
# Further reading

## https://cran.r-project.org/web/packages/qwraps2/index.html ----- link to qwraps2 package
## https://benjaminrich.github.io/table1/vignettes/table1-examples.html -----  Link table1() package
## https://ggplot2-book.org/index.html ----- All you need to know about ggplot2()




























