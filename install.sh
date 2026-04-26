#!/usr/bin/env sh
set -e

cd ~/dots

for package in */; do
    package="${package%/}"
    stow -v "$package"
done

echo "Done. Restart shell."
