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

testapp_IP = 51.250.85.33

testapp_port = 9292

# Домашнее задание №6

 - Установил terraform
 - Создал файл .gitignore
 - Создал сервисный акк terraform
 - Создал кофнигу main.tf
 - Задал переменные через файлы
 - Создал балансировщик
 - Создал второй инстанс приложения
 - Задал масштабирование через count

Два разных инстанса приложения без синхронизации БД(mongodb), в случае падения одного инстанса приведут к потере консистенции данных.


# Домашнее задание №7

 - Создал сеть и подсеть
 - Пересобрал проект для паралельной сборки
 - Через packer собрал два образа app и bd
 - Добавил три модуля: app, db, vpc
 - Создал два окружения prod и stage
 - Создал бакет для хранения состояния
 - Добавил провижены к модулям
 - Создал шаблоны для запуска сервисов на серверах

## Бакеты и состония
Бакет создаем через storage-bucket.tf. В каждое окружение добавляем backend.tf, куда вносим параметры хранилища. Судя по доке, в этом файле нельзя использовать перменные.
Для того, чтобы хранилище заработало, нужно инициализировать:
```
terraform init
```

## Провижены
 По умолчанию провижены включены. Для этого используется средства инициализации ресурса и конструкция:
 ```
 resource "null_resource" "app" {
  count = var.enable_provision ? 1 : 0
  triggers = {
    cluster_instance_ids = yandex_compute_instance.app.id
  }
 ```

 Запуск с выключенным провиженом идет через команду (рещение подсмотрел у коллег):
 ```
 terraform apply -var='enable_provision=false'
 ```

 Так-же использованы шаблоны в  файлах для деплоя, т.к. они наполнять конфиги перед сборкой инстанса.

 ## Ошибки
 Хотя инстансы и поднялись, сервисы на них работают, коннекта к mongodb установить не удалось. Адрес монги пингуется

# Домашнее задание №8

 - Настроил ansible и окружение
 - Развернул stage
 - Создал инвентори
 - Создал ansible.cfg
 - Перевел инвентори в YAML
 - Проверил работоспособность ansible с различными типа команд
 - Создал ранбук и проверил


## Выполнение runbook
При выполнении ранбука, в случае наличия git-проекта, не меняет состояние каталогов (changed=0)
При выполнении ранбука, в случае отсутствия git-проекта, меняет состояние каталога (changed=1)


## Динамический JSON инвентори
Добавил скрипт на питоне - get_inventory.py
Данные берутся из команды
```
yc compute instances list --format json
```

Через библиотеку JSON парситься и собирается новый файл в соотвествии с докой Ansible.

Вывод скрипта можно проверить через:
```
./get_inventory.py --list
```

В ansible проверить через:
```
ansible all -i get_inventory.py -m ping
```

По умолчанию в файле cfg данный скрипт можно указать как источник инвентори:
```
inventory = ./get_inventory.py
```

# Домашнее задание №9

 - Запустил stage окружение без провиженов
 - ЧАстично изучил и попробовал шаблоны, хэндлеры, переменные
 - Использовал подход: один плэйбук - один сценарий
 - Использовал подход: один плэйбук - много сценариев
 - Использовал подход: много плэйбуков
 - Подключил плагин и настроил плагин yc_inventory
 - В образах пакера подключил плэйбуки в провиженах
 - Запустил плэйбуки и проверил доступность полученных инстансов

## Один плэйбук - один сценарий
Запустил создание инстансов для окружения stage без провиженов. Были созданы два инстанса app и db.

Создал playbook - reddit_app.yml. Добавил в .gitignore файлы *.retry

В сценарии reddit_app.yml описал команды для конфигурирования монги:
 - Указал шаблон для конфигурации монги, в которой проставил прослушивание внешнего сетевого интерфейса
 - Создал таску для копирования конфиги
 - К таскам написал хэндлеры перезапуска монги

В сценари reddit_app.yml описал команды для конфигурирования приклада:
 - Добавил таску добавления unit-файла
 - Добавил таску для автозагрузки puma
 - Добавил шаблон конфиги для puma и таску дял его копирование на хост
 - Добавил хэндлер для перезапуска puma

В шаблоне db_config.j2 указана переменная (ip монги). Переменную добавил в блоке vars:

