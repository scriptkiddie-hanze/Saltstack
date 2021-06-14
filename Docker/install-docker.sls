Install all needed packages to run Docker server:
  pkg.installed:
  - pkgs:
    - docker.io
  - skip_suggestions: true

Enable docker:
  cmd.run:
    - name: systemctl enable --now docker

Create storage volume for container use:
  cmd.run:
    - name: docker volume create --name container-storage

Create NTP container:
  cmd.run:
    - name: docker run --name=ntp --restart=always --detach --publish=123:123/udp cturra/ntp
