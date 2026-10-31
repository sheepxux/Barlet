# Barlet

macOS 上的一条玻璃控制条。它贴在主屏幕底部，跟着前台应用换成不同的按钮，右边始终留着播放、音量和亮度。材质用系统的 Liquid Glass。

1.0 在 2026 年 11 月 10 日通过落地页提供公证过的 dmg。仓库保持私有，不进 Mac App Store。最低系统是 macOS 26。

## 文档

| 文档 | 内容 |
| --- | --- |
| [需求文档](docs/需求文档.md) | 功能清单、优先级、不做什么 |
| [技术方案](docs/技术方案.md) | 选型、架构、本机数据 |
| [接口文档](docs/接口文档.md) | 界面层和动作层之间的约定 |
| [项目计划](docs/项目计划.md) | 分工和里程碑 |

改功能先改需求，改两边的调用方式先改接口文档，再改代码。

## 环境

开发机目前是 macOS 27.2、Xcode 27.2、Swift 6.4.2。另一台参与开发的 Mac 需要能打开同一份工程的 Xcode 27。

| 项 | 值 |
| --- | --- |
| 部署目标 | macOS 26.0 |
| 签名 | Developer ID Application，团队 `Q77SUT63T9` |
| 公证 | 钥匙串配置 `dev-island-notary` |
| 仓库 | https://github.com/sheepxux/Barlet |

辅助功能权限只在按下快捷键、把按键发给别的应用时需要。音量、亮度和媒体键不依赖它。

## 运行

```sh
git clone https://github.com/sheepxux/Barlet.git
cd Barlet
open Barlet.xcodeproj
```

在 Xcode 里选 Scheme `Barlet`、目标 `My Mac`，然后 Run。应用没有程序坞图标，菜单栏会出现一枚胶囊图标，屏幕底部会出现玻璃条。

当前这条上的按钮还没有接到音量、亮度和快捷键。调试构建每次换签名位置后，要在「系统设置 → 隐私与安全性 → 辅助功能」里重新勾选 Barlet，快捷键才会发得出去。

公证不是日常运行步骤。11 月 7 日打包时使用：

```sh
xcrun notarytool submit Barlet.dmg --keychain-profile dev-island-notary --wait
xcrun stapler staple Barlet.dmg
```

钥匙串里已经有这个配置。不要把 Apple ID 密码或 API 密钥写进仓库。

## Git

`main` 保持可编译。现在只有文档，工程加进来之后，`main` 上的版本应当能在本机运行。

分支从 `main` 拉出，用 `feat/` 或 `fix/` 加短名称：

```text
feat/glass-panel
feat/action-runner
fix/brightness-builtin-only
```

合回 `main` 走 Pull Request，另一人看过再合。两个人也走 PR，避免同时改同一段接口。

提交说明用类型加一句中文，说明为什么改：

```text
feat: 悬浮窗需要透明才采得到桌面
fix: 没有内建显示器时不提供亮度
docs: 六个预设的快捷键改成和系统菜单一致
```

类型用 `feat`、`fix`、`docs`。不要提交证书、描述文件、公证密码、`.env`、`DerivedData` 和 `.DS_Store`。这些已写在 `.gitignore` 里。

## 目录

```text
README.md
Barlet.xcodeproj
Barlet/
docs/需求文档.md
docs/技术方案.md
docs/接口文档.md
docs/项目计划.md
```

界面层与动作层的分界以接口文档为准。
