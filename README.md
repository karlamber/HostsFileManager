<p align="center">
  <a href="https://github.com/karlamber/HostsFileManager" title="HostsFileManager">
  </a>
</p>
<h1 align="center"> HostsFileManager </h1>
<p align="center">Back in 2014 - I was the Lead DevOps Engineer on a major site-redesign project, and I needed a way for
developers, QA Testors, Project Managers, and Business Users to individually manage switching between the
current production environment, and the *new* production environment - consisting of over 20 updated
microsites.<br> This project was the solution - hopefully it will help you too! </p>

<p align="center">
<a href="https://github.com/karlamber/HostsFileManager/blob/master/LICENSE" title="License">
<img src="https://img.shields.io/github/license/karlamber/HostsFileManager?label=License&logo=Github&style=flat-square" alt="HostsFileManager License"/>
</a>
<a href="https://github.com/karlamber/HostsFileManager/fork" title="Forks">
<img src="https://img.shields.io/github/forks/karlamber/HostsFileManager?label=Forks&logo=Github&style=flat-square" alt="HostsFileManager Forks"/>
</a>
<a href="https://github.com/karlamber/HostsFileManager/stargazers" title="Stars">
<img src="https://img.shields.io/github/stars/karlamber/HostsFileManager?label=Stars&logo=Github&style=flat-square" alt="HostsFileManager Stars"/>
</a>
<a href="https://github.com/karlamber/HostsFileManager/issues" title="Issues">
<img src="https://img.shields.io/github/issues/karlamber/HostsFileManager?label=Issues&logo=Github&style=flat-square" alt="HostsFileManager Issues"/>
</a>
<a href="https://github.com/karlamber/HostsFileManager/pulls" title="Pull Requests">
<img src="https://img.shields.io/github/issues-pr/karlamber/HostsFileManager?label=Pull%20Requests&logo=Github&style=flat-square" alt="HostsFileManager Pull Requests"/>
</a>
<a href="https://github.com/karlamber/HostsFileManager" title="Repo Size">
<img src="https://img.shields.io/github/repo-size/karlamber/HostsFileManager?label=Repo%20Size&logo=Github&style=flat-square" alt="HostsFileManager Repo Size"/>
</a>
<a href="https://open.vscode.dev/karlamber/HostsFileManager" title="Open in VSCode">
<img src="https://img.shields.io/badge/Open%20in%20VSCode-%23007ACC?label=Code&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA8AAAAPCAYAAAA71pVKAAAC00lEQVQYGX3BX2iVZRwH8O/ze//t/NkcRzdXmzZzLLYMmyVJUFQgzkQoqOsgAtNu6jK6kqjbIqOErrrTCBUUbBTYuZCMoDE0FZLp3DpnZ9s55313znmf/89TEV1JfT5s6uIG5LlvsPTdKViK8fCzr2H8wGEw1UIpNqgUYkRx38Bajqorb08ateWT62l+NrtxBSH+R0KAdhhbaelqp7X26MTTE9ix58UzG83u+7/l9Q9DEMHKHE4JoNiHf0UEKIvH1zh+lMZsC+ME3ZzDt4FiUtz75NE3viXvDYpbx44AHkjXwShAQIBx7PkGD37NtdsWBAzWGihtYD2QtXsQxkmienu+9MRzl3Yf++wylQaLulWHIXolU76qjI8DBmil0drkn/qocFkbCwsGrbQilXUUz3vo3/PS7PiJL38pPDL10eb68nllHQIiGGfxe231BI1MvlceHk2lyGG9h/UeoSzoZ0i507Kx8mYyMjHth3ZOiz9uIehs+F5x63xN0Tvh0Ni13dMz4Fw8ZJwHwPA30k0JsVF/26SNW7ybQQgBN/wY9OCOzsp89ZD44etro4NbkFQi5FwY4xmMB4wHSDY5XCc7bZr3pmy2CksRFO/CVMb7KzMH5yLbPXDv/CmkLQkqlENjPYwFjAUoSsTPNqRjtjwc5XcXbvZuXv3YxmWoTsrCkcl9Q299/pMqDR9fnDsDFoc14xms97Deg0yaxDpWkKwwl9XW9qulGx9Abr6qPQPP2jCSozJ7/IuuCz9p318aZFEC4wHjAdK9ZEaz3lGh9CxjcR4UBwDevmDT5Re0gxZSw0gBjEy+y7V72ToGbTwsi2JigYMz/hJjACP8I0xAqld1zTtPaa1aCgGMFHCMYB3ASgOwCBLCXxhjeEBYANP5dVe/vddysSh9ABcVgP4IPG8vNL7/6vUQ/8kDcR+YyFf04sIMje6q6t5msnrl6kmRpWf1/ev4E5Tbl9R3VUZRAAAAAElFTkSuQmCC&style=flat-square" alt="Open in VSCode"/>
</a>
<a href="https://github.dev/karlamber/HostsFileManager" title="Open in VSCode Web">
<img src="https://img.shields.io/badge/Open%20in%20VSCode%20Web-%23007ACC?label=Code&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA8AAAAPCAYAAAA71pVKAAAC00lEQVQYGX3BX2iVZRwH8O/ze//t/NkcRzdXmzZzLLYMmyVJUFQgzkQoqOsgAtNu6jK6kqjbIqOErrrTCBUUbBTYuZCMoDE0FZLp3DpnZ9s55313znmf/89TEV1JfT5s6uIG5LlvsPTdKViK8fCzr2H8wGEw1UIpNqgUYkRx38Bajqorb08ateWT62l+NrtxBSH+R0KAdhhbaelqp7X26MTTE9ix58UzG83u+7/l9Q9DEMHKHE4JoNiHf0UEKIvH1zh+lMZsC+ME3ZzDt4FiUtz75NE3viXvDYpbx44AHkjXwShAQIBx7PkGD37NtdsWBAzWGihtYD2QtXsQxkmienu+9MRzl3Yf++wylQaLulWHIXolU76qjI8DBmil0drkn/qocFkbCwsGrbQilXUUz3vo3/PS7PiJL38pPDL10eb68nllHQIiGGfxe231BI1MvlceHk2lyGG9h/UeoSzoZ0i507Kx8mYyMjHth3ZOiz9uIehs+F5x63xN0Tvh0Ni13dMz4Fw8ZJwHwPA30k0JsVF/26SNW7ybQQgBN/wY9OCOzsp89ZD44etro4NbkFQi5FwY4xmMB4wHSDY5XCc7bZr3pmy2CksRFO/CVMb7KzMH5yLbPXDv/CmkLQkqlENjPYwFjAUoSsTPNqRjtjwc5XcXbvZuXv3YxmWoTsrCkcl9Q299/pMqDR9fnDsDFoc14xms97Deg0yaxDpWkKwwl9XW9qulGx9Abr6qPQPP2jCSozJ7/IuuCz9p318aZFEC4wHjAdK9ZEaz3lGh9CxjcR4UBwDevmDT5Re0gxZSw0gBjEy+y7V72ToGbTwsi2JigYMz/hJjACP8I0xAqld1zTtPaa1aCgGMFHCMYB3ASgOwCBLCXxhjeEBYANP5dVe/vddysSh9ABcVgP4IPG8vNL7/6vUQ/8kDcR+YyFf04sIMje6q6t5msnrl6kmRpWf1/ev4E5Tbl9R3VUZRAAAAAElFTkSuQmCC&style=flat-square" alt="Open in VSCode Web"/>
</a>
</p>
<!-- <p align="center"><img src="./assets/images/main.gif" alt="HostsFileManager"/></p> -->

