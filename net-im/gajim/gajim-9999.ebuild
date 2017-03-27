# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
EGIT_REPO_URI="https://dev.gajim.org/gajim/gajim.git"

PYTHON_COMPAT=( python3_{5,6} )
PYTHON_REQ_USE="sqlite,xml"

AUTOTOOLS_AUTORECONF=true

inherit autotools python-r1 versionator git-r3

DESCRIPTION="Jabber client written in PyGTK"
HOMEPAGE="http://www.gajim.org/"

LICENSE="GPL-3"
SLOT="0"
IUSE="crypt dbus gnome gnome-keyring kde idle jingle networkmanager nls spell +srv test X xhtml zeroconf"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	gnome? ( gnome-keyring )
	zeroconf? ( dbus )"

COMMON_DEPEND="
	${PYTHON_DEPS}
	x11-libs/gtk+:3"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.40.1
	virtual/pkgconfig
	>=sys-devel/gettext-0.17-r1"
RDEPEND="${COMMON_DEPEND}
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/protobuf-python[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/cx_Freeze[${PYTHON_USEDEP}]
	dev-python/keyring[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pycurl[${PYTHON_USEDEP}]
	dev-python/qrcode[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-0.14[${PYTHON_USEDEP}]
	>=dev-python/python-nbxmpp-0.5.3[${PYTHON_USEDEP}]
	crypt? (
		app-crypt/gnupg
		dev-python/python-gnupg[${PYTHON_USEDEP}]
		)
	dbus? (
		dev-python/dbus-python[${PYTHON_USEDEP}]
		virtual/notification-daemon
		dev-libs/dbus-glib
		zeroconf? ( net-dns/avahi[dbus,gtk,python,${PYTHON_USEDEP}] )
		)
	gnome? (
		dev-python/libgnome-python[${PYTHON_USEDEP}]
		dev-python/egg-python[${PYTHON_USEDEP}]
		)
	gnome-keyring? ( dev-python/gnome-keyring-python[${PYTHON_USEDEP}] )
	idle? ( x11-libs/libXScrnSaver )
	jingle? ( net-libs/farstream:0.2[python,${PYTHON_USEDEP}] )
	kde? ( kde-apps/kwalletmanager )
	networkmanager? (
			dev-python/dbus-python[${PYTHON_USEDEP}]
			net-misc/networkmanager
		)
	spell? ( app-text/gtkspell:2 )
	srv? (
		|| (
			dev-python/libasyncns-python[${PYTHON_USEDEP}]
			net-dns/bind-tools
			)
		)
	xhtml? ( dev-python/docutils[${PYTHON_USEDEP}] )"

RESTRICT="test"

src_prepare() {
	NO_AUTOTOOLS_RUN=1 ./autogen.sh
	eautoreconf

	default
	python_copy_sources
}

src_configure() {
	configuration() {
		local myeconfargs=(
			$(use_enable nls)
			$(use_with X x)
			--docdir="/usr/share/doc/${PF}"
			--libdir="$(python_get_sitedir)"
			--enable-site-packages
		)
		run_in_build_dir default
	}
	python_foreach_impl configuration
}

src_compile() {
	compilation() {
		run_in_build_dir default
	}
	python_foreach_impl compilation
}

src_test() {
	testing() {
		run_in_build_dir ${PYTHON} test/runtests.py --verbose 3 || die
	}
	python_foreach_impl testing
}

src_install() {
	installation() {
		run_in_build_dir default
		python_optimize
	}
	python_foreach_impl installation
}
