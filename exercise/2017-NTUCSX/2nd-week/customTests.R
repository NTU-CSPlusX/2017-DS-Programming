
memory_test <- function() {
  e <- get("e", parent.frame())
  source_result <- try(source(e$script_temp_path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") return(FALSE)
  name.list <- c("answer.yunlin", "answer.miaoli", "answer.hsinchu", "answer.chiayi")
  single.bytes <- 10000 * (10 + 4 + 4) / 1024 / 1024
  # 雲林縣的人口有69萬人、苗栗縣有56萬人、新竹縣有55萬人、嘉義縣有52萬人，
  # 雲林
  answer.yunlin.ref <- 69 * single.bytes
  # 苗栗
  answer.miaoli.ref <- 56 * single.bytes
  # 新竹
  answer.hsinchu.ref <- 55 * single.bytes
  # 嘉義
  answer.chiayi.ref <- 52 * single.bytes
  
  tryCatch({
    for(name in name.list) {
      if (!isTRUE(all.equal(
        get(name, envir = globalenv()),
        get(sprintf("%s.ref", name))
      ))) stop(sprintf("%s is wrong! Try again.\n", name))
    }
    TRUE
  }, error = function(e) {
    cat(conditionMessage(e))
    FALSE
  })
}