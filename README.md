Создан новый аккаунт AWS/
Развернут Prometheus + node-exporter (https://hub.docker.com/r/prom/node-exporter/tags)
Созданы 2 сети.
Инстанс поднят на ubuntu 18.04 в приватной сети.
Добавлена корзина test-bucket с рандомным окончанием.
Развернут докер через user_data. Также закоментил разворачивание через Ansible при наличии статического IP.
Возможно разворачивать в частной сети, но тогда надо создавать бастион или пробовать через прокси.
output не добавлял.
