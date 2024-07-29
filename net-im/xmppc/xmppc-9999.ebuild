# Copyright 2024 Andriy Utkin
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=8

inherit git-r3 autotools

DESCRIPTION="XMPP command-line tool"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://codeberg.org/Anoxinon_e.V./xmppc"

# Point to any required sources; these will be automatically downloaded by
# Portage.
EGIT_REPO_URI="https://codeberg.org/Anoxinon_e.V./xmppc"

LICENSE="GPL-3"

SLOT="0"

KEYWORDS="x86 amd64"

IUSE=""

DEPEND="dev-libs/libstrophe"
RDEPEND="$DEPEND"

src_prepare() {
	default
	eautoreconf
}
