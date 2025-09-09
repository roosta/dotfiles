# Dotfiles

A collection of config files I use on a daily basis on multiple hosts. My OS of
choice is [Arch Linux](https://www.archlinux.org/).

> [!NOTE]
> More documentation TBD

### Git hooks

Make sure dependencies `pre-commit` and `gitleaks` are installed via
`.dependencies.yml` or install manually.

```bash
GIT_DIR=$HOME/.dotfiles/ GIT_WORK_TREE=$HOME pre-commit install
```

## License

[GPLv3](LICENSE)
