# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="sends syslog stream as emails via local MTA"
HOMEPAGE="https://github.com/andrey-utkin/syslog-to-sendmail"
EGIT_REPO_URI="https://github.com/andrey-utkin/syslog-to-sendmail"
LICENSE="CC0-1.0"
SLOT="0"

KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="virtual/mta"

src_install() {
	dobin syslog-to-sendmail
}
