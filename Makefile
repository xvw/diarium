.PHONY: all build test clean utop

all:
	dune build src/diarium.exe

build:
	dune build

test:
	dune runtest --no-buffer -j 1

clean:
	dune clean

utop:
	dune utop

# Development mode
.PHONY: setup

setup: vendor
	opam install .

vendor:
	mkdir -p vendor
	git clone git@github.com:xvw/preface.git vendor
