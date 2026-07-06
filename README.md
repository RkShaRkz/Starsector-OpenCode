# Starsector-OpenCode
OpenCode setup for my starsector mods

The whole point of this repository is to have a centralized, starsector-focused setup for OpenCode that can
be included to any mod project as a git submodule and (kinda) work out of the box.

If you know what git submodules are and already have opencode installed (and working) - just add this repo as a git
submodule to your project like this:
```
git submodule add https://github.com/RkShaRkz/Starsector-OpenCode .opencode-brain
```

Then, navigate to the project (the one where this was added as a submodule) from the WSL terminal, **create necessary symlinks**,
type in `opencode`, and watch it work it's magic.

In case you're unfamiliar with git submodules or don't have anything installed, read on. But - for Git, the best source of information
will always be [Git-SCM](https://git-scm.com/book/en/v2)


# Clean install
The "clean install" assumes that you are running Windows, have no WSL installed and have no opencode installed.

## Installing WSL
Open the command prompt as administrator, and type `wsl --install`
This will install the **W**indows **S**ubsystem for **L**inux as well as Ubuntu (for windows).
After doing this - but **before** proceeding further - restart the computer as the terminal says.
After restarting, WSL ubuntu will proceed with downloading/installation.

Installing XServer so you can view the Ubuntu monitor(s) is left as an excercise to the reader.


### Updating WSL's Ubuntu
Since it's fresh, might as well update/upgrade it to latest.
Inside the WSL terminal `sudo apt update && sudo apt upgrade -y`


## Installing OpenCode (into WSL)
Run the WSL terminal and do `curl -fsSL https://opencode.ai/install | bash`
This will install OpenCode 1.17.14 (at the time of writing).

After you see this:
```
devshark@DESKSHARK:~$ curl -fsSL https://opencode.ai/install | bash

Installing opencode version: 1.17.14

■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ 100%
Successfully added opencode to $PATH in /home/devshark/.bashrc

                                 ▄
█▀▀█ █▀▀█ █▀▀█ █▀▀▄ █▀▀▀ █▀▀█ █▀▀█ █▀▀█
█░░█ █░░█ █▀▀▀ █░░█ █░░░ █░░█ █░░█ █▀▀▀
▀▀▀▀ █▀▀▀ ▀▀▀▀ ▀  ▀ ▀▀▀▀ ▀▀▀▀ ▀▀▀▀ ▀▀▀▀


OpenCode includes free models, to start:

cd <project>  # Open directory
opencode      # Run command

For more information visit https://opencode.ai/docs

```
the installation will add opencode to your bashrc PATH, but since we already had a terminal opened, it
won't know anything changed until it is reset (and .bashrc is reloaded) or it's told to re-read it like
```
source ~/.bashrc
```

Now you're ready to run opencode.

## Modifying the OpenCode setup (AGENTS.md, RULES.md, opencode.json)
This repository only contains these "rules" (aka "brain") files; so if/when modifying these files,
you should *instead* update the submodule (this repository) and then pull the submodule updates in your
main project.

If you forked your own copy of this repository, just update your repository, then do
```
git submodule update --remote --merge
```

Otherwise, as updates are pushed here, you can check periodically if anything new happened and pull these updates.

You are also free to just directly modify your local copy of the submodule and keep it like that I suppose.

# Integrating this repository in your own mod as a submodule

1) Add this repository as a submodule to your repo
```
git submodule add https://github.com/RkShaRkz/Starsector-OpenCode .opencode-brain
```
2) Create symbolic links (since these files need to be in project root for opencode to see them)
```
ln -s .opencode-brain/opencode.json opencode.json
ln -s .opencode-brain/RULES.md RULES.md
ln -s .opencode-brain/AGENTS.md AGENTS.md
```
3) Commit the new submodule to your repository
```
git add .gitmodules .opencode-brain opencode.json RULES.md AGENTS.md
git commit -m "chore: integrate universal Starsector OpenCode framework submodule"
git push
```
4) OPTIONAL: update the submodule and push changes (to your repo) if any
```
git submodule update --remote --merge

git add .opencode-brain
git commit -m "chore: update Starsector-OpenCode submodule to latest version"
git push
```

5) Remember to clone your mod recursively from now on.

Every fresh clone of the mod will need to have submodules initialized, cloned into and generally have the opencode template integrated into it again (when it shouldn't).

To get around that, simply remember to clone your mod like
```
git clone --recursive <YOUR-MAIN-MOD-REPOSITORY-URL>
```
which will automagically pick up the submodules (this repo) and set everything up properly. You're welcome.