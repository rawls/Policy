# Policy

## Synopsis
Some simple Ruby examples of ways in which client-side git hooks can be used to help manage your teams' use of git and prevent bad commits from getting into your codebase. 

These scripts can be stored in a policy directory in each of your projects and tailored to suit that project. When checking out a project for the first time, developers should install the hooks using the script. These hooks will then help to prevent mistakes such as:

- Committing to the wrong branch
- Committing a merge conflict
- Leaving an unhelpful commit message

Most of the checks and features are inspired by the examples in the [git documentation](http://git-scm.com/book/en/Customizing-Git-Git-Hooks) and jish's [pre-commit](https://github.com/jish/pre-commit) gem.

## Usage

#### Enforcing a consistent structure for commit messages
```
$ git commit -m "misc fixes"
[POLICY] Fail: Your commit message is not formatted properly.
The format for commit messages is as follows:
 * The message must start with a ticket ref, e.g. [mantis: 12345] [HRB-123] or [untracked]
 * The commit message must be at least 20 characters long
```

#### Preventing merge conflicts from being accidentally committed
```
$ git commit app/controllers/application_controller.rb -m "[mantis: 12345] Resolved (most of) a merge conflict"
[POLICY] Fail: You are committing a merge conflicted file: 
  /home/user/my_project/app/controllers/application_controller.rb
```

#### Blocking accidental commits to restricted branches
```
$ git commit -m "[mantis: 12346] Added a prototype version of live video support"
[POLICY] Fail: You are attempting to commit into restricted branch: master
```

#### Adding useful information to the end of commit messages
```
$ git commit -m "[mantis: 12347] Added a new CMS panel to the home page"
[master b14cc83] [mantis: 12347] Added a new CMS panel to the home page  (Javascript|CSS|Ruby|HTML)  (Assets|Controllers|Views|Models)
 7 files changed, 8 insertions(+), 6 deletions(-)
```

## Installation
This project is intended as a set of examples to show what can be done with git hooks for Ruby/Rails projects and not as a production ready tool. If you are looking for something plug-and-play I would recommend taking a look at jish's [pre-commit](https://github.com/jish/pre-commit).

If you would like to experiment with it, create a policy directory in your project, copy the contents of this repo into that directory and run the `policy/install_hooks` script. This will symlink the available hooks to your project's .git/hooks directory and make them executable.

There are sample configuration files in the config directory and several checks and features which can be enabled or disabled by editing the .hook files in the hooks directory.

## License
Distributed on a do whatever you want with it but don't blame me if it breaks license.
