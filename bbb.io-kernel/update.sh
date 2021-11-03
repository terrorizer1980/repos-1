#!/bin/bash -e

. version.sh

current_kernel () {
	if [ -f /tmp/LATEST-${var} ] ; then
		rm -rf /tmp/LATEST-${var} | true
	fi
	wget --quiet --directory-prefix=/tmp/ https://rcn-ee.net/repos/latest/${dist}-${arch}/LATEST-${var}
	unset latest_kernel
	latest_kernel=$(cat "/tmp/LATEST-${var}" | grep "ABI:1 ${ver}" | awk '{print $3}')
}

generate_header () {
	echo "# This file is autogenerated. Do not edit!" > ./suite/${dist}/debian/${wfile}
	echo "Source: bbb.io-kernel" >> ./suite/${dist}/debian/${wfile}
	echo "Section: misc" >> ./suite/${dist}/debian/${wfile}
	echo "Priority: optional" >> ./suite/${dist}/debian/${wfile}
	echo "Maintainer: Robert Nelson <robertcnelson@gmail.com>" >> ./suite/${dist}/debian/${wfile}
	echo "Build-Depends: debhelper-compat (= ${debhelper})" >> ./suite/${dist}/debian/${wfile}
	echo "Standards-Version: 4.5.0" >> ./suite/${dist}/debian/${wfile}
	echo "Rules-Requires-Root: no" >> ./suite/${dist}/debian/${wfile}
	echo "" >> ./suite/${dist}/debian/${wfile}
	echo "Package: bbb.io-kernel-tasks" >> ./suite/${dist}/debian/${wfile}
	echo "Architecture: all" >> ./suite/${dist}/debian/${wfile}
	echo "Depends: tasksel, \${misc:Depends}" >> ./suite/${dist}/debian/${wfile}
	echo "Description: BeagleBoard.org Kernel Branches" >> ./suite/${dist}/debian/${wfile}
	echo " This package contains tasksel information for the BeagleBoard.org Kernel Branch." >> ./suite/${dist}/debian/${wfile}
}

generate_kernel_ti () {
	echo "" >> ./suite/${dist}/debian/${wfile}
	echo "Package: bbb.io-kernel-${msg}" >> ./suite/${dist}/debian/${wfile}
	echo "Section: metapackages" >> ./suite/${dist}/debian/${wfile}
	echo "Architecture: all" >> ./suite/${dist}/debian/${wfile}
	echo "Pre-Depends: linux-image-${latest_kernel}," >> ./suite/${dist}/debian/${wfile}
	echo "Depends: \${misc:Depends}, bbb.io-kernel-tasks (= \${source:Version})" >> ./suite/${dist}/debian/${wfile}
	echo "Recommends: libpruio-modules-${latest_kernel}," >> ./suite/${dist}/debian/${wfile}
	echo "Description: BeagleBoard.org ${msg}" >> ./suite/${dist}/debian/${wfile}
	echo " This metapackage will install linux-image-${msg} in Debian." >> ./suite/${dist}/debian/${wfile}

	echo "" >> ./suite/${dist}/debian/${wfile}
	echo "Package: bbb.io-kernel-${msg}-am335x" >> ./suite/${dist}/debian/${wfile}
	echo "Section: metapackages" >> ./suite/${dist}/debian/${wfile}
	echo "Architecture: all" >> ./suite/${dist}/debian/${wfile}
	echo "Pre-Depends: linux-image-${latest_kernel}," >> ./suite/${dist}/debian/${wfile}
	echo "Depends: \${misc:Depends}, bbb.io-kernel-tasks (= \${source:Version})" >> ./suite/${dist}/debian/${wfile}
	echo "Recommends: libpruio-modules-${latest_kernel}," >> ./suite/${dist}/debian/${wfile}
	if [ "x${sgxti335x}" = "xenabled" ] ; then
		echo "            ti-sgx-ti335x-modules-${latest_kernel}," >> ./suite/${dist}/debian/${wfile}
	fi
	echo "            bb-u-boot-am335x-evm" >> ./suite/${dist}/debian/${wfile}
	echo "Description: BeagleBoard.org ${msg} for am335x" >> ./suite/${dist}/debian/${wfile}
	echo " This metapackage will install linux-image-${msg} for am335x in Debian." >> ./suite/${dist}/debian/${wfile}

	echo "" >> ./suite/${dist}/debian/${wfile}
	echo "Package: bbb.io-kernel-${msg}-am57xx" >> ./suite/${dist}/debian/${wfile}
	echo "Section: metapackages" >> ./suite/${dist}/debian/${wfile}
	echo "Architecture: all" >> ./suite/${dist}/debian/${wfile}
	echo "Pre-Depends: linux-image-${latest_kernel}," >> ./suite/${dist}/debian/${wfile}
	echo "Depends: \${misc:Depends}, bbb.io-kernel-tasks (= \${source:Version})" >> ./suite/${dist}/debian/${wfile}
	echo "Recommends: libpruio-modules-${latest_kernel}," >> ./suite/${dist}/debian/${wfile}
	if [ "x${sgxjacinto6evm}" = "xenabled" ] ; then
		echo "            ti-sgx-jacinto6evm-modules-${latest_kernel}," >> ./suite/${dist}/debian/${wfile}
	fi
	echo "            bb-u-boot-am57xx-evm" >> ./suite/${dist}/debian/${wfile}
	echo "Description: BeagleBoard.org ${msg} for am57xx" >> ./suite/${dist}/debian/${wfile}
	echo " This metapackage will install linux-image-${msg} for am57xx in Debian." >> ./suite/${dist}/debian/${wfile}
}

