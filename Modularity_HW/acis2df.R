library(maps)
library(httr)
library(lubridate)
library(qdapRegex)
library(jsonlite)

acis2df <- function(sdate="19500101", edate="20161231", states=state.abb){
  annualmean <- data.frame(NA)
  for(i in seq_along(states)){
    # 'params=%7B%22state%22%3A%22ks%22%2C%22sdate%22%3A%2219500101%22%2C%22edate%22%3A%2220101231%22%2C%22elems%22%3A%22avgt%22%2C%22meta%22%3A%22ll%2Cstation%2Cstate%22%7D'
    base.url <- "http://data.rcc-acis.org/MultiStnData?" #specific to multi-station data
    params1.url <- "params=%7B%22state%22%3A%22" #state
    params2.url <- "%22%2C%22sdate%22%3A%22" #sdate (start date)
    params3.url <- "%22%2C%22edate%22%3A%22" #edate (end date)
    params4.url <- "%22%2C%22elems%22%3A%22avgt%22%2C%22meta%22%3A%22ll%2Cname%2Cstate%22%7D"
    #params can be divided in any way as long as they all go back together in the end, could probably make more modular by dividing in a different way
    acis.url <- paste0(base.url,params1.url,state.abb[i],params2.url, sdate, params3.url, edate, params4.url)
    test <- httr::GET(url=acis.url)
    dat <- httr::content(test, "text","application/json", encoding="UTF-8") #turning back into human readable test
    json_data <- jsonlite::fromJSON(dat) #this step gets slowed down when pulling in CA, TX, etc trying to transform json data to lists in r, can take a lot of RAM
    ifelse(dir.exists("rds"), "dir already exists", dir.create("rds")) #create rds subdirectory, temporary files
    ifelse(dir.exists("data"), "dir already exists", dir.create("data")) #this data is static unless it needs to be changed, if the directory alrady exists then it wont go get the data again
    newFN <- paste0("rds/",state.abb[i],"_",sdate,".rds")
    saveRDS(json_data, file=newFN)
    ff <- sapply(json_data$data$data, cbind) #taking unattrractive looking list, have a whole bunch of columns stacked together, we can put those into a matrix, ff becomes a 2D matrix (call str(ff) to see it)
    ff[ff=="M"] <- NA #NA values in ACIS marked with M ("missing")
    trace <- runif(1000,0.0001,.0099) #avoiding populating df with a bunch of zeroes, randomly drawing "trace" amounts of precip
    ff[ff=="T"] <- sample(trace,replace = T,size = 1) #T in dataset ("trace"), replace with random number draws
    class(ff) <- "numeric" #numbers now, don't want R to treat them as character strings
    dates <- seq.Date(from=lubridate::ymd(sdate), to=lubridate::ymd(edate), by = "1 days") #ymd telling R specifically what format of date you are looking at (example, NOT ydm)
    year <- as.factor(lubridate::year(dates)) #have daily data but need annual, aggregating it basically
    
    ff <- data.frame(date=dates,ff)
    names(ff) <- c("date",paste(json_data$data$meta$state[],json_data$data$meta$name[], json_data$data$meta$ll[][], sep="_")) #columns not named right now so helpful to assign names to those, assign the metadata to each one of these columns, paste together (making names variable, that might be why it is in a list format, different format than everything else)
    ff$year <- as.factor(lubridate::year(ff$date))
    # summarize by year
    fc <- aggregate(by=list(ff$year), x=ff[,2:(ncol(ff)-1)], mean) #aggregating by year
    names(fc)[1] <- "year" #naming the column year
    fc$year <- as.numeric(as.character(fc$year)) #another time where we need to switch class from character to numeric
    annualmean <- cbind(annualmean, fc) #gotten everything done, want to move onto the next state, want to add next state onto previous state, vector initialized way at the beginning
    print(state.abb[i]) #indicators that script is making progress
    print(Sys.time()) #another indicator that script is making progress
    Sys.sleep(2) #being polite, letting others get on the queue
  }
  fname <- paste0("data/USAAnnualTemp",sdate,"_", edate,".rds") #name for new rds populated by data from web pull
  saveRDS(annualmean, file=fname)
}

lf <- list.files(pattern="1231.rds$", path="data/", full.names = T) #only going to look for files that end in "1231.rds" so better make sure your edate ends in 1231
temp <- data.frame()
for(i in lf){
  tmp <- readRDS(i)
  tmp2 <- reshape2::melt(tmp, id.vars="year") #reshape into something that is long, not wide because easier for R to work on
  temp <- rbind(temp, tmp2) #add data frame just built to blank one, have the 2 sets go together, basically populates the empty data frame
}
temp <- temp[!temp$variable=="NA.",]
grid <- strsplit(as.character(temp$variable), ",")
latff <- sapply(grid,"[",2)
temp$lat <- as.numeric(gsub(x=latff, replacement = "",pattern=" |)"))
lonff <- sapply(grid,"[",1)
temp$lon <- as.numeric(sub("\\D+","",lonff))*-1
temp$state <- substr(temp$variable,1,2)
library(qdapRegex)
temp$name <- rm_between(text.var =lonff, left = "_", right="_", extract=TRUE)

saveRDS(temp, "~/Documents/DataCarpentry/Arsenault_dcei/Modularity_HW/data/USAAnnualTemp1950_2016.Rds")