FROM archlinux/archlinux:base-devel
RUN pacman -Syu --noconfirm git

COPY build-aur-package.sh /usr/local/bin/aur-build
RUN chmod +x /usr/local/bin/aur-build && \
    echo 'builder ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/builder && \
    useradd --create-home --home-dir /build builder && \
    mkdir /build/.gnupg && \
    echo 'keyserver-options auto-key-retrieve' > /build/.gnupg/gpg.conf && \
    mkdir -p /build/.config/pacman && \
    echo 'MAKEFLAGS="-j$(nproc)"' >> /build/.config/pacman/makepkg.conf && \
    echo 'PKGDEST="/out"' >> /build/.config/pacman/makepkg.conf && \
    mkdir /build/src && \
    mkdir /out && \
    chown -R builder:builder /build /out

VOLUME ["/build/src", "/out"]

ENTRYPOINT ["/usr/local/bin/aur-build"]

