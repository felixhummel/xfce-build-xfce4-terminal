# dpkg-query -Wf '${Package}\t${Version}\n' xfce4-terminal
BASE=xfce4-terminal-0.6.3
RESULT=xfce4-terminal_0.6.3-2ubuntu1.1_amd64.deb

default: sudo tools clean $(RESULT)

export DEBFULLNAME="Felix Hummel"
export DEBEMAIL="xfce4-terminal@felixhummel.de"

.PHONY: sudo
sudo:
	sudo echo "get sudo out of the way now"

$(BASE):
	apt-get source xfce4-terminal
	sudo apt-get --yes build-dep xfce4-terminal

patch: $(BASE)
	cd $(BASE)/ \
		&& patch -N -r - -p1 < ../kill_borders.patch \
		&& patch -N -r - -p1 < ../max-width.patch

$(RESULT): patch
	cd $(BASE)/ \
		&& dch --nmu "kill drop down borders" \
		&& debuild -us -uc -b

.PHONY: install
install:
	sudo dpkg -i $(RESULT)

tools:
	sudo apt-get --yes install build-essential devscripts lintian patch patchutils

.PHONY: clean
clean:
	rm -rf xfce4-terminal*

.PHONY: test
test:
	xfce4-terminal --disable-server --drop-down
