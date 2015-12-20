test -r ~/.alias && . ~/.alias
PS1='GRASS 7.1.svn (Mapy):\w > '
grass_prompt() {
	LOCATION="`g.gisenv get=GISDBASE,LOCATION_NAME,MAPSET separator='/'`"
	if test -d "$LOCATION/grid3/G3D_MASK" && test -f "$LOCATION/cell/MASK" ; then
		echo [2D and 3D raster MASKs present]
	elif test -f "$LOCATION/cell/MASK" ; then
		echo [Raster MASK present]
	elif test -d "$LOCATION/grid3/G3D_MASK" ; then
		echo [3D raster MASK present]
	fi
}
PROMPT_COMMAND=grass_prompt
export PATH="/home/ludka/src/grass7_trunk/dist.x86_64-unknown-linux-gnu/bin:/home/ludka/src/grass7_trunk/dist.x86_64-unknown-linux-gnu/scripts:/home/ludka/.grass7/addons/bin:/home/ludka/.grass7/addons/scripts:/home/ludka/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export HOME="/home/ludka"
