set URL="%1"
set LIB="%2"

curl.exe --output netlib.zip --url %URL% --retry 5 --retry-delay 5
unzip netlib.zip
dir .

@REM if "%LIB%"=="BLAS" (
@REM     cmake -G "NMake Makefiles" -DBUILD_SHARED_LIBS=ON -DCBLAS=ON -DCMAKE_Fortran_COMPILER=ifort -DCMAKE_C_COMPILER=icx
@REM )