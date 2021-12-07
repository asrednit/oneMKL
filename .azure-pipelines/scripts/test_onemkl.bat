mkdir build
cd build

call "C:\Program Files (x86)\Intel\oneAPI\setvars.bat"

echo "Configuring..."
cmake -G "Ninja" -DBUILD_SHARED_LIBS=False -DENABLE_MKLCPU_BACKEND=True -DENABLE_MKLGPU_BACKEND=False -DENABLE_NETLIB_BACKEND=False -DENABLE_CUBLAS_BACKEND=False -DENABLE_CURAND_BACKEND=False -DCMAKE_VERBOSE_MAKEFILE=True -DBUILD_FUNCTIONAL_TESTS=True -DCMAKE_MAKE_PROGRAM=ninja -DREF_BLAS_ROOT=C:/netlib/blas -DTARGET_DOMAINS=blas ..
echo "Building..."
cmake --build . --parallel 4 --target all
echo "Testing..."
ctest -j1 --output-on-failure