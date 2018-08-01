#!/bin/bash -e

mirror="http://http.debian.net/debian"

package_name="opencv"
debian_pkg_name="${package_name}"
package_version="2.4.9.1+dfsg1"
package_source="${debian_pkg_name}_${package_version}.orig.tar.xz"
src_dir="${package_name}-2.4.9.1+dfsg"

git_repo=""
git_sha=""
reprepro_dir="o/${package_name}"
dl_path="pool/main/${reprepro_dir}/"

debian_version="${package_version}-2"
debian_untar="${package_name}_${debian_version}.debian.tar.xz"
debian_patch=""
local_patch="rcnee0"

stretch_version="~stretch+20171005"
