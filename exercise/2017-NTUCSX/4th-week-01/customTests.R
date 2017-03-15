testVal <- function(name, value) {
  isTRUE(all.equal(get(name, globalenv()), value))
}