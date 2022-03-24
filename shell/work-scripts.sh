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
    gh pr create & gh pr view --json title,url
    success=$?

    pr_json=`gh pr view --json title,url,author,labels`
    echo $pr_json

    title=`valueFromJson $pr_json title`
    url=`valueFromJson $pr_json url`

    message="Connor has a new PR available for review:\n\t *$title* \n\t$url"

    if [ $success ]; then 
        curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$message\"}" https://hooks.slack.com/services/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 || echo "Create PR failed"
    fi
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
        yarn deploy -r "$1" -e "$2" -p "$2"
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

alias ecl='ec aws creds login; ec yarn login; assume; assume dev'
alias ex-nc='cd ~/node-core'
alias ex-cl='cd ~/client'
alias ex-ci='cd ~/client-integrations'
alias ex-sdk='cd ~/extend-sdk-client'
alias yd='yarndeploy'
alias ydr='yarndeployrebuild'
alias ydl='yarndeploylambdas'
