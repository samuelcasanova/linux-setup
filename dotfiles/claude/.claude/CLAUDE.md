@RTK.md

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
