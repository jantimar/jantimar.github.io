---
layout: post
author: Jan Timar
title:  "Style app in SwiftUI"
date:   2020-03-09 10:10:00 +0100
---
In good old UIKit times, when I worked on the white label app [News][2], it was very helpful to separate app views/controllers from app stylings like colors and fonts. Nowadays, in the SwiftUI century, I tried to apply the same pattern.

Our first task is to define `AppStyleProtocol`, this usually looks the same as in UIKit.

```swift
protocol AppStyleProtocol {
    var colors: AppColorsProtocol { get }
    var fonts: AppFontsProtocol { get }
}
 
protocol AppColorsProtocol {
    var text: Color { get }
    var background: Color { get }
}
 
protocol AppFontsProtocol {
    var title: Font { get }
}
```

The second step, the same as in UIKit, is to create some implementation of `AppStyleProtocol`.

```swift
struct LimeAppStyle: AppStyleProtocol {
    let colors: AppColorsProtocol = LimeAppColors()
    let fonts: AppFontsProtocol = AppFonts()
}
 
struct LimeAppColors: AppColorsProtocol {
    let text = Color.red
    let background = Color.green
}
 
struct AppFonts: AppFontsProtocol {
    let title = Font.headline
}
```

<b>Tip:</b> In SwiftUI world to make things easier we can inject `AppStyleProtocol` implementation to every SwiftUI View like environment variable. I define a new environment `style` property for that. This environment property can be set only on the first View and then is injected to every SwiftUI View.

```swift
struct AppStyleKey: EnvironmentKey {
    static let defaultValue: AppStyleProtocol = AppStyle()
}
 
extension EnvironmentValues {
    var style: AppStyleProtocol {
        get { self[AppStyleKey.self] }
        set { self[AppStyleKey.self] = newValue }
    }
}
```

<b>Tip:</b> By using a `View` and `Text` extensions we can make our implementation more clear and powerful.

```swift
extension View {
    func style(_ style: AppStyleProtocol) -> some View {
        self
            .background(style.colors.background)
    }
}
 
extension Text {
    func title(_ style: AppStyleProtocol) -> some View {
        self
            .foregroundColor(style.colors.text)
            .font(style.fonts.title)
    }
}

```

And finally can implement some view and easily style without define any specific color, font or what you want in your custome View.

```swift
struct SampleView: View {
    @Environment(\.style) var style: AppStyleProtocol
 
    var body: some View {
        VStack {
            Text("Fruits!")
                .title(style)
        }
        .frame(width: 300, height: 300)
        .style(style)
    }
}
```

Same View with different AppStyle - `default` `lime` and `orange` then can looks like this:
![AppStyle example](/assets/SwiftUIAppStyle/appstyle_example.png){:class="img-responsive"}

[Download code example][1] with LimeAppStyle and OrangeAppStyle.

[1]:http://jantimar.github.io/assets/SwiftUIAppStyle/Sample.swift
[2]:https://apps.apple.com/cz/app/news-sk/id1074421510?l=cs