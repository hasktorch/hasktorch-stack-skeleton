# This is the same as VERSION in https://github.com/hasktorch/hasktorch/blob/master/deps/get-deps.sh
VERSION := 1.9.0
LD_LIBRARY_PATH := $(PATH)/libtorch/lib:$(LD_LIBRARY_PATH)
UNAME := $(shell uname)

default: libtorch/lib/
	stack build

# This provides a generic CPU-based libtorch library. You may want to modify
# the URLs below depending on your machine. See
# https://github.com/hasktorch/hasktorch/blob/master/deps/get-deps.sh for which
# URLs to use.
libtorch/lib/:
	@if [ "$(UNAME)" = "Linux" ]; then\
		wget -O libtorch.zip https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-$(VERSION)\%2Bcpu.zip; \
	elif [ "$(UNAME)" = "Darwin" ]; then\
		curl -L https://download.pytorch.org/libtorch/cpu/libtorch-macos-$(VERSION).zip >> libtorch.zip; \
	fi
	unzip libtorch.zip
	rm libtorch.zip
