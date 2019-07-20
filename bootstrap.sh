#!/bin/bash
#
# 2019/07/18    StarryLeo

############################  SETUP PARAMETERS
app_name='starry-vim'
app_path="$HOME/.starry-vim"
repo_url='https://github.com/StarryLeo/starry-vim.git'
repo_branch='master'
plug_url='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

debug_mode='0'
fork_maintainer='0'
backup_dir="$HOME/.cache/.starry-vim_backup"
backup_time_s='5184000'
backup_time_v='20736000'

############################  BASIC SETUP TOOLS
red="\33[31m"
green="\33[32m"
blue="\33[34m"
none="\33[0m"

msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
        msg "${green}[✔]${none} ${1}${2}"
    fi
}

error() {
    msg "${red}[✘]${none} ${1}${2}"
    exit 1
}

debug() {
    if [ "$debug_mode" -eq '1' ] && [ "$ret" -gt '1' ]; then
        msg "An error occurred in function \"${red}${FUNCNAME[$i+1]}${none}\" on line ${red}${BASH_LINENO[$i+1]}${none}, we're sorry for that."
    fi
}

program_exists() {
    local ret='0'
    command -v $1 >/dev/null 2>&1 || { local ret='1'; }

    # fail on non-zero return value
    if [ "$ret" -ne 0 ]; then
        return 1
    fi

    return 0
}

program_must_exist() {
    program_exists $1

    # throw error on non-zero return value
    if [ "$?" -ne 0 ]; then
        error "You must have '${red}${1}${none}' installed to continue."
    fi
}

variable_set() {
    if [ -z "$1" ]; then
        error "You must have your ${red}HOME${none} environmental variable set to continue."
    fi
}

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
    ret="$?"
    debug
}

successful() {
    if [ "$ret" -eq '0' ]; then
        msg "${green}${1}${2}${none} "
    fi
}

check_update() {
    if [ -e "$1" ]; then
        update_mode="update"
    else
        update_mode=""
    fi
}

############################ SETUP FUNCTIONS

do_backup() {
    if [ -e "$1" ] || [ -e "$2" ] || [ -e "$3" ]; then
        today=`date +%Y%m%d_%s`
        if [ "${update_mode}" = "update" ]; then
            today_s=`echo ${today##*_}`
            if [ -f "$7" ]; then
                last_update=`sed -n '$p' $7`
                last_update_day_s=`echo ${last_update##*_}`
                time_u=`expr $today_s - $last_update_day_s`
                msg "Last update $4 was ${green}${time_u}${none} seconds ago."
                if [ -e "$6" ]; then
                    for filename in `ls -a $6`
                    do
                        last_backup=`echo $filename`
                    done
                    last_backup_day_s=`echo ${last_backup##*_}`
                    time_b=`expr $today_s - $last_backup_day_s`
                    if [ "$time_b" -gt "$8" ]; then
                        msg "Last backup $4 was ${green}${time_b}${none} seconds ago."
                        msg "Starting backup $4..."
                        echo "update_backup_$today" >> "$7"
                        cp -a "$5" "$6/.$4.$today"
                        cp -a "$1" "$6/.$4.vim.$today"
                        ret="$?"
                        success "$4 has been backed up."
                    elif [ "$time_b" -gt "$9" ]; then
                        msg "Last backup $4 was ${green}${time_b}${none} seconds ago."
                        msg "Starting backup $4..."
                        echo "update_backup_$today" >> "$7"
                        cp -a "$5" "$6/.$4.$today"
                        ret="$?"
                        success "$4 has been backed up."
                    else
                        echo "update_$today" >> "$7"
                    fi
                fi
            else
                msg "Starting backup $4..."
                if [ ! -e "$6" ]; then
                    mkdir -p "$6"
                fi
                if [ ! -e "$6/.history" ]; then
                    mkdir -p "$6/.history"
                fi
                touch "$6/.history/update.history"
                echo "update_backup_$today" >> "$7"
                cp -a "$5" "$6/.$4.$today"
                ret="$?"
                success "$4 has been backed up."
            fi
        else
            msg "Attempting to back up your original vim configuration."
            msg "Starting backup..."
            for i in "$1" "$2" "$3"; do
                    [ -e "$i" ] && [ ! -L "$i" ] && mv -v "$i" "$i.$today";
            done
            echo ""
            ret="$?"
            success "Your original vim configuration has been backed up."
        fi
    else
        msg "Do not need to back up your original vim configuration."
    fi

    debug
}

sync_repo() {
    local repo_path="$1"
    local repo_url="$2"
    local repo_branch="$3"
    local repo_name="$4"

    if [ ! -e "$repo_path" ]; then
        msg "Trying to clone $repo_name..."
        mkdir -p "$repo_path"
        git clone -b "$repo_branch" "$repo_url" "$repo_path"
        ret="$?"
        success "Successfully cloned $repo_name."
    else
        msg "Trying to update $repo_name..."
        cd "$repo_path" && git pull origin "$repo_branch"
        ret="$?"
        success "Successfully updated $repo_name."
    fi

    debug
}

create_symlinks() {
    local source_path="$1"
    local target_path="$2"

    if [ ! -e "$2/.vim" ]; then
        mkdir -p "$2/.vim"
    fi

    lnif "$source_path/.vimrc"         "$target_path/.vimrc"

    if program_exists "nvim"; then
        today=`date +%Y%m%d_%s`
        for i in "$2/.config/nvim" "$2/.config/nvim/init.vim"; do
                [ -e "$i" ] && [ ! -L "$i" ] && mv -v "$i" "$i.$today";
        done
        lnif "$2/.vim"                 "$target_path/.config/nvim"
        lnif "$source_path/.vimrc"     "$target_path/.config/nvim/init.vim"
        [ -L "$2/.vim/.vim" ] && rm "$2/.vim/.vim"
    fi

    ret="$?"
    success "Setting up vim symlinks."
    debug
}

