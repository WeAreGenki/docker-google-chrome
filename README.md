Ephemeral Google Chrome in a Docker container useful for testing websites. Sometimes it's hard to clean caches (DNS, caching proxies, etc) but this is a browser environment that's completely clean every time.

NOTE: This is intended to be used on Linux desktop systems -- no idea how to get it working on another OS. Also there's a few tweaks to harden security, if you have any problems please open a Github issue.

# Requirements

* Docker 1.8+
* X server or Wayland (with xorg-server-xwayland)

## Instructions

You can either customise and build the Docker image yourself, which is a good idea since you'll get the latest version of Google Chrome. Or just run launch-chrome.docker.sh as is to use a pre-built image from Docker Hub.

If you don't want Chrome stable or the 64bit version just edit the Dockerfile and build it yourself.

1. Build Docker image (replace with your user name): `docker build --no-cache -t <UserName>/chrome .`
2. Customise the values in launch-chrome.docker.sh
3. Make sure launch-chrome.docker.sh is executable: `chmod +x launch-chrome.docker.sh`
4. Run launch-chrome.docker.sh

# Note: Site Blocking

For my own productivity I disable access to www.youtube.com and www.facebook.com. If you don't want this, remove the line in launch-chrome.docker.sh.
