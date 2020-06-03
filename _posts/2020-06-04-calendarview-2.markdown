---
layout: post
author: Jan Timar
title:  "CalendarView: Part 2: That's how time goes"
date:   2020-06-04 7:30:00 +0100
---

In [previous part][1] I describe how CalendarView looks. In this part of [CalendarView][5] implementation, I will describe how it works. How we can separate logic and hold our codebase clear.

### Date extension

Extension for Foundation classes can make them stronger and easily testable. As first we should imagine how we will work with objects, which properties we will hold in our functions. For example, you can get a year from Date with Calendar so the first idea can be Calendar extension.
```swift
extension Calendar {
    func year(_ date: Date) -> Int {
        self
            .component(.year, from: date)
    }
}
```
But in my implementation, I hold `Date` property so it is more useful, make an extension on `Date` type.
```swift
extension Date {
    var year: Int {
        Calendar
            .current
            .component(.year, from: self)
    }
}
```

The second thing which is great on extensions and a lot of time forgotten is adding new initializers which can really make our code simple. Great benefits on optional inits are your validate your input properties inside init in one place.
```swift
extension Date {
    init?(year: Int, month: Int, day: Int = 1) {
        guard let date = Calendar
            .current
            .date(
                from: DateComponents(year: year, month: month, day: day)
            ) else { return nil }
        self = date
    }
}
```

<b>Note:</b> All my `Date` extensions you can see on current [link][2].

### Current state

I tried a few architectures or better say ways how to handle data for the screen ([ClearSwiftUI][3], MVVM, MVVM-C...). Few weeks I think best for small projects is `MVVM`and I hold data in screen `ViewModel`. But sometimes the model should handle a lot of `@Published` properties and base on your app performance is better to update it in one step. So, I decided to separate my `ViewModel` screen properties to `state` (in my case `Page`) and `CalendarViewModel` contains only one `@Published` property.

<b>Note:</b> This is only my point of view on the current SwiftUI options. You can not say some architecture is better or worst. Every architecture has advantages and disadvantages.

```swift
struct Page {
    let month: Int
    let year: Int
    let heighlighted: [Date]
    let selected: Date?
    var select: ((Date) -> Void) = { _ in }

    var date: Date? {
        Date(year: year, month: month)
    }

    var weeks: [Week] {
        ...
    }

    private var previousMonthDays: Int {
        ...
    }

    private func dayModelFor(day: Int) -> Day {
        ...
    }
}
```

`Page` represents the current state of the main component and defines everything that you can see:
- current month
- year
- highlighted days
- selected day
- closure to handle user tap action on someday
- current month date
- weeks

Weeks are computed properties that create an array of weeks for the current month. But in the short story, it groups last days from the previous month, all days from the current month and days from next month to show in every case 42 days. With this constant we can guarantee all days from the current month will be visible in all edge cases with the same number of weeks, so there are no height jumps when the user swipe to another month.

### The last piece of the puzzle

The last piece of all of this is to join it together, join new ViewModel with SwiftUI View. As you can see, now ViewModel just handles the current state in two properties (`current: Page` and `selectedDate: Date?`) and public functions what are user tap actions on the current component.

```swift
final public class CalendarViewModel: ObservableObject {
    @Published public var selectedDate: Date?
    @Published var current: Page

    var formattedDate: String { "\(current.month). \(current.year)" }
    private(set) lazy var weekdaySymbols: [String] = DateFormatter().shortWeekdaySymbols

    public init(
        today: Date = .init(),
        heighlighted: [Date] = .init(),
        selectedDate: Date? = nil
    ) {
        self.heighlighted = heighlighted
        self.today = today
        self.current = Page(
            month: today.month,
            year: today.year,
            heighlighted: heighlighted,
            selected: selectedDate
        )
        self.current.select = update(date:)
    }

    private let heighlighted: [Date]
    private let today: Date

    func nextPage() {
        ...
    }

    func previousPage() {
        ...
    }

    private func update(date: Date) {
        ...
    }

    private func reloadPage(
        month: Int,
        year: Int
    ) {
        ...
    }
}
```

<b>Note:</b> Full `Page` and `CalendarViewModel` you can see on the current [link][4].

{:refdef: style="text-align: center;"}
![Coordinator](/assets/calendarview/video.mov)
{: refdef}

### In the end

Not only complex view can be separate to simple small views, but the logic of your components can be separate to state, viewModels, extensions, and be more readable and of course one day testable 😉.

[1]:https://jantimar.github.io/2020/05/28/calendarview-1.html
[2]:https://github.com/jantimar/CalendarView/blob/master/Sources/CalendarView/Extensions/Date%2BExtension.swift
[3]:https://github.com/nalexn/clean-architecture-swiftui
[4]:https://github.com/jantimar/CalendarView/blob/master/Sources/CalendarView/CalendarViewModel.swift
[5]:https://github.com/jantimar/CalendarView
