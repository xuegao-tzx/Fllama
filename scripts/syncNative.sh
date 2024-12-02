#!/bin/zsh -e
# Update time: 2024-12-02 15:46:15

# Copyright (c) 2024, Small Grass Forest
#
# Use of this source code is governed by a MIT-style license
# that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

export LANG=C.UTF-8

if [ ! -e "cpp-file" ];then
  mkdir -p "cpp-file"
fi
cd cpp-file
if [ ! -f llama-cpp.zip ];then
  wget "https://github.com/ggerganov/llama.cpp/archive/refs/heads/master.zip" -O llama-cpp.zip
fi
if [ ! -e "llama" ];then
  unzip llama-cpp.zip
  mv "llama.cpp-master" llama
fi

cp ./llama/include/llama.h ../ios/Cpp/llama.h

cp ./llama/ggml/include/ggml.h ../ios/Cpp/ggml.h
cp ./llama/ggml/include/ggml-cpu.h ../ios/Cpp/ggml-cpu.h
cp ./llama/ggml/include/ggml-cpp.h ../ios/Cpp/ggml-cpp.h
cp ./llama/ggml/include/ggml-metal.h ../ios/Cpp/ggml-metal.h
cp ./llama/ggml/include/ggml-alloc.h ../ios/Cpp/ggml-alloc.h
cp ./llama/ggml/include/ggml-backend.h ../ios/Cpp/ggml-backend.h

cp ./llama/ggml/src/ggml.c ../ios/Cpp/ggml.c
cp ./llama/ggml/src/ggml-alloc.c ../ios/Cpp/ggml-alloc.c
cp ./llama/ggml/src/ggml-threading.cpp ../ios/Cpp/ggml-threading.cpp
cp ./llama/ggml/src/ggml-threading.h ../ios/Cpp/ggml-threading.h
cp ./llama/ggml/src/ggml-backend.cpp ../ios/Cpp/ggml-backend.cpp
cp ./llama/ggml/src/ggml-backend-impl.h ../ios/Cpp/ggml-backend-impl.h
cp ./llama/ggml/src/ggml-backend-reg.cpp ../ios/Cpp/ggml-backend-reg.cpp
cp ./llama/ggml/src/ggml-impl.h ../ios/Cpp/ggml-impl.h
cp ./llama/ggml/src/ggml-common.h ../ios/Cpp/ggml-common.h
cp ./llama/ggml/src/ggml-quants.h ../ios/Cpp/ggml-quants.h
cp ./llama/ggml/src/ggml-quants.c ../ios/Cpp/ggml-quants.c
cp ./llama/ggml/src/ggml-aarch64.h ../ios/Cpp/ggml-aarch64.h
cp ./llama/ggml/src/ggml-aarch64.c ../ios/Cpp/ggml-aarch64.c

cp ./llama/ggml/src/ggml-cpu/ggml-cpu.c ../ios/Cpp/ggml-cpu.c
cp ./llama/ggml/src/ggml-cpu/ggml-cpu.cpp ../ios/Cpp/ggml-cpu.cpp
cp ./llama/ggml/src/ggml-cpu/ggml-cpu-impl.h ../ios/Cpp/ggml-cpu-impl.h
cp ./llama/ggml/src/ggml-cpu/ggml-cpu-quants.c ../ios/Cpp/ggml-cpu-quants.c
cp ./llama/ggml/src/ggml-cpu/ggml-cpu-quants.h ../ios/Cpp/ggml-cpu-quants.h
cp ./llama/ggml/src/ggml-cpu/ggml-cpu-aarch64.c ../ios/Cpp/ggml-cpu-aarch64.c
cp ./llama/ggml/src/ggml-cpu/ggml-cpu-aarch64.h ../ios/Cpp/ggml-cpu-aarch64.h

cp ./llama/ggml/src/ggml-cpu/llamafile/sgemm.h ../ios/Cpp/sgemm.h
cp ./llama/ggml/src/ggml-cpu/llamafile/sgemm.cpp ../ios/Cpp/sgemm.cpp

cp ./llama/ggml/src/ggml-cpu/amx/amx.h ../ios/Cpp/amx.h
cp ./llama/ggml/src/ggml-cpu/amx/amx.cpp ../ios/Cpp/amx.cpp
cp ./llama/ggml/src/ggml-cpu/amx/common.h ../ios/Cpp/amx-common.h
cp ./llama/ggml/src/ggml-cpu/amx/mmq.h ../ios/Cpp/mmq.h
cp ./llama/ggml/src/ggml-cpu/amx/mmq.cpp ../ios/Cpp/mmq.cpp

cp ./llama/ggml/src/ggml-metal/ggml-metal-impl.h ../ios/Cpp/ggml-metal-impl.h
cp ./llama/ggml/src/ggml-metal/ggml-metal.m ../ios/Cpp/ggml-metal.m
cp ./llama/ggml/src/ggml-metal/ggml-metal.metal ../ios/Cpp/ggml-metal.metal

