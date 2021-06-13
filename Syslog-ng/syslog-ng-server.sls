install syslog-ng server:
  pkg.installed:
    - name: syslog-ng

deploy the server.conf file:
  file.managed:
    - name: /etc/syslog-ng/conf.d/server.conf
    - source: salt://syslog-ng/server.conf

reload syslog-ng server:
  service.running:
    - name: syslog-ng
    - enable: True
    - reload: True
    - require:
      - pkg: syslog-ng
