<p align="center">
    <img width="128" src="/assets/logo.png" alt="Simple Live logo">
</p>
<h2 align="center">Simple Live</h2>

<p align="center">
简简单单地看直播
</p>

Simple Live 是一个基于 Flutter 的开源聚合直播客户端，支持 Android、Android TV、Windows、macOS、Linux 和 iOS。项目只提供观看、搜索、收藏、弹幕显示和多端配置同步等能力，不实现直播平台的付费或社交互动。

> 本仓库提供阶段性 `Release` 安装包与压缩包，见 [GitHub Releases](https://github.com/wavachao/dart_simple_live/releases) 页面。
> 私有开发主仓会更频繁更新；公开仓库只在阶段性整理后同步。

## 快速入口

- [下载正式版本](https://github.com/wavachao/dart_simple_live/releases)
- [设置与故障排查指南](./SETTINGS_GUIDE.md)
- [用户讨论区](https://github.com/wavachao/dart_simple_live/discussions)
- [问题反馈](https://github.com/wavachao/dart_simple_live/issues)

## 当前版本

| 客户端 | 版本 | 适用场景 |
| --- | --- | --- |
| Simple Live | `1.12.9` | 手机、平板及桌面端 |
| Simple Live TV | `1.7.9` | Android TV、电视盒子及 TV-Windows |

版本说明和具体安装包以 [Releases](https://github.com/wavachao/dart_simple_live/releases) 页面为准。

## 仓库结构

```text
simple_live_app/       主客户端，支持移动端和桌面端
simple_live_tv_app/    Android TV / TV-Windows 客户端
simple_live_core/      直播平台解析、播放地址和弹幕等核心能力
simple_live_console/   基于核心库的命令行工具
assets/                应用图标、截图、版本信息和社区二维码
SETTINGS_GUIDE.md      播放、窗口、同步、日志等设置说明
```

![浅色模式](/assets/screenshot_light.jpg)

![深色模式](/assets/screenshot_dark.jpg)

## 仓库说明

- fork 来源：[原作者仓库 xiaoyaocz/dart_simple_live](https://github.com/xiaoyaocz/dart_simple_live)
- 当前公开仓库：`wavachao/dart_simple_live`

## 下载与安装

普通用户请直接从 [GitHub Releases](https://github.com/wavachao/dart_simple_live/releases) 下载，不建议直接下载源码压缩包代替安装包。

| 设备 | 推荐文件 |
| --- | --- |
| Android 手机 / 平板 | `apk`；不确定架构时优先选择通用包 |
| Android TV / 电视盒子 | `SimpleLive-TV-*.apk`，必须下载 TV 版而不是手机 APK |
| Windows | `zip` |
| Linux | `zip` 或 `deb` |
| macOS | `dmg` |
| iOS | `ipa`；当前为未签名构建，安装需要自行处理签名 |

Android 和 Android TV 的分架构安装包通常包含 `arm64-v8a`、`armeabi-v7a` 和 `x86_64`。请根据设备系统信息选择对应架构；Android TV 用户还需要确认下载的是 TV 版安装包。

## 从源码运行

开发环境需要安装 [Flutter](https://docs.flutter.dev/get-started/install) 和对应平台的构建工具。主 App 和 TV App 当前都使用 Flutter `3.41.9`，版本记录在各自目录的 `.fvmrc` 中。

运行主 App：

```bash
cd simple_live_app
flutter pub get
flutter run
```

运行 TV App：

```bash
cd simple_live_tv_app
flutter pub get
flutter run
```

运行控制台工具：

```bash
cd simple_live_console
dart pub get
dart run simple_live_console -h
```

构建前请先执行 `flutter doctor`，并确保目标平台的 SDK、模拟器或桌面构建依赖已配置完成。各平台的 CI 构建流程可参考 [.github/workflows](./.github/workflows)。

## 支持项目

Simple Live 会继续保持开源和免费使用。赞助费用主要用于同步服务、域名和构建测试等维护开销。

更多社区反馈与赞助鸣谢见 [THANKS.md](/THANKS.md)。

<p align="center">
  <img width="360" src="/assets/support_wechat.png" alt="微信收款码">
</p>

## 用户群

扫码加入 SimpleLive 用户群，交流使用问题和反馈建议。

<p align="center">
  <img width="360" src="/assets/user_group_wechat.jpg" alt="SimpleLive 用户群二维码">
</p>

## 发布资产

正式发布使用 GitHub Actions 完成。普通提交不会触发整套跨平台构建；推送 `v*` 或 `tv_v*` Tag 后，Actions 会构建并汇总所有平台资产，再统一更新对应的 GitHub Release。也可以在 Actions 页面手动运行该工作流；只有在 Tag 上运行并勾选上传选项时才会更新 Release。

Release 资产会在 Windows、Android 和 TV 模拟环境完成基础验证后发布。

正式发布通常包含以下资产类型：

- Android `apk`
- Android TV 拆分 `apk`
- Windows `zip`
- Linux `zip`
- Linux `deb`
- Mac `dmg`
- iOS `ipa`

## 远程同步服务

当前远程同步使用临时房间服务，默认直连自建服务器，并保留 Cloudflare Worker 作为备用：

- 默认服务状态页：`https://sync.furry.mo.cn/health`
- 默认 WebSocket 地址：`wss://sync.furry.mo.cn/sync`
  - 时神时鬼的，由于服务器老是爆炸，所以这个地址有时候不可用
- Cloudflare 备用地址：`wss://simple-live-sync.3439394104.workers.dev/sync`

普通用户不需要自己配置服务器；创建房间、扫码或输入房间号即可同步。自建服务器和 Cloudflare Worker 是两个独立后端，房间状态不共享，两台设备必须选择同一个同步服务。浏览器直接打开 `/sync` 显示 `websocket upgrade required` 是正常的，因为 `/sync` 只给 App 的 WebSocket 使用。

已知限制：

- 房间 600 秒后自动过期。
- 创建者退出或断开后，房间会销毁。
- 单房间最多 8 个连接。
- 单条同步消息最大 1 MB。
- 服务只做临时转发，不保存关注、历史、Cookie、屏蔽词等内容。
- 这不是账号云同步；不会跨天、跨设备持续自动同步。
- 如果默认服务暂时不可用，可在设置里切换到 Cloudflare Worker 备用服务、自定义服务、局域网同步或 WebDAV。使用 Cloudflare Worker 时，部分网络环境仍可能需要代理。

可配置项：

- 主 App 和 TV App：同步服务可选择“自建服务器（默认）”“Cloudflare Worker（备用）”或“自定义地址”。打开选择窗口后会自动执行 WebSocket ping/pong 检测，并在每项右侧显示延迟或不可用状态。
- 未设置同步代理时，三个同步服务都直接连接；填写本地代理端口后，自建、Cloudflare 和自定义服务都会统一使用该端口。Cloudflare 备用服务在部分网络下可能需要代理。
- 主 App：在 `数据同步 -> 连接方式` 中填写本地代理端口；留空为直连，填写 `1-65535` 的数字（例如 `51888`）后使用本机 `127.0.0.1:<端口>`。用户不需要填写 `127.0.0.1`、完整 URL 或 `direct`；旧版地址会兼容迁移。
- 代理端口不是固定值，请在自己的代理软件里查看本机 HTTP 代理端口。比如 v2rayN、Clash、Mihomo 等软件一般会在设置或端口页面显示 `HTTP Port` / `Mixed Port`。

## 配置导入

新版配置包会导出设置、关注、标签、历史、弹幕屏蔽词和屏蔽词预设；Cookie、WebDAV 密码等敏感内容默认不会写入配置包。

兼容说明：

- 支持导入新版 `simple_live_profile.json`。
- 支持导入旧版 `simple_live_config.json`，但旧版“其他设置导出”本身通常只包含设置和弹幕屏蔽词，不一定包含关注列表。
- 支持兼容旧 WebDAV/同步备份里的关注、标签、历史数组格式。
- 如果旧备份文件仍然提示格式错误，或关注列表没有恢复，可以提交备份文件样例和报错信息用于补充兼容。

TV 版已在 `Android Emulator - Medium_Phone`（`Android 16 / API 36 / x86_64`）完成基础验证，虎牙、斗鱼、抖音直播可正常播放。TV 播放建议保持 `硬件解码` 开启。

TV 下载建议：

- `SimpleLive-TV-arm64-v8a-release.apk`：适合大多数 64 位安卓电视 / 电视盒子，`NVIDIA SHIELD Android TV` 优先下载这个。
- `SimpleLive-TV-armeabi-v7a-release.apk`：适合较老的 32 位安卓电视设备。
- `SimpleLive-TV-x86_64-release.apk`：适合 Android Studio / AVD 模拟器等 `x86_64` 环境。
- 如果不确定设备架构，优先看系统信息里的 `arm64-v8a / armeabi-v7a / x86_64`，不要盲下“最新版”。

## 实时字幕

当前版本暂时下线实时字幕入口，相关开关、样式和模型说明不再对外展示。

## 抖音搜索 Cookie

抖音播放可以使用内置 `ttwid` 兜底，但房间名 / 主播名搜索经常要求登录态。搜索不可用时，需要在 `账号管理 -> 抖音 -> Cookie登录` 粘贴桌面浏览器登录后的完整 Cookie，不要只粘贴单个 `ttwid`。

电脑端获取方式：

- 在浏览器打开 `www.douyin.com` 或 `live.douyin.com` 并登录。
- 按 `F12` 打开开发者工具，切到 `Network / 网络`。
- 刷新页面或随便点一次页面，让浏览器产生一个抖音域名请求。
- 点开任意 `douyin.com` 请求，在 `Request Headers / 请求标头` 找到 `cookie`。
- 复制 `cookie` 后面完整的一大串，粘贴到 SimpleLive 的抖音 Cookie 登录框。

应用也兼容直接粘贴 `Cookie: xxx`，或粘贴浏览器复制出来的整段请求头；会自动从其中提取 `cookie` 字段。Android / iOS 端只保留粘贴 Cookie 和文件导入，搜索 Cookie 建议仍从电脑浏览器获取后粘贴或同步。TV 端不内置浏览器，请从主 App 同步完整 Cookie。

抖音账号页会尝试从完整 Cookie 的 `sid_guard` 中解析预计剩余有效期；如果只配置了 `ttwid`，或请求头 Cookie 里没有可解析的过期信息，会提示有效期无法判断。Cookie 仍可能因退出登录、改密或平台风控提前失效。

## 支持直播平台

- 虎牙直播
- 斗鱼直播
- 哔哩哔哩直播
- 抖音直播
- 快手直播

## APP 支持平台

- [x] Android
- [x] iOS
- [x] Windows
- [x] MacOS
- [x] Linux
- [x] Android TV
- [x] TV-windows（TV的UI在Windows上运行，相较纯TV，此版本支持多开）

## 开发环境

- Flutter：`3.41.9`（主 App 与 TV App）
- Dart：使用 Flutter 自带的 Dart SDK
- Android 构建：Java `17`（CI 配置）

## 参考及引用

[AllLive](https://github.com/xiaoyaocz/AllLive) `本项目的 C# 版，有兴趣可以看看`

[xiaoyaocz/dart_simple_live](https://github.com/xiaoyaocz/dart_simple_live) `当前公开仓库的上游 fork 来源`

[dart_tars_protocol](https://github.com/xiaoyaocz/dart_tars_protocol.git)

[wbt5/real-url](https://github.com/wbt5/real-url)

[lovelyyoshino/Bilibili-Live-API](https://github.com/lovelyyoshino/Bilibili-Live-API/blob/master/API.WebSocket.md)

[IsoaSFlus/danmaku](https://github.com/IsoaSFlus/danmaku)

[BacooTang/huya-danmu](https://github.com/BacooTang/huya-danmu)

[TarsCloud/Tars](https://github.com/TarsCloud/Tars)

[YunzhiYike/douyin-live](https://github.com/YunzhiYike/douyin-live)

[5ime/Tiktok_Signature](https://github.com/5ime/Tiktok_Signature)

[EmojiAll 抖音平台表情](https://www.emojiall.com/zh-hans/platform-douyin) `感谢提供抖音平台表情参考，项目内仅作为本地静态表情资源使用`

## 声明

本项目的功能基于互联网上公开资料整理与开发，无任何破解、逆向工程等行为。

本项目仅用于学习交流编程技术，严禁用于商业目的。如有任何商业行为，均与本项目无关。

如果本项目存在侵犯您合法权益的情况，请及时联系开发者，开发者会及时处理相关内容。

## 绝对禁止更新的一些功能

> [!WARNING]
>
> 不碰账号，不碰钱，不碰写操作，不碰官方活动。

- 官方账号登录、注册、找回密码、实名、绑定手机、未成年人模式。
- 官方账号维度的关注、取关、拉黑、消息已读、历史同步、收藏同步。
- 任何充值相关功能：钱包、余额、B币、银瓜子、金瓜子、虎牙币、电池、礼物背包、订单、退款、兑换码、优惠券。
- 任何付费互动：送礼物、上头条、上舰、续费大航海、开贵族、点亮粉丝牌、付费表情、充电、打赏。
- 任何“发出去”的直播互动：发送弹幕、评论、点赞、分享任务、投票、PK 助力、上麦申请、连麦申请。
- 任何社交功能：点赞、私信、群聊、应援团消息、用户聊天、主播私信。
- 任何治理功能：举报、申诉、房管、禁言、踢人、拉黑官方账号关系。
- 任何官方活动：抽奖、福袋、红包、竞猜、宝箱、签到、任务中心、经验成长、勋章升级、直播间成就。
- 任何主播后台：开播、改标题、改分区、公告、商品橱窗、收益、数据后台、粉丝管理。
- 任何电商闭环：直播间购物、商品跳转下单、会员购、店铺、带货组件。
- 离线缓存、录播下载、源流下载、批量导出。
- 完整首页推荐流、热榜、官方消息中心、Push 通知中心。
- 动态发布、评论发布、社区互动、投稿。
- 官方账号体系下的“我的”页面复刻，比如钱包、勋章、等级、任务、资产全量展示。
- 过于完整的录播 / 回放 / 追更体系，尤其是能替代用户回到官方 App 的那种。



## Star History

![star-history-202676](./images/README/star-history-202676.png)
