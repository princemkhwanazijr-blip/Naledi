# requires GitHub CLI (gh) already installed and authenticated (gh auth login)
# from project root
gh repo create princemkhwanazijr-blip/<repo> --public --source=. --remote=origin --push
# That will create the GitHub repo, add origin remote, and push the current branch.