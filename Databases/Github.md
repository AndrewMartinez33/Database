# There are three areas in GIT.

1. Working Directory
2. Staging Area - where we organize what we want to be committed to our repository
3. Git Repository

# Setting up GIT

### 1. Check Version

```
git --version
```

### 2. Set Config Values

```
git config --global user.name "Andrew Martinez"

git config --global user.email "andrew.a.martinez33@gmail.com"
```

### 3. Check the config values

```
git config --list
```

# Scenario 1: You have a local codebase that you want to start tracking using GIT

### 1. Go to project directory

```
git init
```

### 2. To ignore files add a .gitignore file

```
touch .gitignore
```

### 3. Open git ignore in editor

```
manually add files to ignore
```

### 4. Add Files to Staging Area

```
git add -A

git status
```

### 5. If you need to remove files from staging area

```
git reset file_name
```

### 6. commit files

```
git commit -m"detailed message about all changes"
```

# Scenario 2: Track an Existing Remote Project

```
git clone url_of_repository where_to_clone
```

### 1. Add Files to Staging Area

```
git add -A
```

### 2. Commit files

```
git commit -m"detailed message about all changes made"
```

### 3. push changes to repository

first we need to pull to make sure we have the most up to date version. then we push

```
git pull origin master
git push origin master
```

# Branching Workflow

### 1. create a branch for the desired feature

```
git branch <branch_name>
```

### 2. checkout the branch

```
git branch <branch_name>
```

### 3. After commit, push branch to remote

```
git push -u origin <branch_name>
```

### 4. Mergin branch with Master Branch

```
git checkout master
git pull origin master

<!-- shows all branches that have been merged -->
git branch --merged

git merge <branch_name>
git push origin master
```

### 5. Now we can delete that branch

```
git branch --merged

<!-- deletes branch locally -->
git branch -d <branch_name>

git branch -a

<!-- delete branch in remote repository -->
git push origin --delete <branch_name>
```