```
vars:
    mongo_bind_ip: 0.0.0.0
    db_host: "{{ hostvars['dbserver']['ansible_host'][0] }}"
```


В сценарии reddit_app.yml добавил команды для деплоя нашего приложения:
 - В базовом образе уже есть гит, поэтому его установка нам не нужна
 - Добавил таски для скачивания из репозитория
 - Добавил таски для установки приложения через bundle

Таким образом при запуске плэйбука с нужными тэгами, можно конфигурировать наши инстансы и получить рабочее приложение.

Из минусов: можно запутаться на каком хосте, какие таски выполнять.

## Один плэйбук - много сценариев

Создадим новый файл reddit_app2.yml, куда скопируем двумя разными сценариями наши таски и хэндлеры.

Для монги создадим сценарий с именем *Configure mongodb*, для приклада *Config app* и *Deploy app*

Для каждой секции зададим свои тэги, переменные и хосты:
```
- name: Configure mongodb
  hosts: db
  tags: db-tag
  become: true
  vars:
    mongo_bind_ip: 0.0.0.0
---
- name: Config app
  hosts: app
  become: true
  tags: app-tag
  vars_files:
    - vars/env.yml
---
- name: Deploy app
  hosts: app
  become: true
  tags: deploy-tag
  vars_files:
    - vars/env.yml
```
Ip для подключения app к монге прокинул через файл vars/vars.yml. Подключение осуществил через vars_files. IP записывается в блоке db:
```
- name: Set variable to file with ip mongodb
      become: false
      local_action:
        module: copy
        content: "db_host: {{ hostvars['dbserver']['ansible_all_ipv4_addresses'][0] }}"
        dest: vars/env.yml
```

Запуск плэйбука осуществляется с со своими тегами:
```
$ ansible-playbook reddit_app2.yml --tags db-tag --check
$ ansible-playbook reddit_app2.yml --tags db-tag
---
$ ansible-playbook reddit_app2.yml --tags app-tag --check
$ ansible-playbook reddit_app2.yml --tags app-tag
---
$ ansible-playbook reddit_app2.yml --tags deploy-tag --check
$ ansible-playbook reddit_app2.yml --tags deploy-tag

```

Результатом стало сконфигурированное приложение на сервере

## Много плэйбуков
  - Переименовал оригинальные плэйбуки
  - Добавил новые плэйбуки для каждого вида задача: конфигурация монги, конфигурация и деплой приклада
  - Добавил плэйбук site.yml, куда включил все остальные плэйбуки, в порядке запуска

### Задание со *
  - Скачал скрипт в папку с плагинами ansible
  - Сконфигурировал запуск
  - Проверил работоспособность плагина

Скачал более старую версию файла, положил в директорию с плагинами ansible:
```
ansible-config dump | grep inventory
DEFAULT_INVENTORY_PLUGIN_PATH(default) = ['/home/daskain/.ansible/plugins/inventory', '/usr/share/ansible/plugins/inventory']
```

С превого раза не удалось запустить плагин. В коде нашел документацию, ее можно посмотреть через ansible-doc -t inventory yc_compute

Создал файл yc_compute.yml. Указад в нем тип авторизации (файл) и путь до файла. Через groups задал имена хостам.
В ansible cfg добавил подключение плагина и файла конфигурации:
```

[defaults]
inventory = ./yc_compute.yml
---
[inventory]
enable_plugins = yc_compute
```

Проверил работоспосбность плагина:
```
ansible-inventory --list
ansible -m ping
```

Работает, но плэйбуки не запускаются, т.к. переменные были получены через свой, кастомный динамический инвентори (другие имена переменных)


### Провижены в пакере

Добавил два файла packer_app.yml и packer_db.yml.
В конфигурациях подключил эти плэйбуки через:
```
"provisioners": [
        {
            "type": "ansible",
            "use_proxy": false,
            "playbook_file": "../ansible/packer_app.yml"
        }
    ]
...
"provisioners": [
        {
            "type": "ansible",
            "use_proxy": false,
            "playbook_file": "../ansible/packer_db.yml"
        }
    ]
```

Пересобрал образы, пересоздал инстансы, проверил плэйбуки - все работает. Процесс разворачинвания предельно простой. Осталось написать скрипт,
который сам развернет и поставит все на инстансах =)
