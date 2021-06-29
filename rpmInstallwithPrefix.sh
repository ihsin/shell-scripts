#!/bin/sh

USAGE=$(cat<<-EOF
$(basename $BASH_SOURCE) <-u> <rpm_url> <-h> <-p> <prefix>
download an rpm and installs it at specified prefix.
EOF
)

URL=""
PREFIX=${PWD}

while [ $# -gt 0 ];
do
	case "$1" in 
		'-h') echo $USAGE;
			exit 0;;
		'-u') shift;
			URL="$1"
			[ "$URL" == "" ] && echo $USAGE && exit 2;
			shift;;
		'-p') shift;
			PREFIX="$1"
			[ "$PREFIX" == "" ] && echo $USAGE && exit 2;
			shift;;
		'*') echo "unkown option: ""$1"
	esac		
done

if [ ! -d "$PREFIX" ];then
	echo "directory ""$PREFIX"" does not exits!Exiting"
	exit 3
fi

if [ -z "$URL" ];then
	echo "no url provided"
	exit 4
fi

function downloadRPM(){
	RPM_URL="$1"
	echo "downloading rpm..."
	wget -qP /tmp  ${RPM_URL}
        [ $? -ne 0 ] && echo "error downloading rpm." && exit 2 
}

RPM_NAME=$(echo "$URL"|sed 's/^.*\///g')
PACKAGE_NAME=$(echo "$RPM_NAME"|sed 's/-.*//g')

mkdir -p "$PREFIX""/""$PACKAGE_NAME"
downloadRPM "$URL"

cd "$PREFIX""/""$PACKAGE_NAME"
echo "converting rpm to a cpio archive and extracting it"
rpm2cpio "/tmp/""${RPM_NAME}" | cpio -idmv 1>&2
