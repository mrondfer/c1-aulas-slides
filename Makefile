SHELL := /bin/bash

# FIGURES := $(shell find ./ -type f -name \*.tikz)
# COMPILED_FIGURES := $(FIGURES:.tex=.pdf)

FILES_CLEAN := $(shell find ./ -type f -name \*.aux -o -name \*.fdb_latexmk -o -name \*.fls -o -name \*.log -o -name \*.synctex.gz -o -name \*.dvi -o -name \*.nav -o -name \*.out -o -name \*.snm -o -name \*.toc -o -name \*.xdv)

FILES_PURGE := $(shell find ./ -type f -name \*.aux -o -name \*.fdb_latexmk -o -name \*.fls -o -name \*.log -o -name \*.synctex.gz -o -name \*.dvi -o -name \*.nav -o -name \*.out -o -name \*.snm -o -name \*.toc -o -name \*.xdv -o -name \*.pdf)

all: main

# figures:
#  latexmk -pdf -quiet -cd $(FIGURES)

main: main.tex
	latexmk -quiet

clean:
	@rm -f $(FILES_CLEAN)

purge:
	@rm -f $(FILES_PURGE)

.PHONY: main.pdf clean all