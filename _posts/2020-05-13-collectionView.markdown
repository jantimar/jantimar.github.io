---
layout: post
author: Jan Timar
title:  "CollectionView in SwiftUI"
date:   2020-05-14 7:30:00 +0100
---

Yeah, the title is a little bit a clickbait because you probably know, it doesn’t exist. This article will be a little bit my point of view on how to implement grid collectionView in SwiftUI. Yes, there are few options, but probably everyone has a disadvantage.

### 3rd party lirbary

A few days ago I have seen in one project [ASCollectionView][1] to implement a simple Grid layout. My first idea was "Why?". I don't think libraries are bad, but ... it can bring more complications in the future, it shouldn't fit your case and usually, you wait for someone to fix some magic issue and many more. And in the end, this solution is just `UICollectionView` with UIViewRepresentable, so you can implement it in your way.

### UICollectionView with UIViewRepresentable

If you know something in `UIKit` and you can't find an ideal solution in `SwiftUI`, you probably can use `UIViewRepresentable`.

```swift
struct CollectionView {
    @State var cellTypes: [(type: AnyClass?, reuseIdentifier: String)]
    @State var dataSource: UICollectionViewDataSource? = nil
    @State var delegate: UICollectionViewDelegate? = nil
}

// MARK: - UIViewRepresentable
extension CollectionView: UIViewRepresentable {
    typealias UIViewType = UICollectionView

    func makeUIView(context: UIViewRepresentableContext<CollectionView>) -> CollectionView.UIViewType {
        let collectionView = UICollectionView()

        cellTypes.forEach { (type, reuseIdentifier) in
            collectionView.register(type, forCellWithReuseIdentifier: reuseIdentifier)
        }

        collectionView.dataSource = dataSource
        collectionView.delegate = delegate

        return collectionView
    }

    func updateUIView(_ uiView: UICollectionView, context: UIViewRepresentableContext<CollectionView>) { }
}
```

The disadvantage of this solution is, it is not SwiftUI and `UICollectionViewDataSource` is `NSObjectProtocol`. Probably when you decide for SwiftUI you don't want UIKit in your app if it is not required.

### SwiftUI way

As I said at the beginning of this article, SwiftUI way for CollectionView doesn't exist. Wait minute, we can try to create it. Here is my way. At first, I create some helper a wrapper for Cell in collectionView.

```swift
private struct Cell: View, Identifiable {
    /// Unique ID
    var id: Int

    var body: some View {
        AnyView(content)
    }

    init<T: View>(
        _ content: T,
        _ index: Int
    ) {
        self.id = index
        self.content = AnyView(content)
    }

    /// Empty cell
    init() {
        self.id = UUID().hashValue
        self.content = AnyView(Rectangle().foregroundColor(.clear))
    }

    private let content: AnyView
}

extension Cell: Hashable {
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
```

In the view `init` separate content values to rows and make little bit magic to add empty cells to the last row if it is needed because every row must have the same number of cells.

```swift
struct ColumnList<Value: View>: View {

    var body: some View { ... }

    init(
        colums: Int,
        content: [Value]
    ) {
        var collection: [[Cell]] = .init()

        // Add additional cells
        var rows = content.count / colums
        if content.count % colums > 0 {
            rows += 1
        }

        // Create row
        for rowIndex in 0..<rows {
            // Count offset for current row
            let offset = rowIndex * colums

            // Create cells in row
            var row: [Cell] = .init()
            for columIndex in 0..<colums {
                let index = offset + columIndex
                if index < content.count {
                    row.append(
                        Cell(content[index], index)
                    )
                }
            }

            collection.append(row)
        }

        // Add clear cells to additional row
        if content.count % colums > 0 {
            var lastRow = collection.removeLast()
            let lastRowCells = content.count % colums
            for _ in 0..<(colums - lastRowCells) {
                lastRow.append(Cell())
            }
            collection.append(lastRow)
        }

        self.content = collection
    }

    // MARK: - Private properties

    private let content: [[Cell]]
}
```

Final part is implemented View `body`, and is there two ways. First, it is with ScrollView, it looks very nice, is simple but is there a memory issue. When you have a lot of cells, for example, you want to show all your 1000 songs, your app will crash for low memory.

```swift
ScrollView(.vertical) {
    VStack(spacing: 0) {
        ForEach(content, id: \.self) { row in
            HStack(spacing: 0) {
                ForEach(row, id: \.self) { $0 }
            }
        }
    }
}
```

The second option is to replace ScrollView with List. But this solution has a disadvantage - cell separator. I did resolved it with `UITableView.appearance().separatorStyle = .none`, but I think it is little bit big side effect, because it applies to everyone's new List.

```swift
List {
    ForEach(content, id: \.self) { row in
        HStack(spacing: 0) {
            ForEach(row, id: \.self) { $0 }
        }
    }
    .listRowInsets(.init())
}
.onAppear {
    // Side efect :(
    UITableView.appearance().separatorStyle = .none
}
```

Here is my preview if you want to try it.

```swift
struct ColumnList_Previews: PreviewProvider {
    private struct Element: View {
        let element: Int

        var body: some View {
            ZStack {
                Rectangle()
                    .frame(height: 40)
                    .foregroundColor(.red)
                    .padding(2)
                Text("\(element)")
            }
        }
    }

    static var previews: some View {
        let elements = (0..<1001)
            .map(Element.init(element:))

        return ColumnList(colums: 4, content: elements) {
            print("Last row appear")
        }
    }
}
```

{:refdef: style="text-align: center;"}
![Notification](/assets/CollectionView/Preview.png){:class="img-responsive"}
{: refdef}

### In the end

To sum up, CollectionView didn't exist in the SwiftUI world without a disadvantage. This is reality. When I should implement CollectionView with a small number of cells I will decide for clear SwiftUI implementation with `ScrollView`, and for more cells, I will decide for `List`. You can choose any one of my solutions, I can not say which is the best (or the worst) for you, it really depends only on your case and which way you prefer.

PS: If you know about better solution (or just other 😅) feel free to write me.

[1]:https://github.com/apptekstudios/ASCollectionView