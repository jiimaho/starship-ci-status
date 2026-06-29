# starship-ci-status

Shows the latest GitHub Actions CI status for your current branch directly in your [Starship](https://starship.rs) prompt.

```
 ~/repos/my-project   main  ✓ home(Fix SLA timer)   ❯
```

Each entry is `<workflow>(<trigger>)` — the workflow name plus the merged PR title or
commit message that triggered the run, so you can tell your own runs from someone else's.

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
curl -fsSL https://raw.githubusercontent.com/jiimaho/starship-ci-status/main/install.sh | bash
```

Then add `${custom.ci_status}` to your format string in `~/.config/starship.toml`:

```toml
format = """
$directory$git_branch$git_status${custom.ci_status}
$character"""
```

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/jiimaho/starship-ci-status/main/uninstall.sh | bash
```

Then remove `${custom.ci_status}` from your format string in `~/.config/starship.toml`.

## Updating

Run the install command again — it replaces the scripts and clears any caches from old versions:

```bash
curl -fsSL https://raw.githubusercontent.com/jiimaho/starship-ci-status/main/install.sh | bash
```
