# 載入iris資料集
data(iris)

# 請問iris$Species的型態(`class`)是?
answer1 <- <請填寫你的程式碼>

stopifnot(is.character(answer1))
stopifnot(length(answer1) == 1)

# 請計算Petal.Length在三種Species的平均值
# 請將三種結果分別存到一個named list之中
# list elements 的名稱對應到類別，包含的值則代表對應的Species在Petal.Length的平均值
# 可以參考後面`stopifnot`的提示
answer2 <- local({
  <請填寫你的程式碼>
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
  <請填寫你的程式碼>
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