generate_dot_starry() {
    if [ ! -e "$1" ]; then
        mkdir -p "$1"
        cp "$2" "$1/init.vim"

        touch "$1/config.vim"
        touch "$1/packages.vim"
        touch "$1/README.md"

        ret="$?"
        success "Successfully generate .starry in your HOME directory."
    elif [ ! -f "$1/init.vim" ]; then
        cp "$2" "$1/init.vim"

        ret="$?"
        success "Successfully generate .starry/init.vim in your HOME directory."
    fi

    debug
}

setup_fork_mode() {
    if [ "$1" -eq '1' ]; then
        if [ ! -e "$2/fork" ]; then
            mkdir -p "$2/fork"

            touch "$2/fork/config.vim"
            touch "$2/fork/packages.vim"
            touch "$2/fork/README.md"

            ret="$?"
            success "Created fork maintainer files."
            debug
        fi
    fi
}

setup_plug() {
    local system_shell="$SHELL"
    export SHELL='/bin/sh'

    if [ "${update_mode}" = "update" ]; then
        msg "Starting updating plugins..."

        vim \
            "+set nomore" \
            "+PlugUpdate" \
            "+qall"

        export SHELL="$system_shell"

        ret="$?"
        success "Now updating plugins using vim-plug."
    else
        msg "Starting installing plugins..."

        vim \
            "+set nomore" \
            "+PlugInstall" \
            "+qall"

        export SHELL="$system_shell"

        ret="$?"
        success "Now installing plugins using vim-plug."
    fi

    debug
}

install_vim_plug() {

    curl -fLo "$1/plug.vim" --create-dirs "$2"

    if [ "${update_mode}" = "update" ]; then
        ret="$?"
        success "Successfully updated vim-plug for starry-vim."
    else
        ret="$?"
        success "Successfully installed vim-plug for starry-vim."
    fi

    debug
}

setup_json() {
    local answer="n"

    if [ "${update_mode}" = "update" ]; then
        printf "\rUpdate the default ${green}coc-settings.json${none} and ${green}lcn-settings.json${none}?\n"
        for (( i=10; i>=0; i-- )); do
            printf "\r[${green}y${none}(es)/${green}n${none}(o), default: ${red}n${none}]( ${red}${i}${none}s ): "
            read -n 1 -t 1 answer
            if [ "$?" -eq 0 ]; then
                break
            fi
        done
        if [[ "$answer" =~ ^[yY]$ ]]; then
            msg "\nBackup the default coc-settings.json and lcn-settings.json."
            mv -v "$1/coc-settings.json" "$1/coc-settings.json.bak"
            mv -v "$1/lcn-settings.json" "$1/lcn-settings.json.bak"
            curl -fLo "$1/coc-settings.json" --create-dirs https://raw.githubusercontent.com/StarryLeo/dotfiles/master/.vim/coc-settings.json
            curl -fLo "$1/lcn-settings.json" --create-dirs https://raw.githubusercontent.com/StarryLeo/dotfiles/master/.vim/lcn-settings.json
            ret="$?"
            success "Successfully updated the default coc-settings.json and lcn-settings.json."
        else
            msg "\nThe default coc-settings.json and lcn-settings.json will not update."
        fi
    else
        curl -fLo "$1/coc-settings.json" --create-dirs https://raw.githubusercontent.com/StarryLeo/dotfiles/master/.vim/coc-settings.json
        curl -fLo "$1/lcn-settings.json" --create-dirs https://raw.githubusercontent.com/StarryLeo/dotfiles/master/.vim/lcn-settings.json
        ret="$?"
        success "Successfully setup default coc-settings.json and lcn-settings.json."
    fi

    debug
}

############################ MAIN()
variable_set "$HOME"
program_must_exist "vim"
program_must_exist "git"
program_must_exist "curl"

check_update        "$app_path"

do_backup           "$HOME/.vim" \
                    "$HOME/.vimrc" \
                    "$HOME/.gvimrc" \
                    "$app_name" \
                    "$app_path" \
                    "$backup_dir" \
                    "$backup_dir/.history/update.history" \
                    "$backup_time_v" \
                    "$backup_time_s"

sync_repo           "$app_path" \
                    "$repo_url" \
                    "$repo_branch" \
                    "$app_name"

create_symlinks     "$app_path" \
                    "$HOME"

generate_dot_starry "$HOME/.starry" \
                    "$app_path/init.vim"

setup_fork_mode     "$fork_maintainer" \
                    "$app_path"

install_vim_plug    "$HOME/.vim/autoload" \
                    "$plug_url"

setup_plug

setup_json          "$HOME/.vim"

ret="$?"
successful "       _                                          _            "
successful "  ___ | |_  __ _  _ __  _ __  _   _       __   __(_) _ __ ___  "
successful " / __|| __|/ _\` || '__|| '__|| | | | _____\ \ / /| || '_ \` _ \ "
successful " \__ \| |_| (_| || |   | |   | |_| ||_____|\ V / | || | | | | |"
successful " |___/ \__|\__,_||_|   |_|    \__, |        \_/  |_||_| |_| |_|"
successful "                              |___/                            "
successful ""
if [ "${update_mode}" = "update" ]; then
successful "...is now updated!"
else
successful "...is now installed!"
fi
successful ""
msg "${blue}Thanks for installing $app_name.${none}"
msg "${blue}© `date +%Y` https://github.com/StarryLeo/starry-vim${none}"
debug
