
power_test <- function() {
  e <- get("e", parent.frame())
  source_result <- try(source(e$script_temp_path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") return(FALSE)
  name.list <- paste0("answer", 1:6)
  year1 <- 87:91
  # 社會服務業自民國87至民國91年的年度用電量（度）
  power1 <- c(6097059332, 6425887925, 6982579022, 7323992602.53436, 7954239517) 
  # 製造業自民國87至民國91年的年度用電量（度）
  power2 <- c(59090445718, 61981666330, 67378329131, 66127460204.6482, 69696372914.6949) 
  
  # 請利用year1, power1, 與power2 建立一個data.frame，依序包含三個column: year, social, manufacturing
  # 並且分別代表年份、社會服務業的用電量與製造業的用電量
  answer1 <- data.frame(year = year1, social = power1, manufacturing = power2)
  
  stopifnot(is.data.frame(answer1))
  stopifnot(nrow(answer1) == length(year1))
  stopifnot(answer1[[1]] == year1)
  stopifnot(answer1[[2]] == power1)
  stopifnot(answer1[[3]] == power2)
  stopifnot(colnames(answer1) == c("year", "social", "manufacturing"))
  
  # 請利用answer1來回答以下問題
  
  # 請選出answer1中社會服務業的用電量超過`7e9`的row
  answer2 <- answer1[answer1$social > 7e9,]
  
  stopifnot(is.data.frame(answer2))
  stopifnot(ncol(answer2) == ncol(answer1))
  stopifnot(nrow(answer2) == sum(power1 > 7e9))
  
  # 請問社會服務業的平均用電量
  answer3 <- mean(power1)
  
  stopifnot(is.numeric(answer3))
  stopifnot(length(answer3) == 1)
  
  # 請選出answer1中社會服務業的用電量超過answer3的row
  answer4 <- answer1[power1 > answer3,]
  
  stopifnot(is.data.frame(answer4))
  stopifnot(ncol(answer4) == ncol(answer1))
  stopifnot(nrow(answer4) == sum(power1 > answer3))
  
  # 請同學找出answer1中「社會服務業的用電量」，超過「製造業的10%用電量」的row
  answer5 <- answer1[power1 > 0.1 * power2,]
  
  stopifnot(is.data.frame(answer5))
  stopifnot(ncol(answer5) == ncol(answer1))
  stopifnot(nrow(answer5) == sum(power1 > 0.1 * power2))
  
  # 請同學找出「社會服務業的用電量」，超過「製造業的10%用電量」的年份
  answer6 <- answer5$year
  
  stopifnot(class(answer6) == class(year1))
  stopifnot(length(answer6) == sum(power1 > 0.1 * power2))
 
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