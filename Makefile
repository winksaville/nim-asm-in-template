ifeq ($(proc),true)
  use_proc=-d:use_proc
else
  use_proc=--symbol:use_proc
endif

usage:
	@echo " Usage for successfull compile:"
	@echo "   make all proc=true"
	@echo ""
	@echo " Usage for failing compile:"
	@echo "   make all proc=false"

.PHONY: all
all: clean
	nim c $(use_proc) -d:release --parallelBuild:1 test_asm.nim
	./test_asm

.PHONY: clean
clean:
	@rm -rf nimcache/ test_asm
