.PHONY: all build test clean utop cli

all: cli

cli:
	dune build cli/diarium.exe

build:
	dune build

test:
	dune runtest --no-buffer -j 1

clean:
	dune clean

utop:
	dune utop

# Development mode
.PHONY: setup vendor

setup: vendor
	opam install .

vendor:
	mkdir -p vendor
	# Should be removed when preface'll be public
	git clone git@github.com:xvw/preface.git vendor
