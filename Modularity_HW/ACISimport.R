#load libraries needed for script
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
    acis.url <- paste0(base.url,params1.url,state.abb[i],params2.url, sdate, params3.url, edate, params4.url)
    test <- httr::GET(url=acis.url)
    dat <- httr::content(test, "text","application/json", encoding="UTF-8")
    json_data <- jsonlite::fromJSON(dat)
    ifelse(dir.exists("rds"), "dir all ready exists", dir.create("rds"))
    ifelse(dir.exists("data"), "dir all ready exists", dir.create("data"))
    newFN <- paste0("rds/",state.abb[i],"_",sdate,".rds")
    saveRDS(json_data, file=newFN)
    ff <- sapply(json_data$data$data, cbind)
    ff[ff=="M"] <- NA #NA values in ACIS marked with M ("missing")
    trace <- runif(1000,0.0001,.0099) #avoiding populating df with a bunch of zeroes, randomly drawing "trace" amounts of precip
    ff[ff=="T"] <- sample(trace,replace = T,size = 1) #T in dataset ("trace"), replace with random number draws
    class(ff) <- "numeric" #numbers now, don't want R to treat them as character strings
    dates <- seq.Date(from=lubridate::ymd(sdate), to=lubridate::ymd(edate), by = "1 days")
    year <- as.factor(lubridate::year(dates)) #have daily data but need annual
    
    ff <- data.frame(date=dates,ff)
    names(ff) <- c("date",paste(json_data$data$meta$state[],json_data$data$meta$name[], json_data$data$meta$ll[][], sep="_"))
    ff$year <- as.factor(lubridate::year(ff$date))
    # summarize by year
    fc <- aggregate(by=list(ff$year), x=ff[,2:(ncol(ff)-1)], mean)
    names(fc)[1] <- "year"
    fc$year <- as.numeric(as.character(fc$year))
    annualmean <- cbind(annualmean, fc)
    print(state.abb[i])
    print(Sys.time())
    Sys.sleep(2) #nice thing, letting others get on the queue
  }
  fname <- paste0("data/USAAnnualTemp",sdate,"_", edate,".rds") #name for new rds populated by data from web pull
  saveRDS(annualmean, file=fname)
}

lf <- list.files(pattern="1231.rds$", path="data/", full.names = T)
temp <- data.frame()
for(i in lf){
  tmp <- readRDS(i)
  tmp2 <- reshape2::melt(tmp, id.vars="year")
  temp <- rbind(temp, tmp2)
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