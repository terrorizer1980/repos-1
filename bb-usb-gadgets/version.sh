#!/bin/bash -e

package_name="bb-usb-gadgets"
debian_pkg_name="${package_name}"
package_version="1.20220103.0"
package_source=""
src_dir=""

git_repo=""
git_sha=""
reprepro_dir="b/${package_name}"
dl_path="pool/main/${reprepro_dir}/"

debian_version="${package_version}-0"
debian_untar=""
debian_patch=""

clear_changelog="enable"

stretch_version="~stretch+20220103"
buster_version="~buster+20220103"
bullseye_version="~bullseye+20220103"
bionic_version="~bionic+20220103"
focal_version="~focal+20220103"
