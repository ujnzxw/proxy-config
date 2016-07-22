## Proxy setting GNOME

Please set the proxy from GUI manually first.
(System Settings -> Network -> Network proxy)

If you want to change proxy by script, please
set the proxy setting files:
- /etc/environment  - reload file when reboot
- /etc/apt/apt.conf - apt used

## Installation

To **install** or **update** set-proxy you can run this command:

`INSTALL_DIR=$HOME/.proxy-config sh <(curl -fsSL https://raw.githubusercontent.com/ujnzxw/proxy-config/master/install.sh)`


_Note: You should reload your shell in both cases_

## Usage
```
Usage: set-proxy [OPTIONS] COMMAND [ none | manual | auto ]
    OPTIONS
        --update        # update proxy-config to the latest version
        --uninstall     # uninstall proxy-config
    COMMAND
        none
        man[ual]
        auto[matic]

    Examples:
        set-proxy   none   # set proxy mode - none
        set-proxy   man    # set proxy mode - manual
        set-proxy   auto   # set proxy mode - automatic
```


### License
Copyright (c) 2016 ujnzxw <zhaoxiaowei.txt@gmail.com>

Distributed under the MIT license. See the LICENSE file for more details.
