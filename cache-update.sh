#!/bin/bash
#
# @@file: cache-update.sh
# @@desc: populate and generate application cache reports display in Terminal
# @author: Loouis Low (loouis@gmail.com)
#

# ansi
blue='\e[94m'
nc='\033[0m'
m="${blue}>${nc}"

# paths (default)
user="loouis"
home="/home/${user}"
external="/media/${user}/Storage/System"
report_dir="${home}/.cache-reports"

# paths (cache)
aptcacherng="/var/cache/apt-cacher-ng"
archloop="/var/spool/archloop"
dockerapt="/var/spool/dockeraptcache"
chrome="${home}/.cache/google-chrome"
downloads="${home}/Downloads"
electron="${home}/.cache/electron"
forever="${home}/.forever"
gaele="${home}/.config/Echoes"
golem="${external}/golem-apps"
gradle="${external}/.gradle"
mess="${home}/Documents/misc/mess"
music="${home}/Music"
maven="${external}/.m2"
npm="${external}/.npm"
opera="${home}/.cache/opera"
pip="${home}/.cache/pip"
playground="${home}/Documents/play/playground"
pnpm="${home}/.pnpm-store"
thumbnails="${home}/.cache/thumbnails"
videos="${home}/Videos"
yarn="${home}/.cache/yarn"

# prerequisites
if ! which parallel > /dev/null; then
  sudo apt install -y parallel
fi

# path to array
declare -a target=($aptcacherng $archloop $dockerapt $chrome $electron 
                   $downloads $fyn $forever $gaele $golem $golemappcache 
                   $gradle $mess $music $maven $npm $opera $pip $playground 
                   $pnpm $thumbnails $videos $yarn)

# create report dir, if doesn't
if [[ ! -f "${report_dir}" ]]; then
  mkdir -p ${report_dir}
fi

# create all report files, if doesn't
if [[ ! -f "${target}" ]]; then
  touch ${target}
fi

# worker
for c in "${target[@]}"; do
  # sanitize (remove things that don't need)
  filename=$(echo $c | grep $c | sed 's/home//g' | sed 's/loouis//g' |
             sed 's/var//g'| sed 's/spool//g' | sed 's/cache//g' |
             sed 's/Documents//g' | sed 's/misc//g' | sed 's/play//g' |
             sed 's/config//g' | sed 's/media//g' | sed 's/Storage//g' |
             sed 's/System//g' | sed 's/-r-ng//g'|
             tr -d './' | tr '[:upper:]' '[:lower:]')
  # populate cache size and write to file
  # 1 job per cpu core
  parallel -j 200 du -hs :::  $c > ${report_dir}/${filename}_cache.report
  # read file
  cache_size=`cat ${report_dir}/${filename}_cache.report | head -1 | cut -f1`
  echo -e " $m populating ... $filename (${cache_size}B)"
done

echo -e " $m reports generated at ${report_dir}";echo

