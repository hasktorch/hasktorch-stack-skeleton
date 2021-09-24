LD_LIBRARY_PATH := ${PATH}/libtorch/lib:${LD_LIBRARY_PATH}
UNAME := $(shell uname)

default: libtorch/lib/
	stack build

libtorch/lib/:
	@if [ "$(UNAME)" = "Linux" ]; then\
		curl -L https://github.com/hasktorch/libtorch-binary-for-ci/releases/download/1.9.0/cpu-libtorch-cxx11-abi-shared-with-deps-latest.zip >> libtorch.zip;\
	elif [ "$(UNAME)" = "Darwin" ]; then\
		curl -L https://github.com/hasktorch/libtorch-binary-for-ci/releases/download/1.9.0/cpu-libtorch-macos-latest.zip >> libtorch.zip;\
	fi
	unzip libtorch.zip
	rm libtorch.zip
