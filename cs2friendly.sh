cd "$(dirname "$0")"

if [ "$(crc32 steam.inf)" != "$(cat friendly.crc32 2>/dev/null)" ]; then
	crc32 steam.inf > friendly.crc32

	cp pak01_dir.vpk pak01_dir.vpk.bak
	mv gameinfo.gi gameinfo.gi.bak
	mv ../bin/win64/vpk.signatures ../bin/win64/vpk.signatures.bak

	echo "Installing mod..."

	cat friendly/friendly.txt | sed -n 's/\.\//--remove-file /p' | xargs -n200 "C:\Program Files\VPKEdit\vpkeditcli.exe" pak01_dir.vpk >/dev/null
	echo "Removed assets references"

	sed -E 's/^(\s*Game\s)(csgo\s*)$/\1csgo\/friendly\n\1\2/' gameinfo.gi.bak > gameinfo.gi
	echo "Added mod to gameinfo.gi"
fi

explorer steam://launch/730
