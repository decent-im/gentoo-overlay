# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION=""
HOMEPAGE=""

EGIT_REPO_URI="https://github.com/randombit/botan"
SRC_URI="https://github.com/randombit/botan/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

inherit eutils

if [[ ${PV} = 9999* ]]; then
	inherit git-r3
else
	KEYWORDS="amd64 x86"
fi

src_configure() {
	${S}/configure.py --destdir=${D}/usr
}
