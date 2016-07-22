#!/bin/sh

PKG="proxy-config"
GIT_URL="https://github.com/ujnzxw/proxy-config.git"
INSTALL_DIR="${INSTALL_DIR}"
[ -z "${APP_NAME}" ] && APP_NAME="set-proxy"


has()
{
    type "$1" > /dev/null 2>&1
}
confirm()
{
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure (default NO)? [y/N]} " response
    case $response in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
            ;;
    esac
}

install_echo()
{
    echo "[Install] $@"
}

install_from_git()
{
    [ -z "${INSTALL_DIR}" ] && INSTALL_DIR="/usr/local/${PKG}"
    if [ -e "${INSTALL_DIR}" ]; then
        install_echo "${PKG} Is already installed"
        install_echo "Updating ${PKG} from git"
        command git --git-dir="${INSTALL_DIR}/.git" --work-tree="${INSTALL_DIR}" fetch --depth=1 ||
        {
            install_echo >&2 "Failed to fetch changes => ${GIT_URL}"
            exit 1
        }
        command git --git-dir="${INSTALL_DIR}/.git" --work-tree="${INSTALL_DIR}" reset --hard origin/master ||
        {
            install_echo >&2 "Failed to reset changes => ${GIT_URL}"
            exit 1
        }
    else
        install_echo "Downloading ${PKG} from git to ${INSTALL_DIR}"
        command git clone --depth 1 ${GIT_URL} ${INSTALL_DIR} ||
        {
            install_echo >&2 "Failed to clone => ${GIT_URL}"
            exit 1
        }
        chmod -R 755 ${INSTALL_DIR}/lib  2>/dev/null
        chmod -R 755 ${INSTALL_DIR}/plugins 2>/dev/null
        chmod 755 ${INSTALL_DIR}/${APP_NAME} 2>/dev/null
        sudo ln -sf ${INSTALL_DIR}/${APP_NAME} /usr/local/bin/${APP_NAME}
    fi
}

if has "git"; then
    install_from_git;
else
    install_echo >&2 "Failed to install, please install git before."
fi

[ -z "${INSTALL_DIR}" ] && INSTALL_DIR="/usr/local/${PKG}"

if [ -f "${INSTALL_DIR}/m" ]; then
    install_echo ""
    install_echo "Done!"
else
    install_echo >&2 ""
    install_echo >&2 "Something went wrong. ${INSTALL_DIR}/u not found"
    install_echo >&2 ""
    exit 1
fi
