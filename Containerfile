ARG CORE_BRANCH=main
ARG SUFFIX=
ARG DESKTOP=nogui

FROM ghcr.io/commonarch/system-base${SUFFIX}-${DESKTOP}:main

ARG CORE_BRANCH=main
ARG VARIANT=general
ARG DESKTOP=nogui

# Changes to the base container image go here.

# IMPORTANT: Do NOT use `pacman -S` to install packages.
# Instead, use install-packages-build, as demonstrated in the following examples:

# To include Micro and Firefox
RUN install-packages-build micro firefox

# To include and enable the Caddy web server
RUN install-packages-build caddy; systemctl enable caddy

# To use TLP for power-saving on laptops (https://wiki.archlinux.org/title/TLP)
RUN install-packages-build tlp; \
    systemctl enable tlp; \
    systemctl mask systemd-rfkill.service systemd-rfkill.socket

COPY overlays/common overlay[s]/${DESKTOP} /
RUN rm -f /.gitkeep
RUN yes | pacman -Scc
