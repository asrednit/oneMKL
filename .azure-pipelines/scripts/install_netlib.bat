set VERSION=%1

set URL=https://codeload.github.com/Reference-LAPACK/lapack/zip/refs/tags/v%VERSION%
set UNPACKED_DIR="lapack-%VERSION%"
https://codeload.github.com/Reference-LAPACK/lapack/zip/refs/tags/v3.10.0
https://codeload.github.com/Reference-LAPACK/lapack/zip/refs/tags/v3.10.0
mkdir sandbox
cd sandbox
mkdir build

echo "curl.exe --output netlib.zip --url %URL% --retry 5 --retry-delay 5"
curl.exe --output netlib.zip --url %URL% --retry 5 --retry-delay 5
unzip -q netlib.zip
cd build

cmake -G "NMake Makefiles" -DBUILD_SHARED_LIBS=ON -DCBLAS=ON -DCMAKE_Fortran_COMPILER=ifort -DCMAKE_C_COMPILER=icl
 ../%UNPACKED_DIR%

cmake -G "NMake Makefiles" -DCMAKE_C_FLAGS="-DLAPACK_GLOBAL_PATTERN_UC" -DBUILD_SHARED_LIBS=ON -DBUILD_INDEX64=ON -DLAPACKE=ON -DCBLAS=ON -DCMAKE_Fortran_COMPILER=ifort -DCMAKE_C_COMPILER=icl -DCMAKE_Fortran_FLAGS=/integer-size:64
 ../%UNPACKED_DIR%

dir .
xcopy /s "%~dp0" "C:\netlib"