# ravaevay_infra
ravaevay Infra repository

Задание №11

 - Установлен Vagrant и провайдер vmware_esxi (поскольку задания выполняются на VM и хотелось попробовать провайдера более приближенного к прод среде). Обкатан процесс создания VM и применнения сценариев ansible. В конфигурацию Vagrantfile добавлена extar_vars для настройки Nginx на 80 порту.
 - Протестирована связка Molecule c провайдером vmware:
      molecule init -r db -d vmware default


Задание №10

- Изменена структура каталога ansible. Добавлены каталоги roles, playbooks. Файлы разнесены по каталогам.
- Добавлена структура окружений - stage и prod. Разнесены inventory файла и переменные окружений.
- добавлена роль nginx из Ansible Galaxy. Проверена работоспособность сервиса через nginx по 80 порту.
- добавлены юзера с использованием механизма Ansible Vault

Задание №9

- протестированы сценарии c
    - одним плейбуком, одним сценарием
    - одним плейбуком, несколькими сценариями
- в плейбуках были использованы handlers и tags, modules
- рассмотрен вариант с несколькми плейбуками
- были пересобраны базовые образы для db и app при использовании связки Packer + Ansible.


Задание №8

- установален Ansible
- создан файл ansible.cfg (внесены параметры подключения к хостам)
- созданы файлы inventory и inventory.yml
- выполнены простейшие команды на хостах, перечисленных в inventory
- написан playbook для git. При повторном выполнении не выолняется повторное копирование папки.

Задание №7 - Terraform-2

Созданы файлы app.json db.json для создания образов.
Поработал с модулями. Выделил два модуля для создания инстанса с приложением и инстанса с бд.
Вынес .tfstate файл в s3, поработал с Terraform из разных директорий. Посмотрел на работу блокировок.
Вынес ip адрес db инстанса в переменную и передал в модуль app.

database_url     = module.db.external_ip_address_db

Пробовал передать в переменную окружения DATABASE_URL, но видимо что-то не так делаю) Сервис упорно не видит эту переменную)

provisioner "remote-exec" {
    inline = [
     "export DATABASE_URL=mongod://${var.database_url}:27017"

     ]

Задание №6 - Terraform

Выполнены все задания. Созданы файлы .tf для создания VM с балансировщиком, под приложение Reddit-Monolith
Частично были сипользованы переменные из terraform.tfvars и variables.tf.

Был использован механизм count для создания n-кол-ва копий инстансов.
Балансировщик - yandex_lb_network_load_balancer и yandex_lb_target_group




Задание №1 и №2 - Подключение к someinternalhost в одну комманду и подключение коммандой ssh someinternalhost c локальной машины.
  Начнем со второго задания. Для сквозного подключения к внутренней машине someinternalhost через bastion, воспользуемся методом
  SSH std i/o forwarding.

  Для этого создадим файл конфиг ~/.ssh/config следующего вида:
    Host bastion
	  Hostname 178.154.240.176
	  User appuser
	  IdentityFile ~/.ssh/appuser

    Host someinternalhost
	  Hostname 10.128.0.20
	  User appuser
	  IdentityFile ~/.ssh/appuser
	  ProxyCommand ssh -W %h:%p bastion

    Теперь мы можем подключаться c нашей локальной машины к удаленной VM someinternalhost простой коммандой ssh someinternalhost.

    Осталось добавить алиас в файл ~/.bashrc вида
       alias someinternalhost='ssh someinternalhost'

    Вуаля. Можем подключаться набрав ssh someinternalhost и просто набрав someinternalhost.

  Задание №3.
   Для установки Pritunl сделал upgrade Ubuntu до версии 20.04 и воспользовался официальной документацией по установке для Ubuntu.
   Подправил setupvpn.sh для версии 20.04

   Доступ к админке Pritunl:
      https://178.154.252.90.sslip.io  - привязал Let's Encrypt сертификат.

    bastion_IP = 178.154.252.90
    someinternalhost_IP = 10.128.0.20

    OVPN: user - test
          pin -  6214157507237678334670591556762

Задание №4
  Созданы скрипты:
   - install_ruby.sh
   - install_mongodb.sh
   - deploy.sh
  Cоздан yaml файл для сloud-init
   - startup.yaml

  Команда создания инстанса reddit-app
    yc compute instance create   --name reddit-app   --hostname reddit-app   --memory=4   --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB   --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4   --metadata serial-port-enable=1 --metadata-from-file user-data=./startup.yaml


Задание №5
  1) Создан файл variables.json.example с параметрами для использования в файле ubuntu16.json и immutable.json
  2) Cоздан immutable.json для создание bake-образа готового приложения.
  3) Создан скрипт создания VM из образа reddit-full - /config-scripts/create-reddit-vm.sh

  reddit-app_IP = 51.250.73.227
  reddit-app_port = 9292
