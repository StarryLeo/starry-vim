@PowerShell -ExecutionPolicy Bypass -Command Invoke-Expression $('$args=@(^&{$args} %*);'+[String]::Join(';',(Get-Content '%~f0') -notmatch '^^@PowerShell.*EOF$')) & goto :EOF

Push-Location ~

$app_name="starry-vim"
$app_path="$HOME\.starry-vim"
$repo_url="https://github.com/StarryLeo/starry-vim.git"
$repo_branch="dev"
$plug_url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

echo ""

if ((Get-Command "git" -ErrorAction SilentlyContinue) -eq $null) {
    echo "Can not find git in your PATH !!"
    pause
    exit
}

if ((Get-Command "gvim" -ErrorAction SilentlyContinue) -eq $null) {
    echo "Can not find gvim in your PATH !!"
    pause
    exit
}

echo ""

if (Test-Path "$app_path") {
    $update_mode="update"
} else {
    $update_mode=""
}

echo ""

if ("$update_mode" -eq "update") {
    echo "Trying to update $app_name..."
    Push-Location "$app_path"
    git pull origin "$repo_branch"
} else {
    echo "Trying to clone $app_name..."
    git clone -b "$repo_branch" "$repo_url" "$app_path"
}

echo ""

if (!(Test-Path "$HOME\.vimrc")) {
    cmd /c mklink "$HOME\.vimrc" "$app_path\.vimrc"
}

if (!(Test-Path "$HOME\_vimrc")) {
    cmd /c mklink "$HOME\_vimrc" "$app_path\.vimrc"
}

echo ""

if (!(Test-Path "$HOME\.starry")) {
    md ~\.starry
    Copy-Item -Path $app_path\init.vim -Destination $HOME\.starry\init.vim -Force
    echo "Successfully generate .starry in your HOME directory."
}

echo ""

if (!(Test-Path "$HOME\.vim\autoload")) {
    md ~\.vim\autoload
}
(New-Object Net.WebClient).DownloadFile("$plug_url", $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("~\.vim\autoload\plug.vim"))

echo ""

if ("$update_mode" -eq "update") {
    gvim "+set nomore" +PlugUpdate +qall
} else {
    gvim "+set nomore" +PlugInstall +qall
}

pause
