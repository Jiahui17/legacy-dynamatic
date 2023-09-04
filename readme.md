# The Dynamatic HLS Compiler (A fork for formal verification)

For official repository please checkout https://github.com/lana555/dynamatic

## Installation (Tested on Ubuntu/Debian based distributions)

Install dependencies:
```sh
sudo apt-get install -y build-essential \
	g++ cmake git pkg-config \
	coinor-cbc \
	graphviz graphviz-dev \
	xdot libxdot4 python3.8*

# install boost library
wget https://boostorg.jfrog.io/artifactory/main/release/1.82.0/source/boost_1_82_0.tar.gz
cd boost_1_82_0
./bootstrap.sh
sudo ./b2 install
```

Build LLVM (version 6.0):
```sh
git clone http://github.com/llvm-mirror/llvm --branch release_60 --depth 1
cd llvm/tools
git clone http://github.com/llvm-mirror/clang --branch release_60 --depth 1
git clone http://github.com/llvm-mirror/polly --branch release_60 --depth 1
cd ..
mkdir _build && cd _build
$CMAKE .. -DCMAKE_BUILD_TYPE=Debug \
	-DLLVM_INSTALL_UTILS=ON \
	-DLLVM_TARGETS_TO_BUILD="X86" \
	-DCMAKE_INSTALL_PREFIX=/usr/local/llvm-6.0

make # not recommended to enable parallel build
sudo make install
```

Clone this repo:
```
INSTALL_DIR=$HOME
mkdir -p $INSTALL_DIR/Dynamatic/etc
git clone https://github.com/Jiahui17/dynamatic.git $INSTALL_DIR/Dynamatic/etc/dynamatic
cd $INSTALL_DIR/Dynamatic/etc/dynamatic && bash build.sh
```

## Regression Test

Please refer to `./Regression_test/readme.md`
