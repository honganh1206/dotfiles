- [Remove + Ignore a file after it has been committed](https://www.heybooster.ai/insights/how-to-gitignore-after-commit)
- Pro-tip: Use git whenever you create a new project folder

![[Pasted image 20241024214540.png]]

```bash
# Move to a feature branch
git checkout feature-branch
# Rebase code from main brach to main
git rebase main
# After resolving merge conflicts, continue the rebase
git rebase --continue
git push -f

# Change creds on a specifig git repo so that I can push code with my personal creds
git config --local user.name "Different User Name" 
git config --local user.email "different.email@example.com"

# Include new files then interactively stage changes from your working dir
git add -A && git add -p && git commit

```


## Workflow

- Work with other: Open a branch off the main branch → Code → Commit early & often → Push early & often → Open PR as a draft → Ensure the PR makes sense → Open for review & merge

## Good practices

- Commit early and commit often. Like a quick save in game
- Open a PR early (first commit is a good practice)
- Each PR should deal with one problem or part of a feature at a time so it can be re-traced easily
- Add a short video/screenshot for fixes as a **proof** that you have run the code
