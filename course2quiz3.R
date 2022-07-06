rm(list=ls()) #delete all objects in working memory 

## Week 3 Quiz
## Using the iris-dataset
library(datasets)
data(iris)
?iris

## In the iris-dataset, what is the mean of 'Sepal.Length' for the species virginica? 

# Installing data.table with "install.packages("data.table")" and load it
install.packages("data.table")
library(data.table)

# renaming the dataset
iris_dt <- as.data.table(iris)
# What is the mean of 'Sepal.Length' for the species virginica? 
iris_dt[Species == "virginica",round(mean(Sepal.Length)) ]

# What R code returns a vector of the means of the variables 'Sepal.Length', 'Sepal.Width', 
# 'Petal.Length', and 'Petal.Width'?
apply(iris[ ,1:4],2,mean)


## Dataset: mtcars
library(datasets)
data(mtcars)

# How can one calculate the average miles per gallon (mpg) by number of cylinders in the car (cyl)?
with(mtcars, tapply(mpg, cyl, mean))

# What is the absolute difference between the average horsepower of 4-cylinder cars and the average 
# horsepower of 8-cylinder cars?
mtcars_dt <- as.data.table(mtcars)
mtcars_dt <- mtcars_dt[,  .(mean_cols = mean(hp)), by = cyl]
round(abs(mtcars_dt[cyl == 4, mean_cols] - mtcars_dt[cyl == 8, mean_cols]))

# alternativley you could use this command as well...
mean(mtcars[mtcars$cyl == "8",]$hp) - mean(mtcars[mtcars$cyl == "4",]$hp)

debug(ls)