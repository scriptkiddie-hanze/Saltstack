Create nagios config:
 cmd.script:
    - name: createNAGIOSconfig.sh
    - source: salt://scripts/createNAGIOSconfig.sh

Copy nagios config:
  module.run:
    - name: cp.push
    - path: /tmp/config.cfg
