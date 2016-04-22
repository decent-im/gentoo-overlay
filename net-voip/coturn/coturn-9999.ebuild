# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3

DESCRIPTION="coturn TURN server project"

# Homepage, not used by Portage directly but handy for developer reference
HOMEPAGE="https://github.com/coturn/coturn"

# Point to any required sources; these will be automatically downloaded by
# Portage.
EGIT_REPO_URI="https://github.com/coturn/coturn.git"

# Unsure
LICENSE="BSD"

SLOT="0"

KEYWORDS="x86 amd64"

# TODO
# libevent2 sqlite mysql postgresql ssl mongodb hiredis
IUSE=""

DEPEND=""
RDEPEND=""
