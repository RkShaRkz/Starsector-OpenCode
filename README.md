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

Installing XServer so you can view the Ubuntu monitor(s) is left as an exercise to the reader.


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

## Where OpenCode actually _expects_ its skills.

Unfortunately, this isn't quite as easy and straight-forward as I'd hoped it'd be.
OpenCode looks for skills in these non-negotiable locations only:
```
Project config: .opencode/skills/<name>/SKILL.md
Global config: ~/.config/opencode/skills/<name>/SKILL.md
Project Claude-compatible: .claude/skills/<name>/SKILL.md
Global Claude-compatible: ~/.claude/skills/<name>/SKILL.md
Project agent-compatible: .agents/skills/<name>/SKILL.md
Global agent-compatible: ~/.agents/skills/<name>/SKILL.md
```
Information has been picked up from https://opencode.ai/docs/skills/ - If something changes, do feel free to apply.
At the time of writing, this has been confirmed as true, and was the only place I could put the skills in and have
them get picked up and be usable.

## Modifying the OpenCode setup (AGENTS.md, RULES.md, opencode.json)
This repository only contains these "rules" (aka "brain") files; so if/when modifying these files,
you should *instead* update the submodule (this repository) and then pull the submodule updates in your
main project.

If you forked your own copy of this repository, just update your repository, then do
```
git submodule update --remote --merge --recursive
```

Otherwise, as updates are pushed here, you can check periodically if anything new happened and pull these updates.

You are also free to just directly modify your local copy of the submodule and keep it like that I suppose.

# Integrating this repository in your own mod as a submodule

1) Add this repository as a submodule to your repo
```
git submodule add https://github.com/RkShaRkz/Starsector-OpenCode .opencode-brain
```
This repository also has a few git submodules of it's own, just for the skills. They are flattened into `skills/` folder,
but just to follow git pedantics, you might also want to initialize them too.
```
git submodule update --init --recursive
```
Afterwards, running `deploy.sh` from the git submodule's (`.opencode-brain/skill-submodules`) folder will update this repo's submodules, flatten their content
and deploy them to the `skills` folder.

These git submodules' individual skills are already contained in the `skills` folder, but you can always add more skill sources (and update the deploy.sh script)
in which case doing this will become mandatory. In fact, consider it mandatory even if you never look at these submodules and skip only if you know what you're doing.

2) Create symbolic links (since these files need to be in project root for opencode to see them)
Since 'skills' need to be in the aforementioned non-negotiable locations, we'll have to create that folder as well and symlink the skills into there.
Linux:
```
ln -s .opencode-brain/opencode.json opencode.json
ln -s .opencode-brain/RULES.md RULES.md
ln -s .opencode-brain/AGENTS.md AGENTS.md
mkdir -p .opencode
ln -s .opencode-brain/skills .opencode/skills
```
Windows:
```
mklink opencode.json .opencode-brain\opencode.json
mklink RULES.md .opencode-brain\RULES.md
mklink AGENTS.md .opencode-brain\AGENTS.md
mkdir .opencode
mklink /D .opencode\skills .opencode-brain\skills
```
_WARNING:_ I've noticed that when symlinks are created in this way, when the root files are updated the symlinks do not update their content.
Unless you figure out how to address this issue, the easiest course of action is to simply regenerate the symlinks after updating the submodule.

3) Commit the new submodule to your repository
```
git add .gitmodules .opencode-brain opencode.json RULES.md AGENTS.md
git commit -m "chore: integrate universal Starsector OpenCode framework submodule"
git push
```
4) OPTIONAL: update the submodule and push changes (to your repo) if any. The `--recursive` is necessary for the nested submodules (this repo's submodules)
```
git submodule update --remote --merge --recursive

git add .opencode-brain
git commit -m "chore: update Starsector-OpenCode submodule to latest version"
git push
```

## Do not forget to run `.opencode-brain/skill-submodules/deploy.sh` to refresh the skills folder!

5) Remember to clone your mod recursively from now on.

Every fresh clone of the mod will need to have submodules initialized, cloned into and generally have the opencode template integrated into it again (when it shouldn't).

To get around that, simply remember to clone your mod like
```
git clone --recursive <YOUR-MAIN-MOD-REPOSITORY-URL>
```
which will automagically pick up the submodules (this repo) and set everything up properly. You're welcome.