---
layout: post
author: Jan Timar
title:  "No more empty screens"
date:   2020-04-30 8:10:00 +0100
---

Do you know that bad feeling when your backend is broken or API returns empty array of nothing? I think the worst things are when you don’t inform the user about “Something is wrong” or “For your filter is there no results” and he still waiting for something.

For these reasons I tried to create `PlaceholderView` to inform the user about some error, response, or whatever else. 

<b>Tip:</b> Maybe `InfoView` is little bit better name, but in my App exist screen with this name. `EmptyView` is reserved by [Apple][1] and `ErrorView` sounds specific only for some cases.

Some cases in the App require a message, other for example errors require an image in red color and other just only image. So, I decided to separate this task into two steps:
1. Create universal `PlaceholderView` independent on content
2. Create  `PlaceholderViewType`, content for `PlaceholderView`

### 1. Universal `PlaceholderView`

However, this article is about `PlaceholderView`, this part of code is very short. Just wrap content in the middle and set a placeholder background.

```swift
struct PlaceholderView: View {
    let type: PlaceholderType

    var body: some View {
        type.content
            .multilineTextAlignment(.center)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.1))
    }
}
```

### 2. Content for `PlaceholderView`

Thanks to `AnyView` we can wrap any content to our `PlaceholderView`

```swift
struct PlaceholderType {
    var content: AnyView
}
```

Finally, we can with extension `PlaceholderType` prepare content easily and fast.

```swift
extension PlaceholderType {
    /// Placeholder type with `Text` element
    /// - Parameter text: `Text` element string
    static func text(_ text: String) -> PlaceholderType {
        PlaceholderType(content: AnyView(Text(text)))
    }

    /// Placeholder type with `Image` element
    /// - Parameter image: Name of image in Assets
    static func image(_ image: String) -> PlaceholderType {
        PlaceholderType(content: AnyView(Image(image)))
    }

    /// Placeholder type with witm `Image` and `Text` elements
    /// - Parameters:
    ///   - imageName: Name of image in Assets
    ///   - color: Temple image color, if is not set, image will rendering with original colors
    ///   - text: `Text` element string
    static func image(_ imageName: String, color: Color? = nil, text: String) -> PlaceholderType {
        let image: AnyView
        if let color = color {
            image = AnyView(
                Image(imageName)
                    .renderingMode(.template)
                    .foregroundColor(color)
            )
        } else {
            image = AnyView(Image(imageName))
        }

        return PlaceholderType(content:
            AnyView(
                VStack {
                    image
                    Text(text)
                }
            )
        )
    }
}
```

<b>Info:</b> In the first solution of my `PlaceholderView` I used `enum`, but in the future I decide change it to `struct`. Now you can extend it and modify it very easily from any part of your app. 

### We are in the final

Now we can use this helper view to inform the user about the current state.

{:refdef: style="text-align: center;"}
![Placeholer preview](/assets/Placeholder/preview.png){:class="img-responsive"}
{: refdef}

```swift
struct PlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PlaceholderView(type: .text("No more data in this world!"))
            PlaceholderView(type: .image("city"))
            PlaceholderView(type: .image("city", text: "Unrecognized city name"))
            PlaceholderView(type: .image("city", color: .red, text: "Something is wrong!"))
        }
    }
}
```

[1]:https://developer.apple.com/documentation/swiftui/emptyview