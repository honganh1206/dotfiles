# Courses
1. [List of courses for Blazor](https://awesomeopensource.com/project/AdrienTorris/awesome-blazor#tutorials)
2. [Push an existing project to GitLab under MASTER (not main) branch](https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/How-to-add-and-push-an-existing-project-to-GitLab)
3. [Teach yourself CS](https://teachyourselfcs.com/)
4. [Check if HTML and CSS can be used on different browsers](https://caniuse.com/)
5. [Visualize how code works](https://pythontutor.com/visualize.html#mode=edit)
6. [Get to know Obsidian](https://www.dontblockme.org/browse.php/0PLh3T9c/j0ADvpTO/hZ3KnOW_/2BqeLDmF/fhRiInej/LUssbs3I/vIOQ8u39/XA7S05EL/iBdc9PO0/b_2F7sd8/rcG0pHgm/G_2Frg9W/5qMFj0AA/GP5dUm8S/Nj1Jfkhw/KSrL_2FD/ca72mqlf/Y1yhUd5b/x6mn_2BV/lfXg_3D_/3D/b29/fnorefer)
7. [Weekly template for Obsidian P1](https://bagerbach.com/blog/projects-and-goals-obsidian)
8. [Weekly template for Obsidian P2 (Advanced)](https://bagerbach.com/blog/weekly-review-obsidian#weekly-review-template)
# Configs

 1. [Add and configure StyleCop for the whole solution](https://bytedev.medium.com/quickly-setup-stylecop-for-new-net-solutions-275fc755b69e)
2.  [Configure Serilog for ASP.NET Core (The right and shortest way)](https://github.com/serilog/serilog-aspnetcore)

```json
// logsettings.json
{
  "Serilog": {
    "Using": [
      "Serilog.Sinks.File",
      "Serilog.Sinks.Console"
    ],
    "MinimumLevel": {
      "Default": "Debug",
      "Override": {
        "Microsoft.AspNetCore": "Warning"
      }
    },
    "Enrich": [ "FromLogContext", "WithMachineName", "WithProcessId", "WithThreadId" ],
    "WriteTo": [
      {
        "Name": "File",
        "Args": {
          "path": "logs/log.json",
          "rollingInterval": "Day",
          "formatter": "Serilog.Formatting.Compact.CompactJsonFormatter, Serilog.Formatting.Compact"
        }
      },
      {
        "Name": "Console",
        "Args": {
          "theme": "Serilog.Sinks.SystemConsole.Themes.AnsiConsoleTheme::Code, Serilog.Sinks.Console",
          "outputTemplate": "{Timestamp:yyyy-MM-dd HH:mm:ss.fff zzz} [{Level:u3}] {Message:lj}{NewLine}{Exception}"
        }
      }
    ]
  },
  "Serilog.Sinks.Console": {
    "theme": {
      "ansiTheme": {
        "fatal": "red,bold",
        "error": "red",
        "warning": "yellow",
        "information": "green",
        "debug": "cyan",
        "verbose": "gray"
      }
    }
  }
}
```

3. [Commands for EF Core](https://www.entityframeworktutorial.net/efcore/cli-commands-for-ef-core-migration.aspx)
4. [Create a README in local repo](https://www.ge.com/digital/documentation/edge-software/t_Create_Readme_and_Commit_to_Local_Repo.html)
5. [Kill hibernation files to free up space](https://www.reddit.com/r/Windows10/comments/11m88cc/c_drive_is_basically_full_how_can_i_free_up_more/jbhth4v/?context=3)