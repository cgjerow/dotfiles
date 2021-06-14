# Git commands
function gc() {
	git commit -m $1
}

function gs() {
	git status
}

function gl() {
	git log --all --graph --decorate --oneline
}

# Basic commands
function rsrc() {
    source ~/.zshrc
}

function e() {
    $EDITOR "$@"
}

function vi() {
    nvim "$@"
}

function vim() {
    nvim "$@"
}

function l() {
	ls -Ca 
}

function ll() {
	ls -Cla | less
}

function cc() {
	g++ $1 $2
}

source ~/dotfiles/tmux/setup.sh
function ts() {
	tmuxSession $1
}


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

function yt() {
    args=`getopt a "$@"`
    echo [ "$args" == "-a --" ]
    echo "${args[0]}"
    if [ false ]
    then
        yarn test
    else
        yarn test --onlyChanged
    fi
}


function valueFromJson() {
    node -pe 'JSON.parse(process.argv[1])[process.argv[2]]' $1 $2
}


function ghpr() {
    gh pr create & gh pr view --json title,url
    success=$?

    pr_json=`gh pr view --json title,url,author,labels`
    echo $pr_json

    title=`valueFromJson $pr_json title`
    url=`valueFromJson $pr_json url`

    message="Connor has a new PR available for review:\n\t *$title* \n\t$url"

    if [ $success ] 
        curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$message\"}" https://hooks.slack.com/services/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 || echo "Create PR failed"
        
}

function slackme() {
    message="Hello hello Connor"
    curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$message\"}" https://hooks.slack.com/services/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 
        
}
