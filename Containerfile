ARG CORE_BRANCH=main
ARG SUFFIX=
ARG DESKTOP=nogui

FROM ghcr.io/commonarch/system-base${SUFFIX}-${DESKTOP}:${CORE_BRANCH}

ARG CORE_BRANCH=main
ARG VARIANT=general
ARG DESKTOP=nogui

# Changes to the base container image go here.

# IMPORTANT: Do NOT use `pacman -S` to install packages.
# Instead, use install-packages-build, as demonstrated in the following example:

# To include Chromium and Firefox
RUN install-packages-build chromium firefox

# More examples follow.

# To include and enable the Caddy web server
RUN install-packages-build caddy
RUN systemctl enable caddy

# To use TLP for power-saving on laptops (https://wiki.archlinux.org/title/TLP)
RUN install-packages-build tlp
RUN systemctl enable tlp
RUN systemctl mask systemd-rfkill.service systemd-rfkill.socket

COPY overlays/common overlay[s]/${DESKTOP} /
RUN rm -f /.gitkeep
RUN yes | pacman -Scc
