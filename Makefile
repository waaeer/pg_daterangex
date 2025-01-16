EXTENSION=daterangex
MODULE_big=daterangex
OBJS = daterangex.o
PGFILEDESC = "daterangex - daterange with inclusive upper bound"
DATA = "daterangex--1.0.sql"

REGRESS="daterangex"
ifdef USE_PGXS
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
endif


