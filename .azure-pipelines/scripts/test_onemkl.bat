set DOMAIN=%1

mkdir build-%DOMAIN%
cd build-%DOMAIN%

call "C:\Program Files (x86)\Intel\oneAPI\setvars.bat"

set DOMAIN_SPECIFIC_OPTIONS=

if "%DOMAIN%"=="blas" (
    set DOMAIN_SPECIFIC_OPTIONS=-DREF_BLAS_ROOT=C:/netlib/blas
)

if "%DOMAIN%"=="lapack" (
    set DOMAIN_SPECIFIC_OPTIONS=-DREF_LAPACK_ROOT=C:/netlib/lapack
)

echo "Configuring..."
cmake -G "Ninja" -DBUILD_SHARED_LIBS=True -DENABLE_MKLCPU_BACKEND=True -DENABLE_MKLGPU_BACKEND=False -DENABLE_NETLIB_BACKEND=False -DENABLE_CUBLAS_BACKEND=False -DENABLE_CURAND_BACKEND=False -DCMAKE_VERBOSE_MAKEFILE=True -DBUILD_FUNCTIONAL_TESTS=True -DCMAKE_MAKE_PROGRAM=ninja -DTARGET_DOMAINS=%DOMAIN% %DOMAIN_SPECIFIC_OPTIONS% ..
echo "Building..."
cmake --build . --parallel 4 --target all
echo "Testing..."
ctest -j1 --output-on-failure