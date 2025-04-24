![git_title](https://raw.githubusercontent.com/roosta/assets/master/etc/git_title.png)

## Config

Besides from the more run of the mill here are some notable options:

### Global ignore

Some things you just want ignored regardless of repository. Put it in
`~/.globalignore` and define it using the config option in `core`'s
`exclude-file`

### Credential

It says use cache in the config, but currently I use [Gnome
Keyring](https://wiki.gnome.org/Projects/GnomeKeyring) to manage my
credentials. I've used a bunch of agents in the past and the remnants of that
can be found
[here](https://github.com/roosta/etc/blob/master/conf/zsh/.zsh.d/agent.zsh).
All told though I find Gnome Keyring works well.

### Diffing

I use a bunch of different tools for diffing and merge resolving.
[Magit](https://github.com/magit/magit) and other Emacs git tools are quite
amazing, but I haven't used Emacs that long so still getting familiar with the
Emacs side of things. Vimdiff and
[vim-fugitive](https://github.com/tpope/vim-fugitive) as a git wrapper are also
good options. And lastly I often turn to [Meld](http://meldmerge.org/) if I
need to go full GUI.

### Aliases

#### wd

Show the word difference, which words have changes, not lines. Makes it easier
to pick out a change sometimes.

#### precommit

Used to use this a lot, it just shows the diff on what you currently have
staged before committing. Ever since git included the commit option `verbose` I
haven't really needed this alias anymore. With the verbose option set you get
the diff for the current commit in your commit message

#### logs

Log short, print abbreviated SHA - (ref name) commit subject (time since
commit) <author> and would look something like this:

![git_logs](https://raw.githubusercontent.com/roosta/assets/master/etc/git_logs.png)

I did not author this one, and don't remember where I originally got it but it
seems it's circulating various sites like stackoverflow and blogs.

#### logd

Diff log, get the diff on your entire commit history. Used mainly to search for
something that might have gotten lost in a previous commit.

#### logl

Same as above with some extra info. Full commit message and changes done to
files. That would look something like this:

![git_logl](https://raw.githubusercontent.com/roosta/assets/master/etc/git_logl.png)


#### last

View the full commit message from the last commit

#### ctags

Manually run the ctag hook. More below.

#### Remainder

Nothing really interesting for the remaining aliases, just shorthand for
various basic operations i do often.

### Hooks

I used to run a hook on commit, merge and rebase that would generate new
[ctags](http://ctags.sourceforge.net/). I currently don't use this anymore
since I found a nice vim plugin that deals with this called
[Gutentags](https://github.com/ludovicchabant/vim-gutentags).

I've kept the config though since I thought that was a neat idea.

And the idea is not mine, I found it on
[here](http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html)
originally. Also see .git<sub>templates</sub> for the hooks and script

Relevant files:

- [post-merge](.git_template/hooks/post-merge)
- [post-checkout](.git_template/hooks/post-checkout)
- [post-commit](.git_template/hooks/post-commit)
- [post-merge](.git_template/hooks/post-rewrite)
- [ctags script](.git_template/hooks/ctags)

## Fzf

Another subject worth touching on is various
[fzf](https://github.com/junegunn/fzf) functions I use on a regular basis.

I find them particularly useful if you are dealing with long namespaces or a
convoluted directory structure where just typing the path is a chore. Or
otherwise with commands that tend to get rather verbose.

Some of these are grabbed wholesale from the [fzf
wiki](https://github.com/junegunn/fzf/wiki/Examples), worth having a look
there. Lots of cool fzf functions.

[fzf](https://github.com/junegunn/fzf) is an awesome tool and definitely worth
checking out.

See [here](../zsh/.zsh.d/plugin_conf/fzf.zsh) for the function definitions.
They are loaded with [zsh](../zsh/.zshrc).

### fadd

List all unstaged files, and add the ones selected. Supports multiselect via
`tab` as default mapping.

### funstage

Unstage chosen files. Supports multiselect via `tab` as default mapping.

### fdiscard

Discard selected files unstaged changes. Supports multiselect via `tab` as
default mapping.

### fco

Will list all branches and tags and `checkout` selected.

### fcoc

List all commits and `checkout` selected. Useful if you need to walk back in
history, but unsure which commit you're looking for. Also saves you a lot of
typing either way.

### fdiff

List all commits and show diff for selected.

### fsha

Show abbreviated `SHA` for selected commit.

Example usage:
```shell
git rebase -i `fsha`
```
### fstash

Easier way to deal with stashes. Type `fstash` to get a list of your stashes.
`enter` shows you the contents of the stash. `ctrl-d` shows a diff of the stash
against your current `HEAD`, `ctrl-b` checks the stash out as a branch, for
easier merging.

## Other tools

These are some other tools I found useful.

### Git extras

Just a ton of useful git functions, and definitely worth a look

[tj/git-extras: GIT utilities -- repo summary, repl, changelog population, author commit percentages and more](https://github.com/tj/git-extras)

### Hub

A git wrapper that adds useful github spesific commands like dealing with
issues, pull-requests and such from the comfort of your commandline.

[hub · the command-line wrapper for git](https://hub.github.com/)
