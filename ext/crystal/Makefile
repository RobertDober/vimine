SOURCES = $(shell find src -name *.cr) Makefile
CCC_TARGETS = $(shell ls src/cccompleters/*.cr | sed '/generic_/d;s/\.cr//;s|.*/|bin/cccomplete_|')
CZC_TARGETS = $(shell ls src/czcompleters/*.cr | sed '/generic_/d;s/\.cr//;s|.*/|bin/czcomplete_|')

TARGETS = $(CCC_TARGETS) $(CZC_TARGETS)

all: $(TARGETS)
.PHONY: all

clean:
	-rm bin/*

spec:
	crystal spec
	

bin/cccomplete_crystal: $(SOURCES)
	crystal build src/cccomplete_crystal.cr -o bin/cccomplete_crystal

bin/cccomplete_elixir: $(SOURCES)
	crystal build src/cccomplete_elixir.cr -o bin/cccomplete_elixir

bin/cccomplete_ruby: $(SOURCES)
	crystal build src/cccomplete_ruby.cr -o bin/cccomplete_ruby

bin/czcomplete_elixir: $(SOURCES)
	crystal build src/czcomplete_elixir.cr -o bin/czcomplete_elixir
