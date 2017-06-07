# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{4,5,6} )
DISTUTILS_SINGLE_IMPL="1"

#inherit python-single-r1
inherit distutils-r1 git-r3

EGIT_REPO_URI="git://git.poez.io/${PN}"
EGIT_MIN_CLONE_TYPE="mirror"

DESCRIPTION="Console XMPP client that looks like most famous IRC clients"
HOMEPAGE="http://poez.io/"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="otr"

#dnspython dep is optional and skipped (requires privately patched, python3 version)
RDEPEND="=dev-python/slixmpp-9999[${PYTHON_USEDEP}]
	${PYTHON_DEPS}
	otr? ( dev-python/pycrypto[${PYTHON_USEDEP}]
	dev-python/potr[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}"
