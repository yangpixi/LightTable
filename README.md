# LightTable

English | [中文](README.zh-CN.md)

LightTable is a lightweight iOS timetable app built with SwiftUI. It helps students import, view, adjust, and keep track of course schedules, with a small WidgetKit widget for the nearest upcoming classes.

## Features

- Week-by-week timetable view with horizontal paging.
- Automatic current-week and current-day highlighting based on the semester start date.
- Course detail editing for course name, location, and class periods.
- Multiple timetable management with active timetable selection and deletion.
- Semester settings, including timetable name, total weeks, and start date.
- Custom period-time settings for daily class sections.
- Web-based timetable import through supported school portals.
- Small iOS widget that shows the current upcoming course and the next course.
- Shared SwiftData storage through an App Group so the app and widget read the same data.

## Supported Import Sources

The current built-in source is:

- Central South University (`Csu`)

Timetable import is implemented with a school-specific JavaScript extractor loaded inside a `WKWebView`. Because this depends on the structure of the school portal page, the extractor may need updates if the portal changes.

## Import Flow

1. Open **Settings**.
2. Go to **Timetable Management**.
3. Choose **Import New Timetable**.
4. Select a supported school.
5. Log in through the embedded portal page and navigate to the timetable page.
6. Tap the floating **plus** button to extract and save the timetable.
7. Go to **Timetable Settings** to select the active timetable and adjust the semester or period settings.

Imported timetables are saved locally with SwiftData. The active timetable identifier is stored in the shared App Group user defaults so the widget can load the same timetable.

## Tech Stack

- Swift
- SwiftUI
- SwiftData
- WidgetKit
- WebKit / `WKWebView`
- App Groups

No third-party package dependencies are currently required.

## Requirements

- macOS with Xcode that supports the configured iOS SDK.
- iOS deployment target configured in the project:
  - `LightTable`: iOS 26.0
  - `TableWindowExtension`: iOS 26.1
- Apple Developer signing setup if you run on a physical device or use App Groups.

The app and widget both use the App Group identifier:

```text
group.com.yangpixi.LightTable
```

If you change the bundle identifier or development team, update the App Group capability for both targets consistently.

## Build and Run

Open the project in Xcode:

```bash
open LightTable.xcodeproj
```

Then:

1. Select the `LightTable` scheme.
2. Configure signing for the app target and the `TableWindowExtension` target.
3. Make sure both targets use the same App Group.
4. Build and run on a simulator or device.

Command-line build example:

```bash
xcodebuild \
  -project LightTable.xcodeproj \
  -scheme LightTable \
  -configuration Debug \
  -destination 'generic/platform=iOS' \
  CODE_SIGNING_ALLOWED=NO \
  build
```

## Project Structure

```text
LightTable/
  Main/                    App entry and root tab navigation
  Views/                   Home, settings, import, and timetable settings screens
  Components/              Timetable cells, pages, course sheet, and period rows
  Bridge/WebView/          SwiftUI bridge for WKWebView
  Scripts/                 School-specific timetable extraction scripts

Shared/
  Data/                    SwiftData model container and default data setup
  Models/                  Course, table, period, and school models
  Utils/                   Course, time, and script utilities
  Errors/                  Shared error types

TableWindow/
  Widget implementation for the small timetable widget
```

## Adding Another School Source

To add support for another school portal:

1. Add an extractor script named `LightTable/Scripts/<ShortName>ExtractScript.js`.
2. Make the script return a JSON string with this shape:

```json
{
  "term": "2025-2026-2",
  "courses": [
    {
      "name": "Course Name",
      "location": "Room",
      "teacher": "Teacher",
      "weekInterval": [1, 2, 3],
      "weekday": 2,
      "period": [1, 2]
    }
  ]
}
```

3. Register the school in `LightTableDatabase.initializeDefaultDataIfNeeded()`.
4. Reinstall the app, reset simulator data, or add a migration/update path, because the default school data is initialized only once.

Notes:

- `term` must use the `YYYY-YYYY-Semester` format, for example `2025-2026-2`.
- `weekday` follows `Calendar.current.component(.weekday, ...)`: `1` is Sunday and `7` is Saturday.
- `period` stores the class-section numbers for the course.

## License

This project is licensed under the GNU General Public License v3.0. See [LICENSE](LICENSE) for details.

Copyright (C) 2026 yangpixi.
