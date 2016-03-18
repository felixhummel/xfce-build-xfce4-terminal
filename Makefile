default: sudo tools clean xfce4-terminal_0.6.3-1ubuntu1.1_amd64.deb

export DEBFULLNAME="Felix Hummel"
export DEBEMAIL="xfce4-terminal@felixhummel.de"

.PHONY: sudo
sudo:
	sudo echo "get sudo out of the way now"

xfce4-terminal-0.6.3:
	apt-get source xfce4-terminal
	sudo apt-get --yes build-dep xfce4-terminal

patch: xfce4-terminal-0.6.3
	cd xfce4-terminal-0.6.3/ \
		&& patch -N -r - -p1 < ../kill_borders.patch \
		&& patch -N -r - -p1 < ../max-width.patch

xfce4-terminal_0.6.3-1ubuntu1.1_amd64.deb: patch
	cd xfce4-terminal-0.6.3/ \
		&& dch --nmu "kill drop down borders" \
		&& debuild -us -uc -b

.PHONY: install
install:
	sudo dpkg -i xfce4-terminal_0.6.3-1ubuntu1.1_amd64.deb

tools:
	sudo apt-get --yes install build-essential devscripts lintian patch patchutils

.PHONY: clean
clean:
	rm -rf xfce4-terminal*

.PHONY: test
test:
	xfce4-terminal --disable-server --drop-down
