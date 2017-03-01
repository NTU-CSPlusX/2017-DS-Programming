#' titanic.class 一共有四種可能的值：
#' ## [1] "Crew" "1st"  "3rd"  "2nd" 
#' 同學可以利用`unique(titanic.class)`確認，並且趁機用?unique看一看這個函數的功能
#' ps. 作業中並不會用到
#' 
#' 請同學用`==`拿`titanic.class`與`Crew`比較，取得一個布林(logical)向量
#' 把結果存入變數`answer1`
answer1 <- <請填寫你的程式碼>
  
#' 以下以`stopifnot`開頭的程式都是一些檢查答案的程式碼，請不要修改它們
stopifnot(is.logical(answer1))
stopifnot(length(answer1) == length(titanic.class))

#' `as.numeric`可以將一個向量轉換為數值向量。
#' 請同學把`answer1`轉換為數值向量
#' 把結果存入變數`answer2`
answer2 <- <請填寫你的程式碼>

stopifnot(length(answer2) == length(answer1))
stopifnot(is.numeric(answer2))
  
#' `sum`可以計算數值向量的總和
#' 請同學計算`answer2`的數值的總和
#' 把結果存入變數`answer3`
answer3 <- <請填寫你的程式碼>
#' 這個就是船上總船員的個數
#' 為什麼?
#' 因為TRUE ==> 1, FALSE ==> 0, 而把1 加起來就是船員的總數

stopifnot(length(answer3) == 1)

#' 以上的作法比較麻煩。`sum`在計算時，會自動把布林(logical)向量轉換為數值向量
#' 所以只要輸入: `sum(titanic.class == "Crew")`就可以算出船員的個數

stopifnot(sum(titanic.class == "Crew") == answer3)

#' 同樣的道理，請同學用`titanic.age`算出船上有多少小孩
#' 請將結果存入變數`answer4`
#' 提示: 先用`unique`看一下小孩用的代表字串，再用`sum`與`==`做計算
answer4 <- <請填寫你的程式碼>

stopifnot(length(answer4) == 1)

#' 我們也可以用類似的訣竅，配合`mean`一行計算死亡率
#' 請同學從`titanic.survived`計算鐵達尼上整體的死亡率
#' 請將結果存入變數`answer5`
#' 提示: `titanic.survived`中的`FALSE` 代表死亡
answer5 <- <請填寫程式碼>

stopifnot(length(answer5) == 1)

#' titanic.sex 代表的是船上各員的性別
#' 並且他們的順序是一樣的。
#' 也就是說，在列出:
#' titanic.sex[1:5]
#' titanic.survived[1:5]
#' 我們知道前五筆資料都是男性，並且只有第一筆與第二筆資料的男性有生存
#' 請同學從`titanic.survived`計算鐵達尼上男性的死亡率
#' 請將結果存入變數`answer6`
#' 提示: `titanic.survived`中的`FALSE` 代表死亡
answer6 <- <請填寫程式碼>

stopifnot(length(answer6) == 1)

#' 完成後，請**存檔**後回到console輸入`submit()`檢查答案