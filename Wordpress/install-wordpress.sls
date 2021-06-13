sudo apt install -y software-properties-common:
  cmd.run

apt update:
  cmd.run

Install al needed packages to run Wordpress:
  pkg.installed:
    - pkgs:
      - nginx
      - nginx-common
      - nginx-full
      - mariadb-server
      - mariadb-client
      - python-mysqldb
      - python-pip
      - php7.2-fpm
      - php7.2-mysql
    - skip_suggestions: true


Create database for Wordpress:
  mysql_database.present:
    - name: wordpress

  mysql_user.present:
    - name: wordpress
    - password: p4ssw0rd

  mysql_grants.present:
    - database: wordpress.*
    - grant: ALL PRIVILEGES
    - user: wordpress
    - host: 'localhost'


Download and unpack/install Wordpress:
  cmd.run:
    - name: 'wget -q -O - http://wordpress.org/latest.tar.gz | tar zxf - '
    - cwd: /var/www
    - creates: /var/www/html/wordpress.com/index.php
    - runas: root

/var/www/wordpress/wp-config.php:
  file.managed:
    - source: salt://wordpress/wp-config.php
    - user: www-data
    - group: www-data

/var/www/wordpress:
  file.directory:
    - user: www-data
    - group: www-data
    - dir_mode: 775
    - file_mode: 664
    - recurse:
      - user
      - group
      - mode

/etc/nginx/sites-available/default:
  file.managed:
    - source: salt://wordpress/default-nginx-conf
    - user: root
    - mode: 644

reload nginx:
  service.running:
    - name: nginx
    - enable: True
    - restart: True