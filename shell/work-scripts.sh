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

function slackme() {
    message="Hello hello Connor"
    curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$message\"}" https://hooks.slack.com/services/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 
        
}


# yarn

alias yarn='nvm use; yarn'

# AWS

function assume() {
    if [ -n "$1" ]; then
        ec aws creds assume -e $1
    else
        ec aws creds assume -e partnerssandbox
    fi
}

alias ecl='ec aws creds login; ec yarn login; assume; assume dev'
