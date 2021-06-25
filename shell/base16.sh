export BASE16_SHELL="$HOME/.base16-manager/chriskempson/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
            eval "$("$BASE16_SHELL/profile_helper.sh")"

export THEME="bright"
#export THEME="atlas"
#export THEME="heetch"
#export THEME="irblack"
#export THEME="black-metal"
#export THEME="black-metal-immortal"
#export THEME="black-metal-bathory"
#export THEME="chalk"
#export THEME="porple"
#export THEME="outrun-dark"
#export THEME="porple"
#export THEME="rebecca"
#export THEME="greenscreen"
#export THEME="synth-midnight-dark" # sweeet
#export THEME="flat"
#export THEME="unikitty-light"
#export THEME="unikitty-dark"
#export THEME="harmonic-dark"
#export THEME="harmonic-light"
#export THEME="papercolor-dark"
#export THEME="papercolor-light"
#export THEME="macintosh"
#export THEME="outrun-dark"

function has-theme() {
	base16-manager list-themes | grep $THEME$1
}

function dark() {
	export BACKGROUND="dark"
	if has-theme "-dark"
	then
		base16-manager set $THEME-dark
	else
		base16-manager set $THEME
	fi
}

function light() {
	export BACKGROUND="light"
	if has-theme "-light"
	then
		base16-manager set $THEME-light
	else
		base16-manager set $THEME
	fi
}

function theme() {
	export THEME=$1 
	if $BACKGROUND = "light"
		then light
		else dark
	fi
}

function themes() {
	base16-manager list-themes | less
}

dark
