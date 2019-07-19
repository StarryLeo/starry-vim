@PowerShell -ExecutionPolicy Bypass -Command Invoke-Expression $('$args=@(^&{$args} %*);'+[String]::Join(';',(Get-Content '%~f0') -notmatch '^^@PowerShell.*EOF$')) & goto :EOF

Push-Location ~

$app_name="starry-vim"
$app_path="$HOME\.starry-vim"
$repo_url="https://github.com/StarryLeo/starry-vim.git"
$repo_branch="master"
$plug_url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

echo ""

if ((Get-Command "git" -ErrorAction SilentlyContinue) -eq $null)
{
    echo "Can not find git in your PATH !!"
    pause
    exit
}

if ((Get-Command "gvim" -ErrorAction SilentlyContinue) -eq $null)
{
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

cmd /c mklink "$HOME\.vimrc" "$app_path\.vimrc"

if (!(Test-Path "$HOME\.starry"))
{
    Copy-Item -Path $app_path\init.starry -Destination $HOME\.starry -Force
    echo "Successfully generate .starry in your HOME directory."
}

echo ""

if (!(Test-Path "$HOME\.vim\autoload"))
{
    md ~\.vim\autoload
}
(New-Object Net.WebClient).DownloadFile("$plug_url", $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("~\.vim\autoload\plug.vim"))

echo ""

if ("$update_mode" -eq "update") {
    gvim +PlugClean! +PlugUpdate +qall
} else {
    gvim +PlugClean! +PlugInstall +qall
}
