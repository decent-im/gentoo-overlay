# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION=""
HOMEPAGE=""
EGIT_REPO_URI="https://github.com/randombit/botan"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

inherit git-r3 eutils

src_configure() {
	${S}/configure.py --destdir=${D}/usr
}
