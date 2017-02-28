#' 請同學修正程式碼，讓它可以順利運行
#' 
#' 以下的程式碼取自上手R 語言中的練習
#' 但是它們有些語法錯誤
#' 請同學解決語法錯誤後**存檔(ctrl + s)**，再回到console輸入`submit()`


# 雲林縣的人口有69萬人、苗栗縣有56萬人、新竹縣有55萬人、嘉義縣有52萬人，
# 請問儲存以上縣市所有的身份證字號(用10個文字，10 Bytes)、性別(用整數，4 Bytes)與電話號碼(用整數4 Bytes)
# 需要多少記憶體(MB)?

# 雲林
answer.yunlin <- <人口數量> * 10000 * (<每儲存一個人的資訊所需要的記憶體大小>) / 1024 / 1024
# 苗栗
answer.miaoli<- <人口數量> * 10000 * (<每儲存一個人的資訊所需要的記憶體大小>) / 1024 / 1024
# 新竹
answer.hsinchu <- <人口數量> * 10000 * (<每儲存一個人的資訊所需要的記憶體大小>) / 1024 / 1024
# 嘉義
answer.chiayi <- <人口數量> * 10000 * (<每儲存一個人的資訊所需要的記憶體大小>) / 1024 / 1024

# 以下是檢查答案型態的程式碼，請不要修改
local({
  variables <- c("answer.yunlin", "answer.miaoli", "answer.hsinchu", "answer.chiayi")
  # 檢查以上的變數名稱，是不是數值型態，並且長度為1
  for(name in variables) {
    .v <- get(name)
    stopifnot(is.numeric(.v))
    stopifnot(length(.v) == 1)
  }
})

