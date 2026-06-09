# starship-ci-status

Shows the latest GitHub Actions CI status for your current branch directly in your [Starship](https://starship.rs) prompt.

```
 ~/repos/my-project   main  ✓ Build and Deploy   ❯
```

| Icon | Meaning |
|------|---------|
| `✓` | Success |
| `✗` | Failure |
| `⟳` | In progress / waiting |
| `○` | Cancelled |

The prompt stays fast — status is fetched in the background and cached for 60 seconds.

## Requirements

- [Starship](https://starship.rs) prompt
- [GitHub CLI](https://cli.github.com) (`gh`) — authenticated (`gh auth login`)

## Install

```bash
git clone https://github.com/jiimaho/starship-ci-status.git
cd starship-ci-status
./install.sh
```

Then add `${custom.ci_status}` to your format string in `~/.config/starship.toml`:

```toml
format = """
$directory$git_branch$git_status${custom.ci_status}
$character"""
```

## Uninstall

```bash
./uninstall.sh
```

Then remove `${custom.ci_status}` from your format string in `~/.config/starship.toml`.

## Updating

```bash
git pull
./install.sh
```

`install.sh` automatically clears caches from old versions when a breaking change is released.
