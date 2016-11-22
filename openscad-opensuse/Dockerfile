FROM opensuse:tumbleweed
ADD http://download.opensuse.org/repositories/home:/t-paul/openSUSE_Tumbleweed/home:t-paul.repo /etc/zypp/repos.d/
ADD http://download.opensuse.org/repositories/graphics/openSUSE_Tumbleweed/graphics.repo        /etc/zypp/repos.d/
RUN zypper --gpg-auto-import-keys install -y openscad-nightly && zypper clean
RUN ln -sf openscad-nightly /usr/bin/openscad
