LD_LIBRARY_PATH := ${PATH}/libtorch/lib:${LD_LIBRARY_PATH}

default: libtorch/lib/libtorch_cpu.so
	stack build

libtorch/lib/libtorch_cpu.so: 
	curl -L https://github.com/hasktorch/libtorch-binary-for-ci/releases/download/1.9.0/cpu-libtorch-cxx11-abi-shared-with-deps-latest.zip >> libtorch.zip	
	unzip libtorch.zip
	rm libtorch.zip
