## Course 3 - getting and cleaning data, week3_Quiz

##### 1)

data <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
df <- read.csv(data)
df

# Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 
# worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the 
# which() function like this to identify the rows of the data frame where the logical vector is TRUE. 
agricultureLogical <- df$ACR == 3 & df$AGS == 6
which(agricultureLogical)


##### 2)
library(jpeg)

## Download the file
picurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg" ## url of the picutre
path = '/Users/sorennonnengart/Coursera/Data_science/tasks/course_3_Data_cleaning/week3_quiz/picquiz3.jpg'  ## indicate the path where to save it
download.file(picurl, path, mode = 'wb') ## download the picture
PIC_1 <- readJPEG(path, native = TRUE)

# What are the 30th and 80th quantiles of the resulting data?
quantile(PIC_1, probs = c(0.3, 0.8))


##### 3)
library(dplyr)
library(data.table)

## Download the file
GDP_Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
GDP_Path <- "/Users/sorennonnengart/Coursera/Data_science/tasks/course_3_Data_cleaning/week3_quiz/GDP.csv"
EDU_Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
Edu_Path <- "/Users/sorennonnengart/Coursera/Data_science/tasks/course_3_Data_cleaning/week3_quiz/Edu.csv"

download.file(GDP_Url, GDP_Path, method = "curl")
download.file(EDU_Url, Edu_Path, method = "curl")

GDP <- fread(GDP_Path, skip = 5, nrows = 190, select = c(1, 2, 4, 5), col.names = c("CountryCode", "Rank", "Economy", "Total"))
Edu <- fread(Edu_Path)
GDP
EDU

# Match the data based on the country shortcode. 
Merge <- merge(GDP, Edu, by = 'CountryCode')
Merge <- Merge %>% arrange(desc(Rank))
Merge


paste(nrow(Merge), " matches, 13th country is ", Merge$Economy[13])


##### 4)

Merge %>% group_by(`Income Group`) %>%
  filter("High income: OECD" %in% `Income Group` | "High income: nonOECD" %in% `Income Group`) %>%
  summarize(avg = mean(Rank, na.rm = TRUE)) %>%
  arrange(desc(`Income Group`))


##### 5)

Merge$RankGroups <- cut(Merge$Rank, breaks = 5)
versus <- table(Merge$RankGroups, Merge$`Income Group`)
versus

versus[1, "Lower Middle Income"]
