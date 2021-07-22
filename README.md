# hasktorch-stack-skeleton

[1]:https://github.com/hasktorch/libtorch-binary-for-ci/releases
[2]:https://github.com/hasktorch/libtorch-binary-for-ci/releases/download/1.8.0/cpu-libtorch-cxx11-abi-shared-with-deps-latest.zip


[tutorial]:https://hasktorch.github.io/tutorial/01-getting-started.html

[setenv]:https://github.com/hasktorch/hasktorch/blob/master/setenv

## Creating a hasktorch project

To use hasktorch, you need to include the libtorch precompiled libraries and reference a hasktorch commit in `stack.yaml` extra deps. 

If you encounter linker errors you may need to specify a path to libtorch in the environment variable `LD_LIBRARY_PATH`. In this case you may want to download libtorch to `~/.libtorch` and then run `cp -rs $HOME/.libtorch libtorch` inside your project. This will allow you to write
```
export LD_LIBRARY_PATH=$HOME/.libtorch/lib:$LD_LIBRARY_PATH
```
in one of your shell configuration files, instead of the relative path `$PWD/libtorch` mentioned below.



### 1) libtorch 

Download the libtorch dependency in `./libtorch` by downloading
an archive [here][1] e.g. 
[cpu-libtorch-cxx11-abi-shared-with-deps-latest.zip][2]

```
$ curl -L https://github.com/hasktorch/libtorch-binary-for-ci/releases/download/1.8.0/cpu-libtorch-cxx11-abi-shared-with-deps-latest.zip >> libtorch.zip

$ unzip libtorch.zip
```
This will extract the libtorch dependencies inside `./libtorch/`. In some cases, you may encounter linking errors when using hasktorch inside stack ghci, and you may need to do:

```
$ export LD_LIBRARY_PATH=$(pwd)/libtorch/lib:$LD_LIBRARY_PATH
```
before running stack commands. 

_Q: Can we put libtorch in a single location instead and replace by `/path/to/libtorch/lib` in bashrc instead? => yes, use symlink to libtorch inside the project and absolute path for the environment_

### 2) hasktorch

Reference hasktorch 2 by git commit +libtorch in `stack.yaml` extra-deps:

```yaml
# ./stack.yaml

resolver: lts-17.4

packages:
- . 

extra-deps:
  - git: https://github.com/hasktorch/hasktorch.git
    commit: 4e846fdcd89df5c7c6991cb9d6142007a6bb0a58
    subdirs:
      - hasktorch
      - libtorch-ffi
      - libtorch-ffi-helper

extra-include-dirs:
  - libtorch/include/torch/csrc/api/include
  - libtorch/include

extra-lib-dirs:
  - ./libtorch/lib
```

Reference hasktorch as a dependency in `package.yaml` too:

```yaml
# ./package.yaml 
# ...
dependencies:
- base >= 4.7 && < 5
- hasktorch
```

Then you should be good to go and load the library:

```
$ stack build
$ stack ghci
ghci> import Torch
ghci> :t asTensor [1, 2, 3]
```

## Troubleshooting

In case you can load the library but get linker errors like 

```
λ> Torch.exp t
INTEL MKL ERROR: /opt/intel/mkl/lib/intel64/libmkl_vml_avx2.so: undefined symbol: mkl_blas4vml_dptrmm.
Intel MKL FATAL ERROR: cannot load libmkl_vml_avx2.so or libmkl_vml_def.so.
```
You may have missing libtorch links and should try fixing `$LD_LIBRARY_PRELOAD` as mentioned above. 

See also the contents of the hasktorch [setenv script here][setenv].

Otherwise contact the team on their slack channel.

## Documentation

Once you're good to go, follow on to the tutorial [here][tutorial] :)