generate_kernel_mainline_bone () {
	echo "" >> ./suite/${dist}/debian/${wfile}
	echo "Package: bbb.io-kernel-${msg}" >> ./suite/${dist}/debian/${wfile}
	echo "Section: metapackages" >> ./suite/${dist}/debian/${wfile}
	echo "Architecture: all" >> ./suite/${dist}/debian/${wfile}
	echo "Pre-Depends: linux-image-${latest_kernel}," >> ./suite/${dist}/debian/${wfile}
	echo "Depends: \${misc:Depends}, bbb.io-kernel-tasks (= \${source:Version})" >> ./suite/${dist}/debian/${wfile}
	echo "Recommends: libpruio-modules-${latest_kernel}," >> ./suite/${dist}/debian/${wfile}
	echo "Description: BeagleBoard.org ${msg} for am335x" >> ./suite/${dist}/debian/${wfile}
	echo " This metapackage will install linux-image-${msg} for am335x in Debian." >> ./suite/${dist}/debian/${wfile}
}

generate_kernel_mainline_armv7 () {
	echo "" >> ./suite/${dist}/debian/${wfile}
	echo "Package: bbb.io-kernel-${msg}" >> ./suite/${dist}/debian/${wfile}
	echo "Section: metapackages" >> ./suite/${dist}/debian/${wfile}
	echo "Architecture: all" >> ./suite/${dist}/debian/${wfile}
	echo "Pre-Depends: linux-image-${latest_kernel}," >> ./suite/${dist}/debian/${wfile}
	echo "Depends: \${misc:Depends}, bbb.io-kernel-tasks (= \${source:Version})" >> ./suite/${dist}/debian/${wfile}
	echo "Recommends: libpruio-modules-${latest_kernel}," >> ./suite/${dist}/debian/${wfile}
	echo "Description: BeagleBoard.org ${msg} for armv7" >> ./suite/${dist}/debian/${wfile}
	echo " This metapackage will install linux-image-${msg} for armv7 in Debian." >> ./suite/${dist}/debian/${wfile}
}

generate_kernel_mainline_armv7_lpae () {
	echo "" >> ./suite/${dist}/debian/${wfile}
	echo "Package: bbb.io-kernel-${msg}" >> ./suite/${dist}/debian/${wfile}
	echo "Section: metapackages" >> ./suite/${dist}/debian/${wfile}
	echo "Architecture: all" >> ./suite/${dist}/debian/${wfile}
	echo "Pre-Depends: linux-image-${latest_kernel}," >> ./suite/${dist}/debian/${wfile}
	echo "Depends: \${misc:Depends}, bbb.io-kernel-tasks (= \${source:Version})" >> ./suite/${dist}/debian/${wfile}
	echo "Recommends: libpruio-modules-${latest_kernel}," >> ./suite/${dist}/debian/${wfile}
	echo "Description: BeagleBoard.org ${msg} for armv7-lpae" >> ./suite/${dist}/debian/${wfile}
	echo " This metapackage will install linux-image-${msg} for armv7-lpae in Debian." >> ./suite/${dist}/debian/${wfile}
}

