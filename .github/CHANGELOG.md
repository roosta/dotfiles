Change log
==========

All notable changes from to this project from version `v0.1.0` forward will be
documented in this file.

## [Unreleased]

Nothing yet

## [v0.2.0] - 2026-08-11

This release spans a large refactor of the Hyprland config to Lua, a heavily
reworked Quickshell (launcher, bar, notifications, wallpaper), and a Neovim
migration to modern native/Lua-based tooling.

### Hyprland
#### Config migration to Lua

- Converted the entire Hyprland config (including monitor/layout files) from
  conf to Lua, split folds into separate files, and normalized messily-grouped
  sections.
- Moved monitor script logic into layout config files, keeping only the file
  operation in the script
- Added a monitor-readiness utility + `collect_workspaces` to fix special
  workspaces not transferring between monitors.
- Replaced the media-menu toggle script with Lua that reacts to fullscreen
  state + `content_type`/class.

#### Display stability

- Fixed issues with session crashing on layout switch. The issue was the `ln
  -sf` operation when swapping symlinked monitor configs for hyprland resulted
  in two separate syscalls, which each reloaded hyprland due to autoreload
  being enabled, resulting in a state where there were no monitors for a split
  second.

#### Binds, rules & misc

- Reworked binds: maximize → `super+return`, terminal → `super+q`,
  notifications back to `home`; fixed missing media keys; enabled group cycle;
  menu toggle bind.
- Removed `hyprexpo` (unmaintained), disabled `hyprpm reload`.
- New window rules: big-picture focus, kdialog, satty class fix; improved
  special-workspace visuals (blur, gaps, rounding).
- Fixed Kando binds (previously crashed the compositor), disabled cursor warps,
  adjusted groupbar styling.

### Quickshell
#### Launcher (major rework)

- Redesigned item cards (taller/narrower, centered content) fitting more
  entries, with drop shadows, quad corners, and improved icon borders.
- Merged the launcher field + combo box into a single transforming button that
  expands into a text field; removed the now-redundant `LauncherField`/menu
  wrapper and old favorites.
- Added an **actions area** per item with full keyboard navigation (up to open,
  down to close, left/right to navigate).
- Reworked menu handling to swap data sources instead of whole components so
  populate animations work correctly.
- Extensive animation work: bouncy add/remove/move transitions, opacity
  transitions, fixed initial card transition, fixed interrupted/overlapping
  animation states, and reworked wheel/pointer handling for usable scrolling.

#### Bar

- New **scratch/special workspace support**: arbitrary number of special
  workspaces, dashed/marching-ants gradient borders, desaturation, gradient
  transitions, and state refactor.
- Added workspace shift buttons, group indicators for same-workspace apps
- Audio button: scrollwheel volume adjustment, expand-on-change, right-click to
  switch sink; wired the audio service directly to Hyprland instead of `wpctl`.
- Notification button redesign, moved position, added separators, enlarged
  clickable/corner areas
- Launcher button visual rework (gradient rect, hover colors, transitions,
  right-click to menu).

#### Notifications

- Added **clear-all / discard** support with global shortcuts and a discard
  bind; fixed numerous timer bugs (firing on discarded/void entries, race on
  manual close, dangling timers).
- Fired default action on toast + launcher; reworked status-light daemon after
  a firmware rewrite (daemon now only forwards commands).

#### Wallpaper & components

- Custom wallpaper dimming (darken background, not content); attached darkening
  to `overlayOpen` so it dims with the tray on an empty desktop.
- Switched from exclusion-zone covering to moving the wallpaper on launcher
  open (after experimenting with animated exclusion zones, reverted for
  performance).
- New/reworked components: split gradient border into `GradientRect` +
  transparency-capable `BorderRect`, dashed gradient option, triangle gradient
  stroke, quad corners/diagram work, `ExpandingButton` click handlers.
- Renamed `Appearance` → `Style`; `hardBlack` replaces custom `darkBlack`.

### Neovim
#### Migration to native / modern tooling (nvim 0.12)

- Adjust **nvim-treesitter** (was archived) with native nvim treesitter
  handling; still using parsers
- Removed **comment.nvim** (native support).
- Replaced **lightline → lualine** (lightline broke popup handling post-0.12);
  ported config.
- Replaced **ALE → nvim-lint**; added **mason.nvim**.
- Deprecated several unused plugins (gx.nvim, vim-speeddating,
  vim-visual-increment, git-messenger, vaxe, etc.).

#### Language support & config

- Set up astro + superhtml (LSP + treesitter), added yaml/xml/cpp parsers, more
  astro config.
- Added `:RightAlignTag` and `:Typos` commands, config headers, disabled
  CodeCompanion history.
- CodeCompanion model churn (opus 4.8 / sonnet / fable-5 across the cycle).

### Shell, tooling & misc

- **zsh:** moved local config to untracked `aliases.local.zsh`, replaced npm
  bin with pnpm bin, swapped `tree`→`eza` and `ls` icons, `rcopy` alias, fzf
  path fixes, submodule/plugin updates.
- **Filesystem:** consolidated on `~/.local/bin` over `~/bin` (recreated
  symlinks).
- **New configs / deps:** satty, feishin; btop upgraded to v1.4.7; Kando
  upgraded to v2.3.0; virt-manager added to favs/menus; breeze cursor for
  consistent sizing.
- **Docs:** moved README to `.github/`, added CHANGELOG, fixed/updated links.
- **CI:** updated gitleaks.

### Grouped routine maintenance

- **Neovim plugin updates** — ~25 `nvim/lazy` bumps (codecompanion.nvim,
  nvim-lspconfig, nvim-treesitter, telescope.nvim, mason.nvim,
  nvim-web-devicons, and others).
- **Submodule updates** — srcery (palette/terminal), zsh plugins/completions,
  vivid, git module cleanup.
- **Scripts** — numerous `scripts: update` / sync fixes.
- Assorted whitespace, formatting, and asset/glyph tweaks.

## [v0.1.0] - 2026-04-04

I've ended up calling my setup here for ritual as a spin on srcery. I've not
really considered a release for my dotfiles previously, but its a good way of
adding some additional documentation going forward. Wish I started sooner
because I've gone through some major iterations over the years.

Currently I'm at a point with my Quickshell config that I feel a release is in
order. Some places need ironing, and there are unfinished features. It's at
a point where I'm daily driving it, and every required feature is in place.

I currently got:
- [x] A working bar, with workspace management, tray, volume, keyboard
   indicator and window information. Still features and flair need adding, this
   is the bare minimum I needed to use it.
- [x] Notification system, many features missing, very much WIP, but I needed
   *something* working
- [x] A launcher, handles several menu types, and can launch
   arbitrary things like scripts and desktop entries. It isn't as featured as
   some out there for wayland, but it got everything I need for a launcher so
   far.

[Unreleased]: https://github.com/roosta/yank/compare/v0.2.0...HEAD
[v0.2.0]: https://github.com/roosta/dotfiles/releases/tag/v0.2.0
[v0.1.0]: https://github.com/roosta/dotfiles/releases/tag/v0.1.0
