Felix' xfce4-terminal
=====================
xfce4-terminal has ugly borders when run with the ``--drop-down`` flag.

https://forum.xfce.org/viewtopic.php?id=9622 has a patch to remove the borders,
but the spacing remains. The ``max-width.patch`` removes the spacing too.

Prerequisites::

    sudo apt-get --yes install build-essential devscripts lintian diffutils patch patchutils

::

    make

