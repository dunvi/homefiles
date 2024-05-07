echo "Reminder: this script must be run with sudo!"

grep -Fq "nix-daemon" /etc/zshrc
if [[ $? == 0 ]]; then
  echo "nix-daemon should be initialized; please debug manually"
  exit 1
fi

echo "if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then" >> /etc/zshrc
echo "  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'" >> /etc/zshrc
echo "fi" >> /etc/zshrc
