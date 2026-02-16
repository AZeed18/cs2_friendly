cd "$(dirname "$0")"

if [ "$(crc32 steam.inf)" != "$(cat friendly.crc32 2>/dev/null)" ]; then
	crc32 steam.inf > friendly.crc32
	cp pak01_dir.vpk pak01_dir.vpk.bak
	mv ../bin/win64/vpk.signatures ../bin/win64/vpk.signatures.bak

	cd friendly
		args=
		echo "Installing mod..."
		for folder in $(find . -type d -maxdepth 1); do
			if [ "$folder" != "." ] && [ "$folder" != "./_iconcache" ]; then
				for file in $(find "$folder" -type f | cut -c3-); do
					args="$args--remove-file $file "
				done
			fi
		done
	cd ..

	echo -n $args | xargs -n200 "C:\Program Files\VPKEdit\vpkeditcli.exe" pak01_dir.vpk >/dev/null
	echo "Finished removing assets references"
	echo -n 'Open gameinfo.gi and add "Game csgo/friendly" beside any other "Game" then press Enter...'; read
fi

explorer steam://launch/730
