# Starsector-OpenCode
OpenCode setup for my starsector mods

The whole point of this repository is to have a centralized, starsector-focused setup for OpenCode that can
be included to any mod project as a git submodule and (kinda) work out of the box.

If you know what git submodules are and already have opencode installed (and working) - just add this repo as a git
submodule to your project like this:
```

```


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