cp ./llama/src/llama.cpp ../ios/Cpp/llama.cpp
cp ./llama/src/llama-vocab.cpp ../ios/Cpp/llama-vocab.cpp
cp ./llama/src/llama-vocab.h ../ios/Cpp/llama-vocab.h
cp ./llama/src/llama-sampling.cpp ../ios/Cpp/llama-sampling.cpp
cp ./llama/src/llama-sampling.h ../ios/Cpp/llama-sampling.h
cp ./llama/src/llama-grammar.cpp ../ios/Cpp/llama-grammar.cpp
cp ./llama/src/llama-grammar.h ../ios/Cpp/llama-grammar.h
cp ./llama/src/llama-impl.h ../ios/Cpp/llama-impl.h
cp ./llama/src/unicode.h ../ios/Cpp/unicode.h
cp ./llama/src/unicode.cpp ../ios/Cpp/unicode.cpp
cp ./llama/src/unicode-data.h ../ios/Cpp/unicode-data.h
cp ./llama/src/unicode-data.cpp ../ios/Cpp/unicode-data.cpp

cp ./llama/common/base64.hpp ../ios/Cpp/base64.hpp
cp ./llama/common/log.h ../ios/Cpp/log.h
cp ./llama/common/log.cpp ../ios/Cpp/log.cpp
cp ./llama/common/sampling.h ../ios/Cpp/sampling.h
cp ./llama/common/sampling.cpp ../ios/Cpp/sampling.cpp
cp ./llama/common/common.h ../ios/Cpp/common.h
cp ./llama/common/common.cpp ../ios/Cpp/common.cpp
cp ./llama/common/stb_image.h ../ios/Cpp/stb_image.h
cp ./llama/common/json.hpp ../ios/Cpp/json.hpp
cp ./llama/common/json-schema-to-grammar.h ../ios/Cpp/json-schema-to-grammar.h
cp ./llama/common/json-schema-to-grammar.cpp ../ios/Cpp/json-schema-to-grammar.cpp

cp ./llama/examples/llava/clip.cpp ../ios/Cpp/clip.cpp
cp ./llama/examples/llava/clip.h ../ios/Cpp/clip.h
cp ./llama/examples/llava/llava.cpp ../ios/Cpp/llava.cpp
cp ./llama/examples/llava/llava.h ../ios/Cpp/llava.h

echo "😊 Copy files completed successfully!"

# List of files to process
# shellcheck disable=SC2054
files=(
  "../ios/Cpp/ggml.h"
  "../ios/Cpp/ggml.c"
  "../ios/Cpp/common.h"
  "../ios/Cpp/common.cpp"
  "../ios/Cpp/ggml-metal.h"
  "../ios/Cpp/ggml-metal-impl.h"
  "../ios/Cpp/ggml-metal.m"
  "../ios/Cpp/ggml-metal.metal"
  "../ios/Cpp/base64.hpp"
  "../ios/Cpp/amx.h"
  "../ios/Cpp/amx.cpp"
  "../ios/Cpp/amx-common.h"
  "../ios/Cpp/mmq.h"
  "../ios/Cpp/mmq.cpp"
  "../ios/Cpp/log.h"
  "../ios/Cpp/log.cpp"
  "../ios/Cpp/llama.h"
  "../ios/Cpp/llama.cpp"
  "../ios/Cpp/llama-vocab.cpp"
  "../ios/Cpp/llama-sampling.cpp"
  "../ios/Cpp/llama-grammar.cpp"
  "../ios/Cpp/llama-impl.h"
  "../ios/Cpp/sampling.cpp"
  "../ios/Cpp/ggml-quants.h"
  "../ios/Cpp/ggml-quants.c"
  "../ios/Cpp/ggml-alloc.h"
  "../ios/Cpp/ggml-alloc.c"
  "../ios/Cpp/ggml-backend.h"
  "../ios/Cpp/ggml-backend.cpp"
  "../ios/Cpp/ggml-backend-impl.h"
  "../ios/Cpp/ggml-backend-reg.cpp"
  "../ios/Cpp/ggml-impl.h"
  "../ios/Cpp/ggml-common.h"
  "../ios/Cpp/ggml-cpu.c"
  "../ios/Cpp/ggml-cpu.cpp"
  "../ios/Cpp/ggml-cpu.h"
  "../ios/Cpp/ggml-cpu-impl.h"
  "../ios/Cpp/ggml-cpp.h"
  "../ios/Cpp/sgemm.cpp"
  "../ios/Cpp/ggml-threading.h"
  "../ios/Cpp/ggml-threading.cpp"
  "../ios/Cpp/json-schema-to-grammar.h"
  "../ios/Cpp/ggml-cpu-aarch64.h"
  "../ios/Cpp/ggml-cpu-aarch64.c"
  "../ios/Cpp/ggml-cpu-quants.c"
  "../ios/Cpp/ggml-cpu-quants.h"
  "../ios/Cpp/ggml-aarch64.h"
  "../ios/Cpp/ggml-aarch64.c"
  "../ios/Cpp/stb_image.h"
  "../ios/Cpp/clip.cpp"
  "../ios/Cpp/clip.h"
  "../ios/Cpp/llava.cpp"
  "../ios/Cpp/llava.h"
)

