cmake . -B demo1
cmake . -B demo2 -DBUILD_SHARED_LIBS=ON
cmake . -B demo3 -DBUILD_SHARED_LIBS=OFF
cmake . -B demo4 -DBUILD_SHARED_LIBS=ON -DDEMO_BUILD_SHARED=ON
cmake . -B demo5 -DBUILD_SHARED_LIBS=ON -DDEMO_BUILD_SHARED=OFF
cmake . -B demo6 -DBUILD_SHARED_LIBS=OFF -DDEMO_BUILD_SHARED=ON
cmake . -B demo7 -DBUILD_SHARED_LIBS=OFF -DDEMO_BUILD_SHARED=OFF
cmake . -B demo8 -DDEMO_BUILD_SHARED=ON
cmake . -B demo9 -DDEMO_BUILD_SHARED=OFF