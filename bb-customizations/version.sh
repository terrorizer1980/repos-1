#!/bin/bash -e

package_name="bb-customizations"
debian_pkg_name="${package_name}"
package_version="1.20191024.1"
package_source=""
src_dir=""

git_repo=""
git_sha=""
reprepro_dir="b/${package_name}"
dl_path="pool/main/${reprepro_dir}/"

debian_version="${package_version}-0rcnee0"
debian_untar=""
debian_patch=""

stretch_version="~stretch+20200226"
buster_version="~buster+20200226"
xenial_version="~xenial+20200226"
bionic_version="~bionic+20200226"
