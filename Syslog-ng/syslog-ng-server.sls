install syslog-ng server:
  pkg.installed:
    - name: syslog-ng

deploy the server.conf file:
  file.managed:
    - name: /etc/syslog-ng/conf.d/server.conf
    - source: salt://syslog-ng/server.conf

reload syslog-ng server:
  cmd.run:
    - name: systemctl restart syslog-ng
