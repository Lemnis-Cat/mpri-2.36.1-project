

default:
	@echo 'type `make ide` or `make tests` or `make replay` or `make doc`'

ide:
	why3 ide takuzu.mlw

tests:
	why3 extract -D ocaml64 takuzu.mlw -o takuzu.ml
	ocamlbuild -pkg unix -pkg zarith test_takuzu.native
	./test_takuzu.native

replay:
	why3 replay takuzu

doc:
	why3 doc takuzu.mlw
	why3 session html takuzu