<h2 align="center">🌐 Links 🌐</h2>
<p align="center">
    <a href="https://github.com/karlamber/HostsFileManager" title="HostsFileManager">📂 Repo</a>
    ·
    <a href="https://github.com/karlamber/HostsFileManager/issues/new/choose" title="🐛Report Bug/🎊Request Feature">🚀 Got Issue</a>
</p>

## Features
- [x] Friendly Graphical Interface
- [x] Centralized management of global hosts entries
- [x] Inclusion of "restricted" hosts entry groups
- [x] Inclusion of "local" hosts entry groups

## Prerequisite
PowerShell 3.0
Users must have local administrator permissions (to edit hosts file)

## 🛠️ Installation Steps

1. Create network share accessible by desired users
1. Place .ps1 script, shortcut, and directories with .hosts files in network share
1. If possible - digitally sign .ps1 file with Trusted Publisher certificate (if your enterprise supports that.)
1. Modify shortcut with correct path to .ps1 script
1. Deploy shortcut to end-users desktop. (SCCM, Group Policy, email, etc.)

## Future Updates

- [ ] Add Screenshots to README
- [ ] Add functionality to automatically add '# Managed Entry For' comment for each hosts entry
- [ ] Update Documentation

## Karl Amber

- 🌌 [Profile](https://github.com/karlamber "Karl Amber")

- 🏮 [Email](mailto:karlramber@gmail.com?subject=Hi%20from%20<repo-email> "Hi!")

