Install al needed packages to run Nagios server:
  pkg.installed:
  - pkgs:
    - apache2
    - php
    - autoconf
    - gcc
    - make
    - unzip
    - libgd-dev
    - libmcrypt-dev
    - dc
    - snmp
    - libnet-snmp-perl
    - gettext
  - skip_suggestions: true

Download nagios and unzip download:
  cmd.run:
    - cwd: /tmp
    - names:
      - curl -L -O https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.4.tar.gz
      - tar zxf nagios-4.4.4.tar.gz

Install nagios server:
  cmd.run:
    - cwd: /tmp/nagioscore-nagios-4.4.4/
    - names:
      - ./configure --with-httpd-conf=/etc/apache2/sites-enabled
      - make all
      - make install-groups-users
      - make install
      - make install-daemoninit
      - make install-commandmode
      - make install-config
      - make install-webconf
      - a2enmod rewrite
      - a2enmod cgi
      - usermod -a -G nagios www-data

Setup username and password for nagios interface:
  file.managed:
    - name: /usr/local/nagios/etc/htpasswd.users
    - source: salt://nagios/htpasswd.users

Reload apache2 for nagios:
  service.running:
    - name: apache2
    - enable: True
    - reload: True

Download nagios plugin and unzip download:
  cmd.run:
    - cwd: /tmp
    - names:
      - curl -L -O https://nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz
      - tar zxf nagios-plugins-2.2.1.tar.gz

Configure nagios plugin for nagios server:
  cmd.run:
    - cwd: /tmp/nagios-plugins-2.2.1/
    - names:
      - ./configure
      - make
      - make install

Configure /usr/local/nagios/etc/nagios.cfg:
  file.managed:
    - name: /usr/local/nagios/etc/nagios.cfg
    - source: salt://nagios/nagios.cfg 

Configure /usr/local/nagios/etc/objects/contacts.cfg:
  file.managed:
    - name: /usr/local/nagios/etc/objects/contacts.cfg
    - source: salt://nagios/contacts.cfg

Configure /usr/local/nagios/etc/objects/commands.cfg:
  file.managed:
    - name: /usr/local/nagios/etc/objects/commands.cfg
    - source: salt://nagios/commands.cfg

Create directory to store configurations:
  cmd.run:
    - name: mkdir /usr/local/nagios/etc/servers

Reload nagios for nagios:
  service.running:
    - name: nagios
    - enable: True
    - reload: True