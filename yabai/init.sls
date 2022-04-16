yabai:
  pkg.installed

yabai-configs:
  file.managed:
    - name: {{ pillar['xdg_config_home'] }}/yabai/yabairc
    - source: salt:///yabai/yabairc
    - makedirs: true
    - user: {{ grains['user'] }}
    - force: true

yabai-scripts:
  file.recurse:
    - name: {{ grains['homedir'] }}/.local/bin
    - source: salt://yabai/scripts
    - file_mode: keep
    - user: {{ grains['user'] }}
    - force: true

yabai-service:
  cmd.run:
    - name: brew services restart yabai
    - runas: {{ grains['user'] }}
    - onchanges:
        - file: {{ pillar['xdg_config_home'] }}/yabai/yabairc
