
## Advice

- [To be a professional programmer](https://github.com/charlax/professional-programming?tab=readme-ov-file#search)

## Sourcetree

- [Switching between accounts](https://stackoverflow.com/questions/46363362/how-to-change-username-password-of-github-account-in-sourcetree-on-macos)

- Add users: Tools > Options > Authenticaiton
- Configure repo: Settings > Double click origin > Edit info
- Change code pusher: Settings > Advanced > User information > Uncheck “Use global user settings” > type username + email
## Gitlab

### Push a project onto GitLab on master branch as the default

> [!tip] Use main instead of master
> 
> Use `git init --initial-branch=main` later on

1. Create a remote repo WITHOUT README.md
2. Initialize a git repo `git init --initial-branch=main`
3. Add remote repo `git remote add origin .../remote-repo.git`
4. Add and commit the project `git add . && git commit -m "Commit message"`
5. Push the project `git push --set-upstream origin main`

### Gitlab Runner

#### Installation & Activation

- Shared runner: Configure in Settings > CI/CD > Runners > Instance runners
- Project runner:
    - Docker version: Follow [this guide with the local volume mounts version](https://docs.gitlab.com/runner/install/docker.html) 
    - Binary version (Not recommended as there might be a need for .yml configuration):

```bash
# Download the binary for your system
sudo curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64

# Give it permission to execute
sudo chmod +x /usr/local/bin/gitlab-runner

# Create a GitLab Runner user
sudo useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash

# Install and run as a service
sudo gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
sudo gitlab-runner start

```

#### Registration

- [Follow this guide with the Docker/local volume mounts version](https://docs.gitlab.com/runner/register/index.html?tab=Docker)
- Common issues:
	- [Install nano inside docker exec shell](https://stackoverflow.com/questions/30853247/how-do-i-edit-a-file-after-i-shell-to-a-docker-container)
	- [Resolve "Cannot connect to Docker dameon on Gitlab"](https://stackoverflow.com/questions/61105333/cannot-connect-to-the-docker-daemon-at-tcp-localhost2375-is-the-docker-daem)
	- Change `privileges` property inside `/etc/gitlab-runner/config.toml` to `true` and restart gitlab-runner container


>[!warning]
Legacy Git repositories create a _master_ branch by default, while newer ones use _main_. Use the branch name that matches your local Git repository by using `git show-ref` to check if the local branch name is `refs/heads/master` or `refs/heads/main`

## Ubuntu & Docker

### Install Ubuntu & Configs

```cmd
wsl --list
wsl --install
```

- Common issues to deal with when installing:

    - [Windows Subsystem for Linux 2: Temporary failure resolving 'archive.ubuntu.com'](https://askubuntu.com/questions/1450120/windows-subsystem-for-linux-2-temporary-failure-resolving-archive-ubuntu-com)
    - [System has not been booted with systemd as init system (PID 1). Can't operate](https://askubuntu.com/questions/1379425/system-has-not-been-booted-with-systemd-as-init-system-pid-1-cant-operate)
    - [Cannot connect to docker daemon/Start docker whenver Ubuntu WSL2 is run](https://stackoverflow.com/questions/44678725/cannot-connect-to-the-docker-daemon-at-unix-var-run-docker-sock-is-the-docker)

```bash
# Resolve archive ubuntu failure
sudo rm /etc/resolv.conf
sudo bash -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'
sudo bash -c 'echo "[network]" > /etc/wsl.conf'
sudo bash -c 'echo "generateResolvConf = false" >> /etc/wsl.conf'
sudo chattr +i /etc/resolv.conf

# Integrate systemd
sudo nano /etc/wsl.conf

# Edit the file to this
[boot]
systemd=true
```


### Install Docker Engine on Ubuntu/WSL2 (without Docker Desktop)

- [Script to install](https://gitlab.com/bmcgonag/docker_installs)
- Install Docker Engine on WSL2 based on the [Docker docs on installation on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)


```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update


# install packages
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

- Get docker to run as root user (from this [link](https://github.com/rancher-sandbox/rancher-desktop/issues/1156#issuecomment-1017042882))

```bash
# Run docker without sudo
sudo chown root:docker /var/run/docker.sock
sudo chmod g+w /var/run/docker.sock
sudo gpasswd -a $USER docker
sudo systemctl start docker

# Then reload WSL2
```

### Install Portainer

- Install [Portainer Server](https://docs.portainer.io/start/install-ce/server/docker/wsl) and [Portainer Agent (TLDR: The messenger between Portainer and Docker)](https://docs.portainer.io/admin/environments/add/docker/agent) as a GUI container management platform

```bash
docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
```

- Update docker-related packages from the [official installation](https://docs.docker.com/engine/install/ubuntu/)

- Access WSL Ubuntu File System by [mapping network drive](https://dev.to/miftahafina/accessing-wsl2-files-from-windows-file-explorer-308o) with `\\wsl.localhost\Ubuntu` under `U:` drive


### [Move Docker data to another drive](https://stackoverflow.com/questions/62441307/how-can-i-change-the-location-of-docker-images-when-using-docker-desktop-on-wsl2)

## Git

- [Remove + Ignore a file after it has been committed](https://www.heybooster.ai/insights/how-to-gitignore-after-commit)


## VS Code

- Install `Iosevka Custom` font from [this repo](https://github.com/nomosstorge/vscode-setup) or `JetBrainsMono Nerd Font Mono` from [here](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip)
- Apply the `vscode-settings.json` to the user `settings.json` of VS Code 
- [Export VS Code extension list](https://stackoverflow.com/questions/35773299/how-can-you-export-the-visual-studio-code-extension-list)

## Visual Studio

- [Shortcuts](https://learn.microsoft.com/en-us/visualstudio/ide/default-keyboard-shortcuts-in-visual-studio?view=vs-2022#bkmk_refactor-popular-shortcuts)

## Neovim

- [Install nightly version with Bob](https://github.com/MordechaiHadad/bob)
	- Install [rustup](https://rust-lang.github.io/rustup/installation/index.html) first
	- [Fix linker cc not found error](https://stackoverflow.com/questions/52445961/how-do-i-fix-the-rust-error-linker-cc-not-found-for-debian-on-windows-10)

## Other tools

1. Fine Code Coverage - VS 2022 extension
2. StyleCop
3. [RustDesk and how to configure it for self-hosting](https://www.youtube.com/watch?v=SYM6M5Fiuyc)
	1. [Headless linux support](https://github.com/rustdesk/rustdesk/wiki/Headless-Linux-Support)

> [!tip] Install deb package
> 
> ```bash
> sudo apt install /path/to/file.deb
> ```

4. [Win11 Clean Installation/Debloater](https://christitus.com/windows-tool/)
5. Tmux (Terminal multiplexers for Linux distro/WSL)
	- [Cheatsheet](https://tmuxcheatsheet.com/)
	- [Overview](https://arcolinux.com/everthing-you-need-to-know-about-tmux-panes/#:~:text=A%20Session%20holds%20one%20or,commands%20(good%20when%20scripting).)
6. [mkcert Installation and Configs](https://thriveread.com/mkcert-localhost-ssl-certificates/)
7. [MailCatcher for SMTP server mail testing](https://mailcatcher.me/)
8. [pgAdmin for interacting with Postgresql database](https://www.sqlshack.com/getting-started-with-postgresql-on-docker/)
9. [Clear up nuget packages](https://stackoverflow.com/questions/30933277/how-can-i-clear-the-nuget-package-cache-using-the-command-line)

## Courses

1. [List of courses for Blazor](https://awesomeopensource.com/project/AdrienTorris/awesome-blazor#tutorials)
2. [Push an existing project to GitLab under MASTER (not main) branch](https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-to-add-and-push-an-existing-project-to-GitLab)
3. [Teach yourself CS](https://teachyourselfcs.com/)
4. [Check if HTML and CSS can be used on different browsers](https://caniuse.com/)
5. [Visualize how code works](https://pythontutor.com/visualize.html#mode=edit)
6. [Get to know Obsidian](https://www.dontblockme.org/browse.php/0PLh3T9c/j0ADvpTO/hZ3KnOW_/2BqeLDmF/fhRiInej/LUssbs3I/vIOQ8u39/XA7S05EL/iBdc9PO0/b_2F7sd8/rcG0pHgm/G_2Frg9W/5qMFj0AA/GP5dUm8S/Nj1Jfkhw/KSrL_2FD/ca72mqlf/Y1yhUd5b/x6mn_2BV/lfXg_3D_/3D/b29/fnorefer)
7. [Weekly template for Obsidian P1](https://bagerbach.com/blog/projects-and-goals-obsidian)
8. [Weekly template for Obsidian P2 (Advanced)](https://bagerbach.com/blog/weekly-review-obsidian#weekly-review-template)
9. https://www.professormesser.com/network-plus/n10-008/n10-008-video/n10-008-training-course/
## Configs

1. [Add and configure StyleCop for the whole solution](https://bytedev.medium.com/quickly-setup-stylecop-for-new-net-solutions-275fc755b69e)
2. [Configure Serilog for ASP.NET Core (The right and shortest way)](https://github.com/serilog/serilog-aspnetcore)
3. [Commands for EF Core](https://www.entityframeworktutorial.net/efcore/cli-commands-for-ef-core-migration.aspx)
4. [Create a README in local repo](https://www.ge.com/digital/documentation/edge-software/t_Create_Readme_and_Commit_to_Local_Repo.html)
5. [Kill hibernation files to free up space with `powercfg -h off`](https://www.reddit.com/r/Windows10/comments/11m88cc/c_drive_is_basically_full_how_can_i_free_up_more/jbhth4v/?context=3)
6. [Useful Obsidian vault configs](https://github.com/CyanVoxel/Obsidian-Vault-Template/tree/main) + [How to setup](https://www.youtube.com/watch?v=rAkerV8rlow)