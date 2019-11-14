#!/bin/bash
#
# @@file: cache-widget.sh
# @@desc: display cache reports in terminal
#

# ansi
blue='\e[94m'
red='\e[91m'
nc='\033[0m'
d="${red}၊${nc}"

# paths
user="loouis"
report_path="/home/${user}/.cache-reports"

function read_report() {
  # --- args
  file=$1
  # --- worker
  data=`cat ${report_path}/${file}_cache.report | head -1 | cut -f1`
  echo ${data}"B"
}

function show_report() {
  # ---args
  declare -a array=($1)
  # --- worker
  for i in "${array[@]}"; do
    report=`read_report "${report_path}" "${i}"`
    echo -e "${i^^} - ${report}"
  done
}

# read cache reports
apt=`read_report "apt"`
archloop=`read_report "archloop"`
chrome=`read_report "google-chrome"`
dockerapt=`read_report "dockerapt"`
downloads=`read_report "downloads"`
electron=`read_report "electron"`
forever=`read_report "electron"`
echoes=`read_report "echoes"`
golem=`read_report "golem-apps"`
gradle=`read_report "gradle"`
mess=`read_report "mess"`
music=`read_report "music"`
maven=`read_report "m2"`
npm=`read_report "npm"`
opera=`read_report "opera"`
pip=`read_report "pip"`
playground=`read_report "ground"`
pnpm=`read_report "pnpm-store"`
thumbnails=`read_report "thumbnails"`
video=`read_report "videos"`
yarn=`read_report "yarn"`

battery=`upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep 'capacity' | sed 's/capacity://g' | sed 's/ //g'`

# report widgets
echo -e "YRN: $yarn ${d} NPM: $npm ${d} ARH: $archloop ${d} PNM: $pnpm ${d} OPR: $opera ${d} CRX: $chrome"
echo -e "ECH: $echoes ${d} MUS: $music ${d} VID: $video ${d} DWN: $downloads ${d} PIP: $pip ${d} dPT: $dockerapt"
echo -e "GOL: $golem ${d} MES: $mess ${d} PYG: $playground ${d} GDL: $gradle ${d} FRV: $forever ${d} ELT: $electron"
echo -e "MVN: $maven ${d} APT: $apt ${d} TBN: $thumbnails ${d} BLF: $battery";echo
