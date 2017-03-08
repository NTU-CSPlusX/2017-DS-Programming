
iris_test <- function() {
  e <- get("e", parent.frame())
  source_result <- try(source(e$script_temp_path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") return(FALSE)
  name.list <- paste0("answer", 1:3)
  # 載入iris資料集
  data(iris, envir = environment())
  
  # 請問iris$Species的型態(`class`)是?
  answer1 <- class(iris$Species)
  
  stopifnot(is.character(answer1))
  stopifnot(length(answer1) == 1)
  
  # 請計算Petal.Length在三種Species的平均值
  # 請將三種結果分別存到一個named list之中
  # list elements 的名稱對應到類別，包含的值則代表對應的Species在Petal.Length的平均值
  # 可以參考後面`stopifnot`的提示
  answer2 <- local({
    retval <- list()
    for(name in c("setosa", "versicolor", "virginica")) {
      retval[[name]] <- mean(iris[iris$Species == name,]$Petal.Length)
    }
    retval
  })
  
  stopifnot(is.list(answer2))
  stopifnot(length(answer2) == 3)
  stopifnot(names(answer2) == c("setosa", "versicolor", "virginica"))
  local({
    for(name in unique(iris$Species)) {
      stopifnot(is.numeric(answer2[[name]]))
      stopifnot(length(answer2[[name]]) == 1)
    }
  })
  
  # 請計算Sepal.Length, Sepal.Width, Petal.Length與Petal.Width分別在三種Species的平均值
  # 請將結果整理成一個data.frame
  # 每個column代表一個iris的類別
  # row則依序為Sepal.Length, Sepal.Width, Petal.Length與Petal.Width在該類別的平均值
  # colnames 應該為`c("setosa", "versicolor", "virginica")`
  # rownames 請用`c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width")`
  # 請不要搞錯順序
  answer3 <- local({
    retval <- do.call(cbind, lapply(split(iris, iris$Species), function(df) apply(df[,1:4], 2, mean)))
    as.data.frame(retval)
  })
  
  stopifnot(is.data.frame(answer3))
  stopifnot(ncol(answer3) == 3)
  stopifnot(nrow(answer3) == 4)
  stopifnot(colnames(answer3) == c("setosa", "versicolor", "virginica"))
  stopifnot(rownames(answer3) == c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"))
  local({
    for(name in unique(iris$Species)) {
      stopifnot(is.numeric(answer3[[name]]))
      stopifnot(length(answer3[[name]]) == 4)
    }
  })
  tryCatch({
    for(name in name.list) {
      if (!isTRUE(all.equal(
        get(name, envir = globalenv()),
        get(sprintf("%s", name), envir = environment(), inherits = FALSE)
      ))) stop(sprintf("%s is wrong! Try again.\n", name))
    }
    TRUE
  }, error = function(e) {
    cat(conditionMessage(e))
    FALSE
  })
}