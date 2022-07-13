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
```terraform init
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
