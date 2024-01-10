![grinning_face_with_big_eyes](https://github.com/derpycoder/derpycoder/assets/25662120/d6ed008f-029d-4e72-bd21-4801648281cf)

## Hey there!
Thanks for checking out my git profile.

I am a software engineer from India.

- 🔭 I’m currently working on [DerpyTools](https://github.com/derpycoder/derpy_tools)
- 🌱 All the while learning Elixir, Phoenix & Live View
- 👯 Willing to collaborate on Elixir & Phoenix projects
- 💬 Ask me about Elixir & Phoenix
- 📫 How to reach me: abhijit@derpytools.com

![Total Stars](https://img.shields.io/github/stars/derpycoder?style=for-the-badge)

### [DerpyTools](https://github.com/derpycoder/derpy_tools)

![Metadata Checker](https://github.com/derpycoder/derpycoder/assets/25662120/5194e6cd-aa83-4890-ac71-d5e81072a1c5)

## Architecture
My preferred architecture.

```mermaid
graph TD

U(User) <---> |Proxy| C{Caddy}

subgraph VPS
  C{Caddy} <---> |Admin| LiveBook
  Phoenix <---> |Search| Meilisearch

  C{Caddy} <---> |Server| Phoenix
  Phoenix <---> |Database| Sqlite
  Sqlite <---> |Backup| Litestream

  C{Caddy} <---> |Cache| Varnish
  Varnish <---> |Image Transformer| Imgproxy

  C{Caddy} <---> |Monitoring| Netdata
end

Phoenix <---> |S3| S3((Object Store))
Imgproxy <---> |S3| S3((Object Store))
Litestream <---> |S3| S3((Object Store))
```

## My Tech Stack

##### My Favorite Stack
![Elixir](https://img.shields.io/badge/Elixir-4B275F?style=for-the-badge&logo=elixir&logoColor=white)
![Phoenix LiveView](https://img.shields.io/badge/-Phoenix%20LiveView-orange?style=for-the-badge&logo=elixir)
![Sqlite](https://img.shields.io/badge/SQLite-07405E?style=for-the-badge&logo=sqlite&logoColor=white)
![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white)

##### Professional Experience
![React](https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB)
![Redux](https://img.shields.io/badge/Redux-593D88?style=for-the-badge&logo=redux&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-323330?style=for-the-badge&logo=javascript&logoColor=F7DF1E)
![HTML5](https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white)
![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)

##### Prior Experience
![Redis](https://img.shields.io/badge/redis-CC0000.svg?&style=for-the-badge&logo=redis&logoColor=white)
![NodeJS](https://img.shields.io/badge/Node%20js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)
![Socket.IO](https://img.shields.io/badge/Socket.io-010101?&style=for-the-badge&logo=Socket.io&logoColor=white)
![Angular](https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white)
![Unity](https://img.shields.io/badge/Unity-100000?style=for-the-badge&logo=unity&logoColor=white)

##### Miscellaneous
![Codepen](https://img.shields.io/badge/Codepen-000000?style=for-the-badge&logo=codepen&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)
![Leetcode](https://img.shields.io/badge/-LeetCode-FFA116?style=for-the-badge&logo=LeetCode&logoColor=black)
![VS Code](https://img.shields.io/badge/VSCode-0078D4?style=for-the-badge&logo=visual%20studio%20code&logoColor=white)
![Mac Mini](https://img.shields.io/badge/apple%20silicon-333333?style=for-the-badge&logo=apple&logoColor=white)


## My Coding Adventures & Community Contributions

1. [Made a Source Code Inspector](https://elixirforum.com/t/made-a-source-code-inspector-useful-in-big-projects-or-large-teams/56792?u=derpycoder) (Which was later added to the Phoenix Live View itself!)
   
   ![Source Code Viewer](https://github.com/derpycoder/derpycoder/assets/25662120/96c39b8b-b391-4a2d-8a2d-fd1a5ba33ee3)
2. [Made a Table of Contents using Floki](https://elixirforum.com/t/i-created-table-of-contents-using-floki-with-header-nesting-how-to-simplify-the-logic/57501/12?u=derpycoder)
   
   ![Table of Contents](https://github.com/derpycoder/derpycoder/assets/25662120/0a70cb29-439f-40c7-bcdc-50ce7b8914ca)
3. [Created a Command Palette within a week, thanks to Elixir & Phoenix LiveView](https://elixirforum.com/t/created-a-command-palette-within-a-week-thanks-to-elixir-phoenix-liveview/57769)
   ![global-search](https://github.com/derpycoder/derpycoder/assets/25662120/6569bef4-03b0-4679-8498-afe3ccadf1a5)
   
5. [Created a Mix Task, to syntax highlights code snippets in bulk using Chroma](https://elixirforum.com/t/created-a-mix-task-to-syntax-highlights-code-snippets-in-bulk-using-chroma/57878)
   ![Source Code Highlighter](https://github.com/derpycoder/derpycoder/assets/25662120/3c734994-fe44-4a4a-90eb-c601c1774854)

6. [Role-based Authorization using FunWithFlags](https://elixirforum.com/t/phx-gen-auth-and-role-based-authentication/49428/8?u=derpycoder)

7. Watch Face

   ![Watch](https://github.com/derpycoder/derpycoder/assets/25662120/d22d5016-f1c5-45d3-b347-38f479c6f489)
   
9. Flow Field

   ![Flow Field](https://github.com/derpycoder/derpycoder/assets/25662120/5d25b837-ac48-4b54-8f27-205da616a91c)


