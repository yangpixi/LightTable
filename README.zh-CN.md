# LightTable

[English](README.md) | 中文

LightTable 是一个使用 SwiftUI 构建的轻量级 iOS 课表应用。它用于导入、查看和调整课程表，并提供一个小尺寸 WidgetKit 小组件来展示最近即将开始的课程。

## 功能特性

- 按周展示课表，支持横向分页切换。
- 根据学期开始日期自动计算当前周，并高亮当天日期。
- 支持编辑课程名称、上课地点和课程节次。
- 支持多个课表的管理、选择与删除。
- 支持设置课表名称、学期周数和开学日期。
- 支持自定义每日节次时间。
- 通过受支持学校门户网页导入课表。
- iOS 小组件可显示即将开始的课程和下一节课程。
- 使用 App Group 共享 SwiftData 数据，主 App 和小组件读取同一份课表数据。

## 当前支持的导入来源

当前内置支持：

- 中南大学（`Csu`）

课表导入通过 `WKWebView` 打开学校门户，并执行对应学校的 JavaScript 提取脚本。该方案依赖门户网页结构；如果学校教务系统页面发生变化，提取脚本可能需要同步更新。

## 导入流程

1. 打开 **设置**。
2. 进入 **课表管理**。
3. 选择 **导入新课表**。
4. 选择支持的学校。
5. 在内嵌网页中登录学校门户，并进入课表页面。
6. 点击右下角悬浮的 **加号** 按钮，提取并保存课表。
7. 进入 **课表设置**，选择当前使用的课表，并按需调整学期和节次时间。

导入后的课表会通过 SwiftData 保存在本地。当前选中的课表 ID 会写入 App Group 的 UserDefaults，供小组件读取。

## 技术栈

- Swift
- SwiftUI
- SwiftData
- WidgetKit
- WebKit / `WKWebView`
- App Groups

当前项目没有第三方包依赖。

## 环境要求

- 安装支持当前 iOS SDK 配置的 Xcode。
- 项目中配置的 iOS 部署目标：
  - `LightTable`: iOS 26.0
  - `TableWindowExtension`: iOS 26.1
- 如果要在真机运行或使用 App Group，需要配置 Apple Developer 签名。

主 App 和小组件使用同一个 App Group：

```text
group.com.yangpixi.LightTable
```

如果你修改 Bundle Identifier 或开发者团队，需要同时更新主 App 和小组件 target 的 App Group 能力，确保两者保持一致。

## 构建与运行

用 Xcode 打开项目：

```bash
open LightTable.xcodeproj
```

然后：

1. 选择 `LightTable` scheme。
2. 配置主 App target 和 `TableWindowExtension` target 的签名。
3. 确认两个 target 使用同一个 App Group。
4. 在模拟器或真机上构建并运行。

命令行构建示例：

```bash
xcodebuild \
  -project LightTable.xcodeproj \
  -scheme LightTable \
  -configuration Debug \
  -destination 'generic/platform=iOS' \
  CODE_SIGNING_ALLOWED=NO \
  build
```

## 项目结构

```text
LightTable/
  Main/                    App 入口和底部标签导航
  Views/                   首页、设置、导入和课表设置页面
  Components/              课表单元格、周视图、课程弹窗和节次设置行
  Bridge/WebView/          WKWebView 的 SwiftUI 桥接
  Scripts/                 各学校课表提取脚本

Shared/
  Data/                    SwiftData 容器和默认数据初始化
  Models/                  课程、课表、节次和学校模型
  Utils/                   课程、时间和脚本工具
  Errors/                  共享错误类型

TableWindow/
  小尺寸课表小组件实现
```

## 添加新的学校导入来源

添加新的学校门户支持时，可以按下面步骤处理：

1. 新增脚本文件 `LightTable/Scripts/<ShortName>ExtractScript.js`。
2. 让脚本返回如下结构的 JSON 字符串：

```json
{
  "term": "2025-2026-2",
  "courses": [
    {
      "name": "课程名称",
      "location": "教室",
      "teacher": "教师",
      "weekInterval": [1, 2, 3],
      "weekday": 2,
      "period": [1, 2]
    }
  ]
}
```

3. 在 `LightTableDatabase.initializeDefaultDataIfNeeded()` 中注册学校信息。
4. 重新安装 App、重置模拟器数据，或补充数据迁移逻辑，因为默认学校数据只会初始化一次。

注意：

- `term` 需要使用 `YYYY-YYYY-Semester` 格式，例如 `2025-2026-2`。
- `weekday` 遵循 `Calendar.current.component(.weekday, ...)`：`1` 表示周日，`7` 表示周六。
- `period` 表示课程占用的节次数组。

## 开源协议

本项目使用 GNU General Public License v3.0 协议开源，详情见 [LICENSE](LICENSE)。

Copyright (C) 2026 yangpixi.
