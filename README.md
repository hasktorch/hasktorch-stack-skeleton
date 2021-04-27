# hasktorch-stack-skeleton

[1]:https://github.com/hasktorch/libtorch-binary-for-ci/releases
[2]:https://github.com/hasktorch/libtorch-binary-for-ci/releases/download/1.8.0/cpu-libtorch-cxx11-abi-shared-with-deps-latest.zip


[tutorial]:https://htmlpreview.github.io/?https://raw.githubusercontent.com/mcwitt/hasktorch/tutorial-tintin/website/tutorial/01-getting-started.html

## creating a hasktorch project

Download the libtorch dependency in `./libtorch` by downloading
an archive [here][1] e.g. 
[cpu-libtorch-cxx11-abi-shared-with-deps-latest.zip][2]

```
$ curl -L https://github.com/hasktorch/libtorch-binary-for-ci/releases/download/1.8.0/cpu-libtorch-cxx11-abi-shared-with-deps-latest.zip >> libtorch.zip

$ unzip libtorch.zip
```

Reference hasktorch git commit in `stack.yaml` extra-deps:

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

Reference hasktorch in `package.yaml` too:

```yaml
# ./package.yaml 
# ...
dependencies:
- base >= 4.7 && < 5
- hasktorch
```

You should then be able to load the library:

```
$ stack build
$ stack ghci
ghci> import Torch
ghci> :t asTensor [1, 2, 3]
```

## documentation

Follow on to the tutorial [here][tutorial].
