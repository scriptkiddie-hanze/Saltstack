install syslog-ng:
 pkg.installed:
   - name: syslog-ng

deploy the syslog-ng.conf file:
 file.managed:
   - name: /etc/syslog-ng/syslog-ng.conf
   - source: salt://syslog-ng/syslog-ng.conf