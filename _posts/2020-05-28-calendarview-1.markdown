---
layout: post
author: Jan Timar
title:  "CalendarView: Part 1: From Day to Month"
date:   2020-05-28 7:30:00 +0100
---

A few days ago, I decided to implement own version of [CalendarView][1] where user can easily select a day, or see some events in the selected month. Because it’s a little bit complicated element I decide to divide it into a few parts. And this post is about Views from a Day to the Month. And of course, it is 100% SwiftUI.

### One day

Everything should start from the smallest piece of component, from the smallest issue, in my case it is `DayView`. 

```swift
struct DayView: View {
    var body: some View {
        ZStack {
            Text("10")
    }
}
```

To define attributes, I created `Day` state which contains all values which will be available to set on `DayView`.

```swift
struct Day {
    let number: Int
    var isHeighlighted = false
    var isSelected = false
    var isEnabled = true
    var isCurrent = false
    var onSelect: (() -> Void) = {}
}
```

Now I can extend `DayView` with all attributes and create a view with any `Day` configuration.

```swift
struct DayView: View {
    let day: Day

    var body: some View {
        ZStack {
            Text("\(day.number)")
                .font(.system(size: 14))
                .foregroundColor(day.isCurrent ? .blue : .none)
                .frame(width: 30, height: 30)
                .overlay(
                    Circle()
                        .stroke(
                            Color.blue,
                            lineWidth: day.isSelected ? 1 : 0
                    )
            )
            if day.isHeighlighted {
                Circle()
                    .frame(width: 4, height: 4)
                    .offset(x: 0, y: 12)
                    .foregroundColor(.blue)
            }
        }
        .opacity(day.isEnabled ? 1 : 0.25)
        .padding(4)
        .onTapGesture(perform: day.onSelect)
    }
}
```
Here are examples of few days configurations.

```swift
DayView(day: Day(number: 10))
```
![default](/assets/calendarview/default.png)
Default

```swift
DayView(day: Day(number: 22, isHeighlighted: true))
```
![heighlighted](/assets/calendarview/heighlighted.png)
Heighlighted

```swift
DayView(day: Day(number: 22, isSelected: true))
```
![selected](/assets/calendarview/selected.png)
Selected

```swift
DayView(day: Day(number: 23, isCurrent: true))
```
![current](/assets/calendarview/current.png)
Current

```swift
DayView(day: Day(number: 31, isEnabled: false))
```
![disabled](/assets/calendarview/disabled.png)
Disabled

### Seven days in a row is a Week

When we have one day, we can compose one aweek to a specific `WeekView` component. I create a new `Week` states to handle `days` and unique identifier.

```swift
struct Week: Identifiable {
    let id = UUID()
    let days: [Day]
}
```

Now `WeekView` shows all days in a horizontal stack.

```swift
struct WeekView: View {
    let week: Week

    var body: some View {
        HStack {
            ForEach(week.days, id: \.number) {
                DayView(day: $0)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}
```
{:refdef: style="text-align: center;"}
![week](/assets/calendarview/week2.png){:class="img-responsive"}
{: refdef}

### A few weeks in a row is a Month

Similar to with week, we can now compose `MonthView` with few a `WeekView`s in `VStack`.

```swift
struct MonthView: View {
    let weeks: [Week]

    var body: some View {
        VStack {
            ForEach(weeks, content: WeekView.init(week:))
        }
    }
}
```
{:refdef: style="text-align: center;"}
![week](/assets/calendarview/month.png){:class="img-responsive"}
{: refdef}

### In the end

Every time when you see something new from your app designer and on first look is a little bit complicated, you still can make a deep breath and separate it into small components. Then every complicated a View, for example, [CalendarView][1] is more simple.

And your code is more readable 😉.

{:refdef: style="text-align: center;"}
![week](/assets/calendarview/calendar.png){:class="img-responsive"}
{: refdef}

[1]:https://github.com/jantimar/CalendarView