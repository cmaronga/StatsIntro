# How R operates
# expressions vs assignments

4+10
20*100
1000/34
45 - 10
60*45
4+11


# Assignments

result1<-45 - 10
result_2 <- 60*45
45 - 10
myresult3 <- result_2/result1
obj1 = 86 *100
assign("obj2", 86*100)
45 - 10
result1 <- 45 - 10
result_2 <- 60*45
myresult3 <- result_2/result1

# Introduction to data structures - Vectors

# Character
c("Monday", "Tuesday", "Wed", "Thur", "Fri", "Sat")

char_vect <- c("Monday", "Tuesday", "Wed", "Thur", "Fri", "Sat")

double_vect <- c(12, 14.3, 38, 37.5, 67)

int_vect <- c(5L, 6L, 7L, 8L)

double_vect2 <- c(5, 6, 7, 8)

c(5L, 6L, 7L, 8L, 9)

vect_3 <- c(5L, 6L, 7L, 8L, 9)

ls()

rm(obj2)

ls()

rm(obj1, char_vect, vect_3)

ls()

rm(list = ls())

# This is a comment (Not execute)
# Expression

45 - 10
60*45
4+11

# Assignment
# use the symbols <-, = and assign("name_of_obj", value)
# <-

result1 <- 45 - 10
result_2 <- 60*45

# I can re-use the objects
myresult3 <- result_2/result1

# using =

obj1 = 86 *100

# assign()
assign("obj2", 86*100)
# Introduction to Data structures - Vectors
# we create vectors c() - combine

# Character
char_vect <- c("Monday", "Tuesday", "Wed", "Thur", "Fri", "Sat")

# Double
# numeric vector that contains fractions
double_vect <- c(12, 14.3, 38, 37.5, 67)
double_vect2 <- c(5, 6, 7, 8)

# Integer
# whole numbers withoud decimals
int_vect <- c(5L, 6L, 7L, 8L)
vect_3 <- c(5L, 6L, 7L, 8L, 9)

# Logical
# TRUE or FALSE
logical_vec <- c(TRUE, TRUE, FALSE, FALSE)

# useful functions (exploring the workspace)
# ls() and rm()

my_list <- list(
  char_vect,
  double_vect,
  int_vect,
  logical_vec,
  result1,
  result_2
)
str(my_list)

length(char_vect)

length(my_list)

typeof(char_vect)

class(char_vect)

# Dataframes in R
study_data <- data.frame(
  age = c(23, 34, 67, 89),
  gender = c("M", "M", "F", "M"),
  county = c("Nairobi", "Eld", "Kis", "Kilifi")
)

print(study_data)

study_data <- data.frame(
  age = c(23, 34, 67, 89),
  gender = c("M", "M", "F", "M"),
  county = c("Nairobi", "Eld", "Kis", "Kilifi"),
  Weight = c(23, 56, 45, 60)
)
print(study_data)

View(study_data)

View(study_data)

my_list <- list(
  char_vect,
  double_vect,
  int_vect,
  logical_vec,
  result1,
  result_2,
  study_data
)

length(study_data)

study_data <- data.frame(
  age = c(23, 34, 67, 89),
  gender = c("M", "M", "F", "M"),
  county = c("Nairobi", "Eld", "Kis", "Kilifi")
)

length(study_data)
nrow(study_data)
View(study_data)
ncol(study_data)
str(study_data)
View(study_data)

nrow(study_data) # number of records/observations
View(study_data)
dim(study_data)
str(study_data)

study_data <- data.frame(
  age = c(23, 34, 67, 89, 45),
  gender = c("M", "M", "F", "M", "F"),
  county = c("Nairobi", "Eld", "Kis", "Kilifi", "Mombasa")
)
print(study_data)

study_data <- data.frame(
  age = c(23, 34, 67, 89, 45),
  gender = c("M", "M", "F", "M", "F"),
  county = c("Nairobi", "Eld", "Kis", "Kilifi", "Mombasa")
)

str(study_data)
nrow(study_data) # number of records/observations
ncol(study_data)
dim(study_data)
char_vect <- c("Monday", "Tuesday", "Wed", "Thur", "Fri", "Sat")
char_vect
print(char_vect)

# vector
char_vect
char_vect[2]
char_vect[-2]
char_vect[c(1,6)]
char_vect[-c(1,6)]

# List
my_list
my_list[7]
study_data[1,1]
View(study_data)
study_data[1, ]
study_data[, 1]
View(study_data)
study_data[, 3]
study_data$age
study_data[, 1]
study_data$county
study_data[, 3]
mean(age)
mean(study_data$age)

# File paths, working directory and reading data into R
getwd()
setwd("C:\Users\cmaronga\Desktop\T-Training")
setwd("C:\\Users\\cmaronga\\Desktop\\T-Training")
getwd()
setwd("C:/Users/cmaronga/Desktop/T-Training")
getwd()
getwd()
read.csv("babies.csv")
babies_data <- read.csv("babies.csv")
length(babies_data)
ncol(babies_data)
nrow(babies_data)
str(babies_data)
setwd("C:/WORK in PROGRESS/01 GitHuB Projects/StatsIntroSTATA&R")
getwd()
babies_data2 <- read.csv("babies.csv")
babies_data2 <- read.csv("C:/Users/cmaronga/Desktop/T-Training")
babies_data2 <- read.csv("C:/Users/cmaronga/Desktop/T-Training/babies.csv")


# option 3
setwd("C:/Users/cmaronga/Desktop/T-Training")

dir()
list.files()

babies_data3 <- read.csv("datasets/babies.csv")

# functions with dataframes
summary(babies_data)

summary(babies_data$matage)

# table

babies <- read.csv("datasets/birth_weight.csv")

str(babies)

table(babies$agegrp)
table(babies$sex)





