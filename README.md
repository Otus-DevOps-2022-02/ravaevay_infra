# ravaevay_infra
ravaevay Infra repository

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

  testapp_IP = 51.250.66.94
  testapp_port = 9292
