# Ephemeral Google Chrome for testing
FROM debian:jessie
MAINTAINER Max Milton <max@wearegenki.com>

# Install Chrome + Xorg
ADD https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb /src/google-chrome-stable_current_amd64.deb
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        fonts-liberation \
        gconf-service \
        hicolor-icon-theme \
        libappindicator1 \
        libasound2 \
        libcanberra-gtk-module \
        libcurl3 \
        libexif-dev \
        libgconf-2-4 \
        libgl1-mesa-dri \
        libgl1-mesa-glx \
        libnspr4 \
        libnss3 \
        libpango1.0-0 \
        libv4l-0 \
        libxss1 \
        libxtst6 \
        wget \
        xdg-utils \
    && dpkg -i '/src/google-chrome-stable_current_amd64.deb' \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /src/*

# Harden system by unsetting SUID on all programs other than chrome's sandbox
RUN for i in `find / -perm +6000 -type f`; do chmod a-s $i; done \
    && chown root:root /opt/google/chrome/chrome-sandbox \
    && chmod 4755 /opt/google/chrome/chrome-sandbox

RUN groupadd -r chrome && useradd -m -g chrome chrome

USER chrome

ENTRYPOINT [ "/usr/bin/google-chrome-stable" ]
# Chrome wont start unless setuid sandbox is disabled
CMD [ "--disable-setuid-sandbox", "--disable-extensions", "--disable-bundled-ppapi-flash", "--no-first-run" ]

# README: To run the image see the launch script:
# https://github.com/MaxMilton/Ephemeral-Google-Chrome/blob/master/launch-chrome.docker.sh
