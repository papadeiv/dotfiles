## Git & GitHub

## Configuration 
1. Link your new system with your profile via SSH key
```bash
mkdir ~/.ssh
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub
```
Copy the key -> Go to the Github profile page -> Settings -> SSH and GPG keys -> New SSH key -> Paste in and save

2. Test that it worked
```bash
git clone git@github.com:papadeiv/Notes.git
cd Notes
```
Amend the [Test](Test.md) zettel and then
```bash
git add . 
git commit -m "Test of new system"
git push origin master 
```

## Create local repo and link it to remote
Initialise your local dir as a Git repo
```bash
git init
```
Create and configure the gitignore file
```bash
touch .gitignore
```
Add files and commit 
```bash
git add .
git commit -m "First commit"
```
Create the remote repo on GitHub and sync it to track changes with the local one
```bash
git remote add origin git@github.com:papadeiv/repo-name.git
```
Push your first commit to remote
```bash
git push -u origin master 
```
## Get a specific branch from remote
```bash
git pull
git checkout --track origin/name-of-the-branch
```

## Workflow
![git_workflow](../figures/git_workflow.gif)


