library(shiny)
library(shinydashboard)
library(ggplot2)
library(tidyverse)
library(lubridate)
library(openair)

wd <- getwd()

data <- readRDS(file = paste(wd, "/data/RBSN_Daily_Data.rds", sep = ""))

station <- read.csv(file = paste(wd, "/data/Station_Info.csv", sep = ""),
                    header = TRUE,
                    colClasses = c("character", "character", rep(x = "numeric", 3)))

para <- read.csv(file = paste(wd, "/data/Parameter.csv", sep = ""),
                 header = TRUE,
                 colClasses = c("character", "character"))