do_buster () {
	arch="armhf"
	dist="buster"
	debhelper="12"
	wfile="control"
	generate_header

	sgxti335x="enabled"
	sgxjacinto6evm="enabled"

	msg="4.19-ti"    ; var="ti"    ; ver="LTS419" ; current_kernel ; generate_kernel_ti
	msg="4.19-ti-rt" ; var="ti-rt" ; ver="LTS419" ; current_kernel ; generate_kernel_ti
	msg="5.4-ti"     ; var="ti"    ; ver="LTS54"  ; current_kernel ; generate_kernel_ti
	msg="5.4-ti-rt"  ; var="ti-rt" ; ver="LTS54"  ; current_kernel ; generate_kernel_ti
	msg="5.10-ti"    ; var="ti"    ; ver="LTS510" ; current_kernel ; generate_kernel_ti
	msg="5.10-ti-rt" ; var="ti-rt" ; ver="LTS510" ; current_kernel ; generate_kernel_ti
	unset sgxjacinto6evm
	unset sgxti335x

	msg="4.19-bone" ; var="omap-psp" ; ver="LTS419" ; current_kernel ; generate_kernel_mainline_bone
	msg="5.4-bone"  ; var="omap-psp" ; ver="LTS54"  ; current_kernel ; generate_kernel_mainline_bone
	msg="5.10-bone" ; var="omap-psp" ; ver="LTS510" ; current_kernel ; generate_kernel_mainline_bone
	msg="5.14-bone" ; var="omap-psp" ; ver="V514X" ; current_kernel ; generate_kernel_mainline_bone
	msg="5.15-bone" ; var="omap-psp" ; ver="LTS515" ; current_kernel ; generate_kernel_mainline_bone

	msg="4.19-bone-rt" ; var="bone-rt" ; ver="LTS419" ; current_kernel ; generate_kernel_mainline_bone
	msg="5.4-bone-rt"  ; var="bone-rt" ; ver="LTS54"  ; current_kernel ; generate_kernel_mainline_bone
	msg="5.10-bone-rt" ; var="bone-rt" ; ver="LTS510" ; current_kernel ; generate_kernel_mainline_bone

	msg="4.19-armv7" ; var="armv7" ; ver="LTS419" ; current_kernel ; generate_kernel_mainline_armv7
	msg="5.4-armv7"  ; var="armv7" ; ver="LTS54"  ; current_kernel ; generate_kernel_mainline_armv7
	msg="5.10-armv7" ; var="armv7" ; ver="LTS510" ; current_kernel ; generate_kernel_mainline_armv7
	msg="5.15-armv7" ; var="armv7" ; ver="LTS515" ; current_kernel ; generate_kernel_mainline_armv7

	msg="4.19-armv7-rt" ; var="armv7-rt" ; ver="LTS419" ; current_kernel ; generate_kernel_mainline_armv7
	msg="5.4-armv7-rt"  ; var="armv7-rt" ; ver="LTS54"  ; current_kernel ; generate_kernel_mainline_armv7
	msg="5.10-armv7-rt" ; var="armv7-rt" ; ver="LTS510" ; current_kernel ; generate_kernel_mainline_armv7

	msg="4.19-armv7-lpae" ; var="armv7-lpae" ; ver="LTS419" ; current_kernel ; generate_kernel_mainline_armv7_lpae
	msg="5.4-armv7-lpae"  ; var="armv7-lpae" ; ver="LTS54"  ; current_kernel ; generate_kernel_mainline_armv7_lpae
	msg="5.10-armv7-lpae" ; var="armv7-lpae" ; ver="LTS510" ; current_kernel ; generate_kernel_mainline_armv7_lpae
	msg="5.15-armv7-lpae" ; var="armv7-lpae" ; ver="LTS515" ; current_kernel ; generate_kernel_mainline_armv7_lpae
}

