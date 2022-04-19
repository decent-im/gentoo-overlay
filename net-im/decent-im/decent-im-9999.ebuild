# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils git-r3 user

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
net-im/coturn
net-im/prosody
net-im/prosody-modules
www-servers/nginx
app-crypt/certbot
dev-db/postgresql
net-dns/bind-tools
app-portage/smart-live-rebuild
net-misc/ntp
sys-process/cronie
app-admin/logrotate
app-admin/syslog-ng
app-emulation/qemu-guest-agent
mail-mta/ssmtp[mta]
net-firewall/nftables
dev-lang/lua:5.4
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
