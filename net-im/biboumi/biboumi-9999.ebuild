# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Biboumi is an XMPP gateway that connects to IRC servers and translates between the two protocols"
HOMEPAGE="https://lab.louiz.org/louiz/biboumi"
EGIT_REPO_URI="git://git.louiz.org/biboumi.git"

LICENSE="zlib"
SLOT="0"
KEYWORDS=""
IUSE="postgres sqlite"

DEPEND="
dev-libs/expat
net-dns/c-ares
net-dns/libidn
net-im/jabber-base
net-libs/botan
net-libs/udns
virtual/libiconv
postgres? ( dev-db/postgresql )
sqlite? ( dev-db/sqlite )
"
RDEPEND="${DEPEND}"

inherit git-r3 cmake-utils

DIRS="/var/log/biboumi /var/lib/biboumi"

src_configure() {
	local mycmakeargs=(
		-DWITH_POSTGRESQL="$(usex postgres)"
		-DWITHOUT_POSTGRESQL="$(usex !postgres)"
		-DWITH_SQLITE3="$(usex sqlite)"
		-DWITHOUT_SQLITE3="$(usex !sqlite)"
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	newinitd "${FILESDIR}/${PN}".initd "${PN}"
	insinto /etc/logrotate.d
	newins "${FILESDIR}/${PN}".logrotate "${PN}"
	for dir in $DIRS
	do
		keepdir $dir
	done
}

pkg_postinst() {
	for dir in $DIRS
	do
		chown jabber:jabber $dir
		chmod u=rwx,g=rx,o= $dir
	done
}
