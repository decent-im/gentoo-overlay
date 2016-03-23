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

KEYWORDS="x86 x86_64"

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
"

pkg_setup() {
	enewgroup decent.im
	enewuser decent.im -1 -1 -1 decent.im
}
