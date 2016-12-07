#!/bin/bash -e

#https://github.com/c9/core

package_name="c9-core-installer"
debian_pkg_name="${package_name}"
package_version="3.1.3306+git20161130"
package_source=""
src_dir=""

git_repo=""
git_sha=""
reprepro_dir="c/${package_name}"
dl_path="pool/main/${reprepro_dir}/"

debian_version="${package_version}-0"
debian_untar=""
debian_patch=""
local_patch="rcnee0"

debian_dl_1="https://rcn-ee.com/repos/git/archive/c9-npmbox/virtualenv-12.0.7.tar.gz"
debian_dl_2="https://rcn-ee.net/repos/git/archive/c9-core_v0.12.x/c9-core_3.1.3306+git20161130-v0.12.17-build.tar.xz"

stretch_version="~bpo90+20161114+1"
xenial_version="~bpo1604+20161114+1"
jessie_version="~bpo80+20161207+1"
