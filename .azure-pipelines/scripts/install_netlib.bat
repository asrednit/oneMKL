set LIB="%1"

if "%LIB%"=="BLAS" (
    cmake -G "NMake Makefiles" -DBUILD_SHARED_LIBS=ON -DCBLAS=ON -DCMAKE_Fortran_COMPILER=ifort -DCMAKE_C_COMPILER=icx
)