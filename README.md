# motodo

A tiny todo list that greets you in your terminal on login — **mo**td + to**do**.

No daemon, no database, no dependencies beyond `bash`, `awk`, and `date`. Your
tasks live in a single plain-text file (`~/.todos`), and open ones print as a
compact banner every time you open a login shell (e.g. SSH into a server).

```
  ┏━ TODO ━ 3 open ━━━━━━━━━━━━━━━━━━━━━━━━━━
  ○ Rename originals-dev minions off the -temp0N scheme   due 2026-07-10
  ○ ci.appsumo.com reverse proxy                          due today
  ○ jenkins reverse proxy
  ┗━ edit with: todo add/done/rm
```

Overdue tasks show in **red**, due-today in **yellow**, future dates dimmed.
When nothing is open, the banner prints nothing — no clutter.

## Install

```bash
git clone https://github.com/Goldcap/motodo.git
cd motodo
./install.sh
```

The installer copies `todo` into `~/.local/bin` and adds a one-line banner hook
to your `~/.bash_profile` (idempotent — safe to re-run). Make sure
`~/.local/bin` is on your `PATH`.

Prefer to do it by hand? Just drop `todo` somewhere on your `PATH` and add this
to your `~/.bash_profile`:

```bash
case $- in *i*) command -v todo >/dev/null 2>&1 && todo banner ;; esac
```

## Usage

| Command | What it does |
|---|---|
| `todo` | List open tasks |
| `todo add "text"` | Add a task |
| `todo add "text" --due 2026-07-15` | Add with a due date (also `tomorrow`, `"next monday"`, …) |
| `todo done <id>` | Mark a task complete |
| `todo rm <id>` | Delete a task |
| `todo all` | List open **and** completed |
| `todo banner` | The login banner (prints nothing if no open tasks) |
| `todo --help` | Help |

Due dates accept anything GNU `date -d` understands.

## Data format

`~/.todos`, one task per line, pipe-delimited:

```
id|status|added|due|text
```

`status` is `open` or `done`; `due` is `YYYY-MM-DD` or `-`. It's just text —
edit it in any editor, grep it, sync it, whatever. Override the location with
`TODO_DB=/path/to/file`.

## License

MIT — see [LICENSE](LICENSE).
