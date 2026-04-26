# dotfiles

My personal dotfiles managed with GNU Stow.

## Structure

Each directory is a stow package:
- zsh/
- nvim/
- sway/
- waybar/
- etc.

## Usage

Clone repo:

``` sh
git clone <repo> ~/dots
```

Then stow what you need:

``` sh
cd ~/dots
stow zsh nvim sway waybar
```

Or, use the `install.sh`:

``` sh
./install.sh
```

> [!WARNING]
> If you already have existing config files, be sure to back them up before running it. Otherwise, you will lose them if you run the installer.

## Notes

- Some configs assume specific packages to be installed.
- Some might require manual and additional setup (such as Emacs, Antidote for ZSH etc.)

## Packages

See `pkg/arch.txt` for reference (Arch-based systems).

## Manual Setup

Manual setup scripts are in `setup_scripts` directory. Check them out.

> [!NOTE]
> All setup scripts should be run AFTER the dots are placed in correct places. Otherwise, they'll be unpredictable.
