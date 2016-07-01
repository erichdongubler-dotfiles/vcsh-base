# LDS-specific stuff

function touch-existing() {
	ls $* | tee /dev/tty | xargs touch
}