FROM opensuse/leap:15.4

RUN zypper ar -f https://download.opensuse.org/repositories/OBS:/Server:/2.10/15.4/OBS:Server:2.10.repo
RUN zypper --non-interactive --no-gpg-checks refresh; zypper --non-interactive --no-gpg-checks install obs-worker which aaa_base tar openslp screen dpkg-devel sysvinit-tools hostname xz devscripts

ADD ./start.sh /opt/start.sh
ENTRYPOINT ["/opt/start.sh"]
