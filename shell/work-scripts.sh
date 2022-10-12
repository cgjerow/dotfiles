export DEFAULT_SANDBOX=partnerssandbox
export DEFAULT_SERVICE=in-store

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
    gh pr create -t "$1" -b "$1" && gh pr view -w
}

function ghv() {
    gh pr view -w
}


# yarn

alias yarn='nvm use; yarn'

# AWS

function assume() {
    if [ -n "$1" ]; then
        ec aws creds assume -e $1
    else
        ec aws creds assume -e $DEFAULT_SANDBOX
    fi
}

function yarndeploy() {
    if [ -n "$2" ]; then
        ec service deploy --service "$1" --env "$2"  --version "$(git symbolic-ref HEAD)"
    else
        if [ -n "$1" ]; then
            yarndeploy "$1" $DEFAULT_SANDBOX
        else
            yarndeploy $DEFAULT_SERVICE
        fi
    fi
}

function yarndeployrebuild() {
    if [ -n "$2" ]; then
        yarn deploy -r "$1" -e "$2" -p "$2" -l "$1"
    else
        if [ -n "$1" ]; then
            yarndeployrebuild "$1" $DEFAULT_SANDBOX
        else
            yarndeployrebuild $DEFAULT_SERVICE
        fi
    fi
}

function yarndeploylambdas() {
    if [ -n "$2" ]; then
        yarn deploy:lambdas -e "$2" -c "$1" --skip-git-check
    else
        yarn deploy:lambdas -e $DEFAULT_SANDBOX -c "$1" --skip-git-check
    fi
}

alias ecc='ec aws console -e '
alias okl='ec okta login & (sleep 2.5; open -a Terminal)'
alias ecl='ec aws creds login; (ec yarn login & assume & assume dev)'
alias pbl='ec aws creds login -l extend_global_package_publisher && ec yarn login'
alias accs='cd ~/accounts-service'
alias ex-nc='cd ~/node-core'
alias ex-acc='cd ~/accounts-service'
alias ex-cl='cd ~/client'
alias ex-ci='cd ~/client-integrations'
alias ex-sdk='cd ~/extend-sdk-client'
alias yd='yarndeploy'
alias ydr='yarndeployrebuild'
alias ydl='yarndeploylambdas'
