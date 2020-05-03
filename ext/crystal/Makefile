SOURCES = $(shell find src -name *.cr)

all: bin/cccomplete_crystal bin/cccomplete_elixir bin/czcomplete_elixir
.PHONY: all

clean:
	-rm bin/*

spec:
	crystal spec
	

bin/cccomplete_crystal: $(SOURCES)
	crystal build src/cccomplete_crystal.cr -o bin/cccomplete_crystal

bin/cccomplete_elixir: $(SOURCES)
	crystal build src/cccomplete_elixir.cr -o bin/cccomplete_elixir

bin/czcomplete_elixir: $(SOURCES)
	crystal build src/czcomplete_elixir.cr -o bin/cccomplete_elixir
