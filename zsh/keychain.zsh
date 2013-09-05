# Start up ssh-agent and gpg-agent
if [ -f ~/.ssh/id_dsa ]; then
    eval `keychain --eval --agents ssh --inherit any id_dsa`
fi