do_bullseye () {
	arch="armhf"
	dist="bullseye"
	debhelper="13"
	wfile="control"
	generate_header

	sgxti335x="enabled"
	sgxjacinto6evm="enabled"

	msg="4.19-ti"    ; var="ti"    ; ver="LTS419" ; current_kernel ; generate_kernel_ti
	msg="4.19-ti-rt" ; var="ti-rt" ; ver="LTS419" ; current_kernel ; generate_kernel_ti
	msg="5.4-ti"     ; var="ti"    ; ver="LTS54"  ; current_kernel ; generate_kernel_ti
	msg="5.4-ti-rt"  ; var="ti-rt" ; ver="LTS54"  ; current_kernel ; generate_kernel_ti
	msg="5.10-ti"    ; var="ti"    ; ver="LTS510" ; current_kernel ; generate_kernel_ti
	msg="5.10-ti-rt" ; var="ti-rt" ; ver="LTS510" ; current_kernel ; generate_kernel_ti
	unset sgxjacinto6evm
	unset sgxti335x

	msg="4.19-bone" ; var="omap-psp" ; ver="LTS419" ; current_kernel ; generate_kernel_mainline_bone
	msg="5.4-bone"  ; var="omap-psp" ; ver="LTS54"  ; current_kernel ; generate_kernel_mainline_bone
	msg="5.10-bone" ; var="omap-psp" ; ver="LTS510" ; current_kernel ; generate_kernel_mainline_bone
	msg="5.14-bone" ; var="omap-psp" ; ver="V514X" ; current_kernel ; generate_kernel_mainline_bone
	msg="5.15-bone" ; var="omap-psp" ; ver="LTS515" ; current_kernel ; generate_kernel_mainline_bone

	msg="4.19-bone-rt" ; var="bone-rt" ; ver="LTS419" ; current_kernel ; generate_kernel_mainline_bone
	msg="5.4-bone-rt"  ; var="bone-rt" ; ver="LTS54"  ; current_kernel ; generate_kernel_mainline_bone
	msg="5.10-bone-rt" ; var="bone-rt" ; ver="LTS510" ; current_kernel ; generate_kernel_mainline_bone

	msg="4.19-armv7" ; var="armv7" ; ver="LTS419" ; current_kernel ; generate_kernel_mainline_armv7
	msg="5.4-armv7"  ; var="armv7" ; ver="LTS54"  ; current_kernel ; generate_kernel_mainline_armv7
	msg="5.10-armv7" ; var="armv7" ; ver="LTS510" ; current_kernel ; generate_kernel_mainline_armv7
	msg="5.15-armv7" ; var="armv7" ; ver="LTS515" ; current_kernel ; generate_kernel_mainline_armv7

	msg="4.19-armv7-rt" ; var="armv7-rt" ; ver="LTS419" ; current_kernel ; generate_kernel_mainline_armv7
	msg="5.4-armv7-rt"  ; var="armv7-rt" ; ver="LTS54"  ; current_kernel ; generate_kernel_mainline_armv7
	msg="5.10-armv7-rt" ; var="armv7-rt" ; ver="LTS510" ; current_kernel ; generate_kernel_mainline_armv7

	msg="4.19-armv7-lpae" ; var="armv7-lpae" ; ver="LTS419" ; current_kernel ; generate_kernel_mainline_armv7_lpae
	msg="5.4-armv7-lpae"  ; var="armv7-lpae" ; ver="LTS54"  ; current_kernel ; generate_kernel_mainline_armv7_lpae
	msg="5.10-armv7-lpae" ; var="armv7-lpae" ; ver="LTS510" ; current_kernel ; generate_kernel_mainline_armv7_lpae
	msg="5.15-armv7-lpae" ; var="armv7-lpae" ; ver="LTS515" ; current_kernel ; generate_kernel_mainline_armv7_lpae
}

do_buster
do_bullseye

