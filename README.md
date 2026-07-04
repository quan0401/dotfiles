# dotfiles

Personal macOS dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/).

Each top-level directory is a **stow package** whose contents mirror the layout of
`$HOME`. Stowing a package creates symlinks from `$HOME` back into this repo, so the
repo stays the single source of truth and edits are version-controlled.

## Layout

| Package       | Symlinks to              | What it is                              |
| ------------- | ------------------------ | --------------------------------------- |
| `zshrc`       | `~/.zshrc`               | Zsh interactive shell config            |
| `zprofile`    | `~/.zprofile`            | Zsh login-shell config (PATH, env)      |
| `bashrc`      | `~/.bashrc`              | Bash interactive shell config           |
| `bash_profile`| `~/.bash_profile`        | Bash login-shell config                 |
| `tmux`        | `~/.tmux.conf`           | tmux config                             |
| `nvim`        | `~/.config/nvim`         | Neovim config (Lua, `quan0401` namespace) |
| `nnn`         | `~/.config/nnn`          | nnn file manager (plugins, bookmarks)   |

`ignore-folder/` is scratch space and is git-ignored.

## Install

Requires [Stow](https://www.gnu.org/software/stow/) (`brew install stow`).

```bash
git clone git@github.com:quan0401/dotfiles.git ~/dotfiles
cd ~/dotfiles

# stow everything
stow -t ~ zshrc zprofile bashrc bash_profile tmux nvim nnn

# or a single package
stow -t ~ zshrc
```

`-t ~` sets the symlink target to your home directory. If a real file already exists
at a target path (e.g. an existing `~/.zshrc`), stow refuses to overwrite it — move or
delete the original first, then re-run.

## Update

Files are symlinks, so edit them anywhere (`~/.zshrc` or `zshrc/.zshrc` — same file),
then commit from the repo:

```bash
cd ~/dotfiles
git add -A && git commit -m "update config" && git push
```

## Remove

```bash
cd ~/dotfiles
stow -D -t ~ zshrc        # unstow one package (removes its symlinks)
```

## Notes

- **Neovim**: Lua config under `nvim/.config/nvim/lua/quan0401/` — LSP via mason,
  completion via nvim-cmp, plus telescope, treesitter, gitsigns, copilot, which-key.
  Plugin versions pinned in `lazy-lock.json`.
- **nnn**: bundled plugins in `nnn/.config/nnn/plugins/` (preview-tui, fzcd, nuke, …).
- No secrets are committed here — keep API keys and tokens out of these files
  (this repo is on GitHub).
