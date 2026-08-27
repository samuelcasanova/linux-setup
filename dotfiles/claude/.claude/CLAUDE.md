@RTK.md

# Commands
- Only use workarounds like prefixing /bin/ or "timeout XX" to commands only when strictly needed, not by default, to let settings.json do its job with allowed commands.

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
