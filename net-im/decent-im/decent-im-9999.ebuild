# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

inherit git-r3

DESCRIPTION="Prepared, cutting edge XMPP server configuration"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://decent.im"

# Point to any required sources; these will be automatically downloaded by
# Portage.
EGIT_REPO_URI="https://github.com/decent-im/decent.im"

LICENSE="GPL-3+"

SLOT="0"

KEYWORDS="x86 amd64"

IUSE=""

DEPEND=""
RDEPEND="
app-admin/eclean-kernel
app-admin/logrotate
app-admin/syslog-ng
app-crypt/certbot
app-emulation/qemu-guest-agent
app-portage/gentoolkit
app-portage/smart-live-rebuild
dev-db/postgresql
dev-lang/lua:5.4
dev-vcs/git
mail-mta/nullmailer
net-dns/bind-tools
net-firewall/nftables
net-im/coturn
net-im/prosody[icu,-idn]
net-im/prosody-modules
net-misc/ntp
sys-apps/moreutils
sys-fs/ncdu
sys-process/cronie
www-servers/nginx
"

src_install() {
	emake DESTDIR="${D}/usr" install
}

pkg_postinst() {
	if ! [[ -e "$ROOT/etc/decent.im/config" ]] ; then
		elog
		elog "To finish configuration of new setup, execute:"
		elog "    decent.im-postinst"
	fi
}

pkg_preinst() {
	if ! [[ -e "$ROOT/etc/decent.im/config" ]]
	then
		einfo "Generating decent.im config ..."
		"$D"/usr/sbin/decent.im_configure "$D"/etc/decent.im/config
	fi

	einfo "Processing software config templates ..."
	"$D"/usr/sbin/decent.im_process_templates "$ROOT" "$D"
}
