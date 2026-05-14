# Dev environment setup

Spec for reproducing this terminal/shell/editor setup on a fresh machine.
Tracked by yadm at `git@github.com:jamyspex/dotfiles.git` — `yadm clone` will
pull in `.zshrc`, `.aliases.sh`, `.tmux.conf`, the neovim Lua config under
`.config/nvim/`, etc. This spec covers the binaries and bootstrap steps that
yadm doesn't handle.

## Target platform

- **OS:** Ubuntu 22.04 LTS (jammy), running under WSL2 on Windows.
- **Shell:** zsh 5.9 (from Homebrew, not apt — apt's zsh is also installed but not used).
- **Architecture:** x86_64.

Most of this should work on native Linux or macOS with minor path adjustments
(e.g. Homebrew prefix on macOS is `/opt/homebrew` rather than
`/home/linuxbrew/.linuxbrew`). The WSL-specific bits are called out below.

## Big picture

| Layer            | Tool                                                    |
|------------------|---------------------------------------------------------|
| Terminal (Win)   | Windows Terminal — settings in `windows_terminal_settings.json` |
| Terminal (Linux) | Alacritty config in `.alacritty.yml` (unused on WSL host) |
| Multiplexer      | tmux 3.2a (with TPM)                                    |
| Shell            | zsh + oh-my-zsh + antibody plugin manager               |
| Prompt           | starship                                                |
| Editor           | Neovim 0.11.6 (with Packer + Mason + blink.cmp)         |
| Dotfile mgr      | yadm                                                    |
| Pkg managers     | apt, Homebrew (linuxbrew), cargo, pnpm                  |

## Bootstrap order

### 1. Base apt packages

```bash
sudo apt update
sudo apt install -y \
  build-essential curl unzip git zsh \
  apt-transport-https ca-certificates gnupg lsb-release \
  pkg-config libssl-dev jq direnv \
  openjdk-17-jdk
```

External apt repos to add (each provides its own keyring + sources list — follow
each project's "install on Ubuntu" docs):

- `azure-cli`
- `docker-ce`, `docker-ce-cli`, `containerd.io`, `docker-compose-plugin`
- `dotnet-sdk-8.0` (via Microsoft `packages-microsoft-prod`)
- `tailscale`
- `ngrok`

### 2. Homebrew (linuxbrew)

The bulk of CLI tooling comes from Homebrew, not apt — keep this in mind when
replicating.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

Then install:

```bash
brew install \
  zsh starship \
  neovim tree-sitter@0.25 luajit universal-ctags \
  tmux \
  fzf fd ripgrep bat the_silver_searcher ast-grep pup \
  yadm \
  node python@3.13 \
  llm auth0 \
  zsh-async
```

After installing fzf via brew, run its key-binding installer (or just rely on
`source <(fzf --zsh)` from `.zshrc`).

### 3. Rust toolchain (rustup, not brew)

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Cargo-installed binaries (these are pulled from `~/.cargo/bin` and override
brew/apt versions in some places — keep them):

- `exa` — used as `ls` replacement in `.aliases.sh`
- `delta` — git pager
- `zoxide` — directory jumper, hooked into zsh

```bash
cargo install exa git-delta zoxide
```

### 4. Node toolchain

Node comes from Homebrew. Then:

```bash
npm i -g pnpm corepack @yaakapp/cli
```

(`npm`, `node`, `pnpm`, `corepack` end up under
`/home/linuxbrew/.linuxbrew/bin`. `pnpm`'s global bin is `~/.local/share/pnpm`,
which `.zshrc` adds to PATH.)

### 5. oh-my-zsh + antibody

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
```

`.zshrc` expects antibody on PATH and uses `~/.zshplugins` as the bundle list.
First shell launch will materialise `~/.zsh_plugins.sh`.

### 6. yadm clone of this repo

```bash
yadm clone git@github.com:jamyspex/dotfiles.git
yadm checkout master
```

(If yadm reports conflicts with files already in `$HOME`, move them aside and
re-run `yadm checkout master`.)

### 7. tmux plugin manager

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then inside tmux: `prefix + I` (prefix is `Ctrl-a`, not `Ctrl-b`) to install
plugins listed in `.tmux.conf`.

### 8. Neovim plugin bootstrap

Neovim uses Packer. Bootstrap it manually:

```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

Then open `nvim` and run:

- `:PackerSync` — installs all plugins listed in `lua/custom/packer.lua`.
- Mason will auto-install `lua_ls` and `rust_analyzer` on first LSP attach.
- Treesitter parsers compile on demand via `:TSUpdate`.

The jellybeans colourscheme is loaded in `init.lua`; if it errors on first
launch, finish `:PackerSync` first and reopen.

## Component breakdown

### Shell — zsh + oh-my-zsh + antibody

- `$ZSH` points to `~/.oh-my-zsh` (the hard-coded path also has a `simon` macOS
  branch for a work machine).
- Oh-my-zsh theme is **disabled** (`ZSH_THEME=""`) — starship is the prompt.
- Only the built-in `git` plugin is loaded via oh-my-zsh; all other plugins are
  managed by **antibody** from `~/.zshplugins`:
  - `supercrabtree/k` — fancy `ls` with git status
  - `zsh-users/zsh-syntax-highlighting`
  - `zsh-users/zsh-completions`
  - `zsh-users/zsh-autosuggestions`
- Tools hooked into the shell:
  - `starship init zsh`
  - `zoxide init zsh`
  - `direnv hook zsh`
  - `fzf --zsh` (key bindings + completion)
- `$FZF_DEFAULT_COMMAND` / `$FZF_CTRL_T_COMMAND` both use `rg --files` so fzf
  respects gitignore by default.
- `$EDITOR=nvim`.
- PATH additions (in order): cargo, linuxbrew, `/usr/local/go/bin`,
  `~/go/bin`, `~/bin`, `~/.local/bin`, `/opt/mssql-tools/bin`,
  `~/.dotnet/tools`, `/snap/bin`, `~/.opencode/bin`, `$PNPM_HOME`.

### Aliases (`.aliases.sh`)

Sourced from `.zshrc`. Currently:

- `n` / `vi` / `vim` → `nvim`
- `ls` family → `exa` (if installed) — `ls`, `ll`, `la`, `l` all aliased
- `t` → `tmux attach`
- `jupyter-notebook` → no-browser variant
- `python` → `python3`

### Prompt — starship

No custom `~/.config/starship.toml` — running the default preset. If you want
to match exactly, do nothing.

### tmux

- Prefix remapped from `C-b` to `C-a`.
- Vim-style mode keys; pane splits bound to `|` and `-`.
- `christoomey/vim-tmux-navigator` integration: `Alt-h/j/k/l` move between tmux
  panes AND vim splits seamlessly. The `is_vim` / `is_fzf` probes in
  `.tmux.conf` handle pass-through.
- Mouse on, focus events on.
- `default-terminal "screen-256color"` (works under WSL; on modern terminals
  consider `tmux-256color`).
- TPM plugins:
  - `tmux-plugins/tpm`
  - `tmux-sensible`
  - `tmux-yank`
  - `tmux-copycat`
  - `tmux-logging`
  - `christoomey/vim-tmux-navigator`
  - `NHDaly/tmux-better-mouse-mode`
- **WSL clipboard:** `.tmux.conf` sources `.tmux.wsl.conf` only when
  `/proc/version` contains `Microsoft`. The WSL file pipes copy-mode yanks to
  `/mnt/c/Windows/System32/clip.exe`. On non-WSL hosts this file is ignored,
  so leave it in place.

### Neovim (`~/.config/nvim`)

Layout:

```
~/.config/nvim/
  init.lua            -- requires custom.*, sets colourscheme jellybeans,
                     -- configures lualine with LSP/diagnostics in lualine_x.
  filetype.lua        -- custom filetype detection
  lua/custom/init.lua
  lua/custom/packer.lua  -- plugin list (see below)
  lua/custom/remap.lua   -- keymaps; leader is <Space>
  lua/after/plugin/telescope.lua
  plugin/packer_compiled.lua  -- generated; re-created by :PackerSync
```

Plugins via Packer (`lua/custom/packer.lua`):

- packer.nvim, plenary.nvim
- nvim-treesitter (auto-runs `:TSUpdate`); includes a custom `jet` parser
  pointing at `/home/james/streemit/jet/inlet/` — **delete or repoint this if
  cloning to a new machine**, otherwise `:TSUpdate` will fail.
- jellybeans colourscheme (`nanotech/jellybeans.vim`)
- github/copilot.vim
- telescope.nvim (tag 0.1.8) + fzf.vim
- lualine.nvim + nvim-web-devicons
- vim-tmux-navigator, vim-tmux-focus-events, vim-tmux-clipboard
- vim-fugitive
- blink.cmp (built from source via `cargo build --release`) + friendly-snippets
- mason.nvim + mason-lspconfig + nvim-lspconfig — auto-installs `lua_ls` and
  `rust_analyzer`
- tiny-inline-diagnostic.nvim, rust-tools.nvim
- conform.nvim with stylua (2-space indent) on save for Lua

Keymaps worth knowing (leader = `<Space>`):

- `<leader>pv` — `:Ex` netrw
- `<CR>` — clear search highlight
- `<leader>ff` / `fg` / `fb` — fzf Files / Rg / Buffers
- `<leader>fh` / `fs` / `fd` — telescope help / symbols / diagnostics
- `<leader>xx` / `xw` / `xd` / `xq` / `xl` — trouble toggles
- `gR` — trouble lsp_references
- `]d` / `[d` — diagnostic next/prev
- `]b` / `[b` — buffer next/prev
- `<C-c>` (visual) — copy to system clipboard
- `<leader>rn` — LSP rename

Autocmd: trims trailing whitespace on save for all filetypes.

### Editor terminal — Windows Terminal

`windows_terminal_settings.json` is tracked. Copy it to
`%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json`
on the Windows side. (`yadm` only manages `$HOME` on the Linux side, so this
copy is manual.)

### Alacritty

`.alacritty.yml` is tracked but currently unused on this host (Windows
Terminal is the active terminal). Kept for portability to a Linux GUI host.

## Files tracked by yadm

```
.alacritty.yml
.aliases.sh
.config/nvim/.vim/ftplugin/jet.vim      (removed in this branch)
.config/nvim/coc-settings.json          (removed in this branch — switched off coc)
.config/nvim/colors/monokai_pro.vim     (removed in this branch)
.config/nvim/filetype.vim               (removed in this branch — replaced by filetype.lua)
.config/nvim/init.vim                   (removed in this branch — replaced by init.lua)
.oh-my-zsh/lib/directories.zsh
.oh-my-zsh/lib/theme-and-appearance.zsh
.tmux.conf
.tmux.wsl.conf
.vimrc                                  (removed in this branch — nvim only)
.zshplugins
.zshrc
windows_terminal_settings.json
SETUP.md                                (this file)
```

The init.lua-based nvim config under `.config/nvim/{init.lua,filetype.lua,lua/,plugin/}`
is **not currently tracked by yadm** — it should be. Add it after cloning:

```bash
yadm add ~/.config/nvim/init.lua ~/.config/nvim/filetype.lua
yadm add ~/.config/nvim/lua ~/.config/nvim/plugin/packer_compiled.lua
```

(`packer_compiled.lua` is generated, so tracking it is optional — easier to
just run `:PackerSync` after cloning.)

## Things to watch out for on a new machine

- Assumes username `james` (matches `.zshrc`'s `ZSH=/home/james/.oh-my-zsh`
  path). Create the WSL user as `james` and most paths just work.
- The `jet` treesitter parser in `lua/custom/packer.lua` points at
  `/home/james/streemit/jet/inlet/`. If that repo isn't cloned on the new
  machine, comment out the `parser_config.jet` block in `init.lua` or
  `:TSUpdate` will error.
- `.tmux.wsl.conf` only activates when `/proc/version` matches `Microsoft`,
  so leaving it in place on non-WSL hosts is safe.

## Quick verify checklist

After bootstrap, sanity-check:

```bash
zsh --version        # 5.9 from /home/linuxbrew/.linuxbrew/bin
tmux -V              # 3.2a
nvim --version       # 0.11.x
starship --version
yadm status          # should be clean on master
which exa zoxide delta
```

In nvim: `:checkhealth` should be mostly green; treesitter, telescope, mason,
blink.cmp, fzf, lspconfig all need to report OK.

In tmux: `Ctrl-a I` should fetch all TPM plugins without errors.
