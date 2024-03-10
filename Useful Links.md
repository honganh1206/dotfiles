
## Advice

- [To be a professional programmer](https://github.com/charlax/professional-programming?tab=readme-ov-file#search)

## Gitlab

### Push a project onto GitLab on master branch as the default

1. Create a remote repo WITHOUT README.md (to avoid setting `main` as the default branch)
2. Initialize a git repo `git init`
3. Add remote repo `git remote add origin .../remote-repo.git`
4. Add and commit the project `git add . && git commit -m "Commit message"`
5. Push the project `git push -u -f origin master`

### Gitlab Runner

#### Installation & Activation

- Shared runner: Configure in Settings > CI/CD > Runners > Instance runners
- Project runner:
    - Docker version: Follow [this guide with the Docker volume mounts version](https://docs.gitlab.com/runner/install/docker.html) 
    - Binary version:

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

- [Follow this guide with the Docker volume mounts version](https://docs.gitlab.com/runner/register/index.html?tab=Docker)



>[!warning]
Legacy Git repositories create a _master_ branch by default, while newer ones use _main_. Use the branch name that matches your local Git repository by using `git show-ref` to check if the local branch name is `refs/heads/master` or `refs/heads/main`

## Git

- [Remove + Ignore a file after it has been committed](https://www.heybooster.ai/insights/how-to-gitignore-after-commit)


## VS Code

- Install `Iosevka Custom` font from [this repo](https://github.com/nomosstorge/vscode-setup) or `JetBrainsMono Nerd Font Mono` from [here](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip)
- Apply the `vscode-settings.json` to the user `settings.json` of VS Code 
- [Export VS Code extension list](https://stackoverflow.com/questions/35773299/how-can-you-export-the-visual-studio-code-extension-list)

## Visual Studio

- [Shortcuts](https://learn.microsoft.com/en-us/visualstudio/ide/default-keyboard-shortcuts-in-visual-studio?view=vs-2022#bkmk_refactor-popular-shortcuts)


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

## Courses

1. [List of courses for Blazor](https://awesomeopensource.com/project/AdrienTorris/awesome-blazor#tutorials)
2. [Push an existing project to GitLab under MASTER (not main) branch](https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-to-add-and-push-an-existing-project-to-GitLab)
3. [Teach yourself CS](https://teachyourselfcs.com/)
4. [Check if HTML and CSS can be used on different browsers](https://caniuse.com/)
5. [Visualize how code works](https://pythontutor.com/visualize.html#mode=edit)
6. [Get to know Obsidian](https://www.dontblockme.org/browse.php/0PLh3T9c/j0ADvpTO/hZ3KnOW_/2BqeLDmF/fhRiInej/LUssbs3I/vIOQ8u39/XA7S05EL/iBdc9PO0/b_2F7sd8/rcG0pHgm/G_2Frg9W/5qMFj0AA/GP5dUm8S/Nj1Jfkhw/KSrL_2FD/ca72mqlf/Y1yhUd5b/x6mn_2BV/lfXg_3D_/3D/b29/fnorefer)
7. [Weekly template for Obsidian P1](https://bagerbach.com/blog/projects-and-goals-obsidian)
8. [Weekly template for Obsidian P2 (Advanced)](https://bagerbach.com/blog/weekly-review-obsidian#weekly-review-template)
## Configs

1. [Add and configure StyleCop for the whole solution](https://bytedev.medium.com/quickly-setup-stylecop-for-new-net-solutions-275fc755b69e)
2. [Configure Serilog for ASP.NET Core (The right and shortest way)](https://github.com/serilog/serilog-aspnetcore)
3. [Commands for EF Core](https://www.entityframeworktutorial.net/efcore/cli-commands-for-ef-core-migration.aspx)
4. [Create a README in local repo](https://www.ge.com/digital/documentation/edge-software/t_Create_Readme_and_Commit_to_Local_Repo.html)
5. [Kill hibernation files to free up space with `powercfg -h off`](https://www.reddit.com/r/Windows10/comments/11m88cc/c_drive_is_basically_full_how_can_i_free_up_more/jbhth4v/?context=3)