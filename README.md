# Build Guide

- 使用Makefile與自己開發的[pvm](https://github.com/wush978/pvm.yml)做R套件的管理工具。
- 本專案所使用的套件都會放在`.lib`底下

請使用以下的指令進行專案的初始化:

```r
.libPaths() # 確定輸出的第一個元素是 .lib
install.packages("remotes")
remotes::install_github("wush978/pvm@v0.1")
pvm::import.packages()
```

接下來回到command line輸入`make`就會編譯出html slide了