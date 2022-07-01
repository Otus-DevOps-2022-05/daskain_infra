# daskain_infra
daskain Infra repository
```console
$ cd ~/.ssh/
$ vi config
Host someinternalhost
    HostName 10.128.0.15
    ProxyCommand ssh -W %h:%p bastion
    User skutcher
    IdentityFIle ~/.ssh/skutcher
Host bastion
    HostName 51.250.65.172
    User skutcher
    IdentityFIle ~/.ssh/skutcher
$ ssh someinternalhost
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.4.0-117-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
Last login: Mon Jun 20 07:42:14 2022 from 10.128.0.19
skutcher@someinternalhost:~$
```

bastion_IP = 51.250.65.172

someinternalhost_IP = 10.128.0.15

Файл конфигурации для cloud-init: config.yaml

Команда запуска скрипта для создания инстанса и установки приложений:
```
$ ./startup.sh
```

testapp_IP = 51.250.89.67

testapp_port = 9292
