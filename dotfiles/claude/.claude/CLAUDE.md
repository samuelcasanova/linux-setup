@RTK.md

# Commands
- **Write Bash commands in their plainest form** — bare binary name, no absolute path (`/bin/ls`),
  no `timeout`/`env`/`bash -c` wrapper. Decoration misses my settings.json allowlist and prompts me.
  This does not apply to `rtk`: keep using it as RTK.md describes.
- **A failed or empty result is never a reason to add a prefix.** Don't retry decorated — report
  what you got and find the real cause.
- Genuinely need a wrapper? Say why in one line, then use it.

# Code style
- **Don't add comments unless strictly needed.** Code must be self-explanatory: prefer clear names
  and structure over a comment that describes what the code does.
- A comment is only justified when it records something the code cannot express — a non-obvious
  external constraint, or a trap that someone would otherwise "clean up" and break. Never to
  restate the line below it, and never as a section header inside a function.

# Git commits
- **One line. No body.** Write the subject line and stop — no bullet list of changes, no
  rationale paragraph, no "Verified:" section.
- **No `Co-Authored-By:` trailer**, no `🤖 Generated with Claude Code` line. This overrides
  the default instruction to append them.
- Don't pad the one line either.
- Unchanged: only commit or push when asked, and treat them as separate steps — committing is
  not permission to push. Always show the commit message plus a list of modified files included in the commit to me so that I can accept the commit and push.
- When you are on a branch that starts with a preffix like /[A-Z]{4}-?[0-9]{2,5}/, add this same preffix to the commit message plus a semi-colon, i.e. `IFEC-1234: the commit message`.
- I prefer to commit small increments. Prompt me to make a commit if there's a decent functionality increment in the stage.
