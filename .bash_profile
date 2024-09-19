# if running in bash
if [ -n "$BASH_VERSION" -a -n "$PS1" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

export GOOGLE_WEB_CLIENT_SECRETS_PATH="/home/bart/Development/GoogleCalendarApp/GoogleCalendarApp/Files/client_secrets.json"
export GARMIN_DEV_KEY="~/.garmin/secrets/developer_key"
