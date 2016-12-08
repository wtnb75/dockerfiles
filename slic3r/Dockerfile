FROM opensuse
#ADD http://dl.slic3r.org/linux/slic3r-linux-x86_64-1-2-9-stable.tar.gz /usr/local
#ADD slic3r-linux-x86_64-1-2-9-stable.tar.gz /usr/local/
RUN zypper install -y tar curl && \
    zypper clean && \
    curl http://dl.slic3r.org/linux/slic3r-linux-x86_64-1-2-9-stable.tar.gz | tar xfz - -C /usr/local && \
    ln -fs /usr/local/Slic3r/bin/slic3r /usr/bin/
