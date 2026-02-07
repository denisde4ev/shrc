#!/bin/sh

echo >&2 NEVER TESTED
exit 123

[ -f ~/.ssh/sshd/ssh_host_ed25519_key ] || ssh-keygen -t ed25519 -f ~/.ssh/sshd/ssh_host_ed25519_key___test2_ -P ''
[ -f ~/.ssh/sshd/sshd_config ] || {
cat <<-EOF > ~/.ssh/sshd/sshd_config
HostKey ~/.ssh/sshd/ssh_host_ed25519_key


AuthorizedKeysFile	~/.ssh/authorized_keys # todo: should this and all other lines be here or entire /etc/ssh should be here



PasswordAuthentication no

ChallengeResponseAuthentication no

UsePAM yes

Subsystem	sftp	/usr/lib/ssh/sftp-server


PubkeyAcceptedAlgorithms ssh-ed25519,ssh-rsa
EOF
}

# TODO: add your key
#printf %s\\n '#' >> ~/.ssh/authorized_keys

"$(which sshd)" -p 8022 -d -f ~/.ssh/sshd/sshd_config -h ~/.ssh/sshd/ssh_host_ed25519_key
