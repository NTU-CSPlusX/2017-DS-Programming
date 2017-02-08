WEEKS=$(wildcard *.week)

.PHONY : all $(WEEKS)

all : $(WEEKS)

$(WEEKS) :
	$(MAKE) -C $@
