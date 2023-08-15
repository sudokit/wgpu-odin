@echo off
setlocal

set ARGS=
set OUT=-out:.\build

if "%1" == "" (
    call :all & goto :end
)

if "%1" == "info" (
    call :info & goto :end
)

if "%1" == "triangle" (
    call :triangle & goto :end
)

if "%1" == "simple_compute" (
    call :simple_compute & goto :end
)

if "%1" == "learn_wgpu" (
    call :learn_wgpu & goto :end
)

echo Example not recognized.
goto :end

:all
call :info
call :triangle
call :simple_compute
call :learn_wgpu
goto :eof

:info
odin build .\info %ARGS% %OUT%\info.exe
goto :eof

:triangle
odin build .\triangle %ARGS% %OUT%\triangle.exe
goto :eof

:simple_compute
odin build .\simple_compute %ARGS% %OUT%\simple_compute.exe
goto :eof

:learn_wgpu
odin build .\learn_wgpu\beginner\tutorial1_window %ARGS% %OUT%/tutorial1_window.exe
odin build .\learn_wgpu\beginner\tutorial2_surface %ARGS% %OUT%/tutorial2_surface.exe
odin build .\learn_wgpu\beginner\tutorial2_surface_challenge %ARGS% %OUT%/tutorial2_surface_challenge.exe
odin build .\learn_wgpu\beginner\tutorial3_pipeline %ARGS% %OUT%/tutorial3_pipeline.exe
odin build .\learn_wgpu\beginner\tutorial3_pipeline_challenge %ARGS% %OUT%/tutorial3_pipeline_challenge.exe
odin build .\learn_wgpu\beginner\tutorial4_buffer %ARGS% %OUT%/tutorial4_buffer.exe
odin build .\learn_wgpu\beginner\tutorial4_buffer_challenge %ARGS% %OUT%/tutorial4_buffer_challenge.exe
goto :eof

:end
endlocal
