SHELL := /bin/bash
LATEX := latexmk -pdf -pdflatex="pdflatex --shell-escape"

.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: ide
ide: ## Launch Why3 IDE on file tazuku.mlw
	why3 ide takuzu.mlw

.PHONY: test
tests: ## Test the program on an example grid
	why3 extract -D ocaml64 takuzu.mlw -o takuzu.ml
	ocamlbuild -pkg unix -pkg zarith test_takuzu.native
	./test_takuzu.native

.PHONY: replay
replay: ## Replay the proofs
	why3 replay takuzu

.PHONY: doc
doc: takuzu.html ## Produce html file

takuzu.html: takuzu.mlw
	why3 doc takuzu.mlw
	why3 session html takuzu

report/code/all.tex: takuzu.html
	pandoc -o report/code/all.tex takuzu.html
	sed --in-place 's/begin{verbatim}/begin{minted}{ocaml}/g' report/code/all.tex
	sed --in-place 's/end{verbatim}/end{minted}/g' report/code/all.tex

.PHONY: report
report: report/report.pdf ## Produce pdf file

report/report.pdf: report/code/all.tex report/report.tex
	cd report && $(LATEX) report.tex

.PHONY: clean
clean: ## Remove documentation and report
	cd report && latexmk -C
	rm takuzu.html
	rm report/code/all.tex
