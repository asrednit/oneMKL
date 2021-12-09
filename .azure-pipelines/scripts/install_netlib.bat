set VERSION=%1

set URL=https://codeload.github.com/Reference-LAPACK/lapack/zip/refs/tags/v%VERSION%
set UNPACKED_DIR=lapack-%VERSION%

mkdir sandbox
cd sandbox

echo "curl.exe --output netlib.zip --url %URL% --retry 5 --retry-delay 5"
curl.exe --output netlib.zip --url %URL% --retry 5 --retry-delay 5
unzip -q netlib.zip
dir %UNPACKED_DIR%
cd build

call "C:\Program Files (x86)\Intel\oneAPI\setvars.bat"

mkdir build-blas
cd build-blas
echo "cmake -G "Ninja" -DBUILD_SHARED_LIBS=ON -DCBLAS=ON -DCMAKE_Fortran_COMPILER=ifort -DCMAKE_C_COMPILER=icl -DCMAKE_INSTALL_LIBDIR=C:/netlib/blas/lib -DCMAKE_INSTALL_INCLUDEDIR=C:/netlib/blas/include ../%UNPACKED_DIR%"
cmake -G "Ninja" -DBUILD_SHARED_LIBS=ON -DCBLAS=ON -DCMAKE_Fortran_COMPILER=ifort -DCMAKE_C_COMPILER=icl ../%UNPACKED_DIR%
cmake --build . -j
xcopy /s /e /i "lib" "C:\netlib\blas\lib"
xcopy /s /e /i "include" "C:\netlib\blas\include"

cd ..
mkdir build-lapack
cd build-lapack
echo "cmake -G "Ninja" -DCMAKE_C_FLAGS="-DLAPACK_GLOBAL_PATTERN_UC" -DBUILD_SHARED_LIBS=ON -DBUILD_INDEX64=ON -DLAPACKE=ON -DCBLAS=ON -DCMAKE_Fortran_COMPILER=ifort -DCMAKE_C_COMPILER=icl -DCMAKE_Fortran_FLAGS=/integer-size:64 -DCMAKE_INSTALL_LIBDIR=C:/netlib/lapack/lib -DCMAKE_INSTALL_INCLUDEDIR=C:/netlib/lapack/include ../%UNPACKED_DIR%"
cmake -G "Ninja" -DCMAKE_C_FLAGS="-DLAPACK_GLOBAL_PATTERN_UC" -DBUILD_SHARED_LIBS=ON -DBUILD_INDEX64=ON -DLAPACKE=ON -DCBLAS=ON -DCMAKE_Fortran_COMPILER=ifort -DCMAKE_C_COMPILER=icl -DCMAKE_Fortran_FLAGS=/integer-size:64 ../%UNPACKED_DIR%
cmake --build . -j
xcopy /s /e /i "lib" "C:\netlib\lapack\lib"
xcopy /s /e /i "include" "C:\netlib\lapack\include"