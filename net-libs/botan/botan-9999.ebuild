# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION=""
HOMEPAGE=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

inherit eutils

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/randombit/${PN}"
	inherit git-r3
else
	SRC_URI="https://github.com/randombit/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi

src_configure() {
	${S}/configure.py \
		--destdir=${D}/usr \
		--prefix=/usr \
		;
}
