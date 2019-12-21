SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >

build: out/tiny_c out/tiny_asm
.PHONY: build

# Clean up the output directories; since all the sentinel files go under tmp, this will cause everything to get rebuilt
clean:
> rm -rf tmp
> rm -rf out
.PHONY: clean

out/tiny_c: tiny.c
> mkdir -p $(@D)
> $(CC) -o $@ -Wall -Os -s $<

out/tiny.asm.o: tiny.asm
> mkdir -p $(@D)
> nasm -f elf64 -o $@ $<
# > gcc -s -nostdlib -o $@ -c $<

out/tiny_asm: out/tiny.asm.o
> mkdir -p $(@D)
> ld -s $< -o $@
# > $(CC) -Wall -Os -s $< -o $@ -nostartfiles -no-pie -nostdlib

# out/tiny_asm: tiny.s
# > mkdir -p $(@D)
# # > nasm -f elf64 -o $@ $<
# > gcc -Os -s -nostdlib -o $@ $<
