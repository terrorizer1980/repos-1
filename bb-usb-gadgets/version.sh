#!/bin/bash -e

package_name="bb-usb-gadgets"
debian_pkg_name="${package_name}"
package_version="1.20210813.7"
package_source=""
src_dir=""

git_repo=""
git_sha=""
reprepro_dir="b/${package_name}"
dl_path="pool/main/${reprepro_dir}/"

debian_version="${package_version}-0"
debian_untar=""
debian_patch=""

stretch_version="~stretch+20210813"
buster_version="~buster+20210813"
bullseye_version="~bullseye+20210813"
bionic_version="~bionic+20210813"
focal_version="~focal+20210813"
