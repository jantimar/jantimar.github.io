---
layout: post
author: Jan Timar
title:  "Set NavigationBar background like a boss"
date:   2020-04-23 8:10:00 +0100
---

When you are growing up on `UIKit` and never touch `SwiftUI`, you will probably never open this post because you imagine it is something like set a color to one property. But you are wrong. 

You can call `background(Color.red)` on `NavigationView`, but it have no impact on background of your `NavigationBar` or anything else 🙇‍♂️. There is noting like `navigationBar` property in `SwiftUI`. Yes you can set a color on appeareanse with small UIKit "hack" `UINavigationBar.appearance().backgroundColor = UIColor.red`, but it is `UIColor` and it's not probably what you really want.

Don't give up, is there almost one solution, add a color with ignoring safe area in your contnent. Best practice is create new `View`, in my case it is `Screen`, which will wrapp content inside, after set color for `navigationBar` and then for your backgorund.

```swift
struct Screen<Content: View>: View {
    var body: some View {
        ZStack {
            navigationBarColor.edgesIgnoringSafeArea(edges)
            background
            content
        }
    }

    init(
        edges: Edge.Set = [.top],
        navigationBarColor: Color = .red,
        background: Color = .white,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.edges = edges
        self.navigationBarColor = navigationBarColor
        self.background = background
    }

    /// Content inside element
    private let content: Content
    private let edges: Edge.Set
    private let navigationBarColor: Color
    private let background: Color
}
```

Every new screen is wrapped in `Screen` element. With this little update you don't must set every time your navigation bar color.

```swift
struct Screen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Screen {
                Text("Nah")
            }
        }
    }
}
```

{:refdef: style="text-align: center;"}
![Screen preview](/assets/Screen/screen.png){:class="img-responsive"}
{: refdef}

<b>Tip:</b> When you remember my first [post about AppStyle][1], then you can use it to improve this solution.

```swift
struct Screen<Content: View>: View {
    @Environment(\.style) var style: AppStyleProtocol

    var body: some View {
        ZStack {
            style.colors.main.edgesIgnoringSafeArea(edges)
            style.colors.background
            content
        }
    }

    /// Create screen View
    /// - Parameters:
    ///   - edges: Edges of navigation background, for use background color under `Home Indicator` use `[.top, .bottom]` edges
    ///   - content: Screen content
    init(
        edges: Edge.Set = [.top],
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.edges = edges
    }

    /// Content inside element
    private let content: Content
    private let edges: Edge.Set
}
```

[1]:https://jantimar.github.io/2020/04/09/appstyle_in_swiftui.html
[2]:https://github.com/jantimar/SwiftUI-snippets