# Loop through each file and run the sed commands
OS=$(uname)
for file in "${files[@]}"; do
  # Add prefix to avoid redefinition with other libraries using ggml
  if [ "$OS" = "Darwin" ]; then
    sed -i '' 's/GGML_/LM_GGML_/g' $file
    sed -i '' 's/ggml_/lm_ggml_/g' $file
    sed -i '' 's/GGUF_/LM_GGUF_/g' $file
    sed -i '' 's/gguf_/lm_gguf_/g' $file
    sed -i '' 's/GGMLMetalClass/LMGGMLMetalClass/g' $file
  else
    sed -i 's/GGML_/LM_GGML_/g' $file
    sed -i 's/ggml_/lm_ggml_/g' $file
    sed -i 's/GGUF_/LM_GGUF_/g' $file
    sed -i 's/gguf_/lm_gguf_/g' $file
    sed -i 's/GGMLMetalClass/LMGGMLMetalClass/g' $file
  fi
done

echo "😊 Replacement completed successfully!"

# Apply patch (can use `--verbose` to see log,can use `diff -u original_file modified_file > file.patch` to get patch file)
patch -p0 -d ../ios/Cpp < ../scripts/common.h.patch
echo "[Patch] common.h ✅ "
patch -p0 -d ../ios/Cpp < ../scripts/common.cpp.patch
echo "[Patch] common.cpp ✅ "
patch -p0 -d ../ios/Cpp < ../scripts/log.h.patch
echo "[Patch] log.h ✅ "
patch -p0 -d ../ios/Cpp < ../scripts/llama.cpp.patch
echo "[Patch] llama.cpp ✅ "
patch -p0 -d ../ios/Cpp < ../scripts/ggml-metal.m.patch
echo "[Patch] ggml-metal.m ✅ "
patch -p0 -d ../ios/Cpp < ../scripts/ggml.c.patch
echo "[Patch] ggml.c ✅ "
patch -p0 -d ../ios/Cpp < ../scripts/sgemm.cpp.patch
echo "[Patch] sgemm.cpp ✅ "
patch -p0 -d ../ios/Cpp < ../scripts/ggml-cpu-aarch64.c.patch
echo "[Patch] ggml-cpu-aarch64.c ✅ "
patch -p0 -d ../ios/Cpp < ../scripts/ggml-quants.c.patch
echo "[Patch] ggml-quants.c ✅ "
patch -p0 -d ../ios/Cpp < ../scripts/ggml-metal.metal.patch
echo "[Patch] ggml-metal.metal ✅ "
patch -p0 -d ../ios/Cpp < ../scripts/ggml-backend-reg.cpp.patch
echo "[Patch] ggml-backend-reg.cpp ✅ "
patch -p0 -d ../ios/Cpp < ../scripts/ggml-cpu.c.patch
echo "[Patch] ggml-cpu.c ✅ "
patch -p0 -d ../ios/Cpp < ../scripts/ggml-cpu.cpp.patch
echo "[Patch] ggml-cpu.cpp ✅ "
patch -p0 -d ../ios/Cpp < ../scripts/amx.cpp.patch
echo "[Patch] amx.cpp ✅ "
patch -p0 -d ../ios/Cpp < ../scripts/mmq.h.patch
echo "[Patch] mmq.h ✅ "

echo "😊 Apply patch successfully!"

if [ "$OS" = "Darwin" ]; then
  # Build metallib (~1.6MB)
  cd llama/ggml/src/ggml-metal
  xcrun --sdk iphoneos metal -c ggml-metal.metal -o ggml-metal.air
  xcrun --sdk iphoneos metallib ggml-metal.air   -o ggml-llama.metallib
  rm ggml-metal.air
  cp ./ggml-llama.metallib ../../../../../ios/Cpp/ggml-llama.metallib
  echo "😊 Build Metallib successfully!"
fi

cd ../../../../../cpp-file
if [ -e "llama" ];then
  rm -rf "llama"
  echo "😊 Clean temp[llama] successfully!"
fi

echo "➡️ ✅ All Done successfully!"

cd ../
# shellcheck disable=SC2034
current_time=$(date '+%Y-%m-%d %H:%M:%S')
sed -i '' "2c\\
# Update time: $current_time
" scripts/syncNative.sh