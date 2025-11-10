#!/bin/bash

# 错误则终止构建
set -e
# 读取用户传入的版本参数
INSTALL_PATH="${PYTHON_PATH:-"/usr/local/python/current/bin"}"
INSTALL_METHOD="${install_method:-"pip"}"

if [[ "${INSTALL_METHOD}" = "pip" ]]; then
    # 读取 PYthon 解释器路径
    PYTHON_SRC="${INSTALL_PATH}/bin/python3"
    if ! type pip >/dev/null 2>&1 && type pip3 >/dev/null 2>&1; then
        ln -s /usr/bin/pip3 /usr/bin/pip
    else
        PYTHON_SRC=$(which python)
    fi

    # 安装 mosek，通过pip
    if [[ -n "${PYTHON_SRC}" ]]; then
        # 安装 mosek 
        # [[ "$INSTALL_PIP" = "true" ]] && {
            echo 'Installing mosek...'
            ${PYTHON_SRC} -m pip install mosek --no-warn-script-location
            ${PYTHON_SRC} -m pip cache purge  # 清理 pip 缓存
        # }
    else
        echo "Without python interpreter "
    fi
fi



