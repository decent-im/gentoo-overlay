# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION=""
HOMEPAGE=""
EGIT_REPO_URI="git://git.louiz.org/litesql"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

inherit git-r3 cmake-utils

mycmakeargs=(
	-DLITESQL_WITH_POSTGRES=ON
)
