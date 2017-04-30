ARGS <- commandArgs(trailingOnly = TRUE)
VERSION <- ARGS[[1]]

if(!file.exists("data")) dir.create("data")

lib.path <- file.path(getwd(), "r-packages",VERSION)
if(!dir.exists(lib.path)) dir.create(lib.path, recursive = TRUE)
.libPaths(lib.path)

if(!require(microbenchmark)) {
  options(repos = "https://cran.rstudio.com/")
  install.packages("microbenchmark")
}


library(microbenchmark)

if(!file.exists("libPath")) dir.create("libPath")

compiler::enableJIT(0)
y <- 1:10000

fnc_assign <- function(y) {
  x <- NULL
  for (i in y) {
    x[[i]] <- i
  }
  x
}

fnc_combines <- function(y) {
  x <- NULL
  for (i in y) {
    x <- c(x, i)
  }
  x
}

fnc_prealloc <- function(y) {
  x <- numeric(length(y))
  for (i in y) {
    x[[i]] <- i
  }
  x
}


result <-
  microbenchmark(fnc_assign(y), fnc_combines(y), fnc_prealloc(y))
result <- data.frame(Fnc = result$expr, Time = result$time)
write.table(result, file = paste0("data/result-", VERSION,".txt"))

y100 <- 1:100
y1000 <- 1:1000
y5000 <- 1:5000
y10000 <- 1:10000
y20000 <- 1:20000
y30000 <- 1:30000
y40000 <- 1:40000
y50000 <- 1:50000

result.size <- microbenchmark(
  fnc_assign(y100),
  fnc_assign(y1000),
  fnc_assign(y5000),
  fnc_assign(y10000),
  fnc_assign(y20000),
  fnc_assign(y30000),
  fnc_assign(y40000),
  fnc_assign(y50000)
)

result.size
result.size <- data.frame(Fnc = result.size$expr, Time = result.size$time)
write.table(result.size, file = paste0("data/result-size-", VERSION,".txt"))

