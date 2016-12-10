# Google Chrome image for manual web testing
#
# README: Run using the launch script:
#   https://github.com/MaxMilton/Ephemeral-Google-Chrome/blob/master/launch-chrome.docker.sh

FROM debian:sid-slim
MAINTAINER Max Milton <max@wearegenki.com>

# Install Chrome + Xorg
RUN set -xe \
	&& buildDeps=" \
		curl \
	" \
	&& addgroup --system --gid 6006 chrome \
	&& adduser --system --home /home/chrome --shell /sbin/nologin --uid 6006 --ingroup chrome --disabled-password chrome \
	&& mkdir -p /usr/share/icons/hicolor \
	&& apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
		ca-certificates \
		fonts-liberation \
		gconf-service \
		libappindicator1 \
		libasound2 \
		libatk1.0-0 \
		libc6 \
		libcairo2 \
		libcups2 \
		libdbus-1-3 \
		libexpat1 \
		libfontconfig1 \
		libfreetype6 \
		libgcc1 \
		libgconf-2-4 \
		libgdk-pixbuf2.0-0 \
		libgl1-mesa-dri \
		libgl1-mesa-glx \
		libglib2.0-0 \
		libgtk2.0-0 \
		libnspr4 \
		libnss3 \
		libpango1.0-0 \
		libstdc++6 \
		libx11-6 \
		libx11-xcb1 \
		libxcb1 \
		libxcomposite1 \
		libxcursor1 \
		libxdamage1 \
		libxext6 \
		libxfixes3 \
		libxi6 \
		libxrandr2 \
		libxrender1 \
		libxss1 \
		libxtst6 \
		lsb-base \
		wget \
		xdg-utils \
	&& apt-get install --no-install-recommends --no-install-suggests -y $buildDeps \
	&& curl -fSL https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o google-chrome.deb \
	&& dpkg -i google-chrome.deb \
	&& apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDeps \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -f google-chrome.deb \
	\
	# Unset SUID on all files other than chrome's sandbox
	&& for i in $(find / -perm /6000 -type f); do chmod a-s $i; done \
	&& chown root:root /opt/google/chrome/chrome-sandbox \
	&& chmod 4111 /opt/google/chrome/chrome-sandbox

USER chrome
WORKDIR /home/chrome

# Chrome wont start unless setuid sandbox is disabled
CMD ["google-chrome-stable", "--disable-setuid-sandbox", "--disable-seccomp-filter-sandbox", "--disable-extensions", "--disable-bundled-ppapi-flash", "--no-first-run"]
