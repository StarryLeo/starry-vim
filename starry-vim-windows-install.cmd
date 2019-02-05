REM    Copyright 2014 Steve Francia
REM              2018 StarryLeo
REM
REM    Licensed under the Apache License, Version 2.0 (the "License");
REM    you may not use this file except in compliance with the License.
REM    You may obtain a copy of the License at
REM
REM        http://www.apache.org/licenses/LICENSE-2.0
REM
REM    Unless required by applicable law or agreed to in writing, software
REM    distributed under the License is distributed on an "AS IS" BASIS,
REM    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
REM    See the License for the specific language governing permissions and
REM    limitations under the License.


@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

@set APP_PATH=%HOME%\.starry-vim
IF NOT EXIST "%APP_PATH%" (
    call git clone -b 3.1 https://github.com/StarryLeo/starry-vim.git "%APP_PATH%"
) ELSE (
    @set ORIGINAL_DIR=%CD%
    echo updating starry-vim
    chdir /d "%APP_PATH%"
    call git pull
    chdir /d "%ORIGINAL_DIR%"
    call cd "%APP_PATH%"
)

call mklink "%HOME%\.vimrc" "%APP_PATH%\.vimrc"
call mklink "%HOME%\_vimrc" "%APP_PATH%\.vimrc"
call mklink "%HOME%\.vimrc.fork" "%APP_PATH%\.vimrc.fork"
call mklink "%HOME%\.vimrc.plugs" "%APP_PATH%\.vimrc.plugs"
call mklink "%HOME%\.vimrc.plugs.fork" "%APP_PATH%\.vimrc.plugs.fork"
call mklink "%HOME%\.vimrc.before" "%APP_PATH%\.vimrc.before"
call mklink "%HOME%\.vimrc.before.fork" "%APP_PATH%\.vimrc.before.fork"
call mklink /J "%HOME%\.vim" "%APP_PATH%\.vim"

IF NOT EXIST "%APP_PATH%\.vim\viplug" (
    call mkdir "%APP_PATH%\.vim\viplug"
)

IF NOT EXIST "%HOME%\.vim\autoload" (
    call git clone https://github.com/junegunn/vim-plug.git "%HOME%\.vim\autoload"
) ELSE (
  call cd "%HOME%\.vim\autoload"
  call git pull
  call cd %HOME%
)

call gvim -u "%APP_PATH%\.vimrc.plugs.default" +PlugClean! +PlugInstall +qall
