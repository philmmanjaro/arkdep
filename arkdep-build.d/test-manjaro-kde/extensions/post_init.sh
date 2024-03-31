#!/bin/sh

# Add user
mkdir -p ${worktmp}/imgp2/arkdep/shared/home/user
cat <<-EOF > ${worktmp}/imgp2/arkdep/shared/home/user/.zshrc
# Use powerline
USE_POWERLINE="true"
# Has weird character width
# Example:
#    is not a diamond
HAS_WIDECHARS="false"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi
EOF
chown -R 1000:1000 ${worktmp}/imgp2/arkdep/shared/home/user

# Ensure passwd/group/shadow permissions are set properly
chmod 600 $variantdir/overlay/post_init/etc/shadow
chmod 644 $variantdir/overlay/post_init/etc/{passwd,group}
# Write $variantdir/overlay/post_init
for f in $(ls $variantdir/overlay/post_init/); do
	cp -rv $variantdir/overlay/post_init/$f ${worktmp}/imgp2/arkdep/overlay/
done
