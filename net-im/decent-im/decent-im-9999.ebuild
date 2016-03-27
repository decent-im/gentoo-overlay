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
EGIT_REPO_URI="https://github.com/decent-im/decent.im-gentoo"

LICENSE="GPL-3+"

SLOT="0"

KEYWORDS="x86 amd64"

IUSE=""

DEPEND=""
# TODO Add TURN server to RDEPEND
# coturn was used with Ubuntu, but absent in Portage Tree and overlays
RDEPEND="=net-im/prosody-9999
=net-im/prosody-modules-9999
=net-im/spectrum-9999
www-servers/nginx
app-crypt/letsencrypt
dev-db/postgresql
net-dns/bind-tools
"

pkg_postinst() {
	elog
	elog "To finish configuration of new setup, execute:"
	elog "    emerge --config =${CATEGORY}/${PF}"
}

pkg_config() {
	einfo "Updating rc to start postgresql-9.5, prosody, spectrum on default runlevel ..."
	rc-update add postgresql-9.5 default
	rc-update add prosody default
	rc-update add spectrum default

	einfo "Generating decent.im config ..."
	decent.im_configure

	einfo "Processing software config templates ..."
	decent.im_process_templates

	einfo "Generating and populating TLS certs ..."
	decent.im_letsencrypt

	einfo "Creating databases and access credentials for Prosody and Spectrum ..."
	decent.im_create_db_pg

	einfo "Starting Prosody and Spectrum ..."
	service prosody start
	service spectrum start
}
