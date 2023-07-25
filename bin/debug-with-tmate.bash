mkdir -p ~/.ssh

curl -s https://github.com/$GITHUB_ACTOR.keys \
  > ~/.ssh/authorized_keys

echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFxda6OaXjau0Oup7wUbYTsL2G6+ivnps9bqPwmCr9os olaf@olafs-imac.lan' \
  >> ~/.ssh/authorized_keys

echo y |
  ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa

export CHERE_INVOKING=1

tmate -S /tmp/tmate.sock -a ~/.ssh/authorized_keys new-session -d
tmate -S /tmp/tmate.sock wait tmate-ready

set +x
while [[ -e /tmp/tmate.sock ]]; do
  tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}'
  sleep 5
done
