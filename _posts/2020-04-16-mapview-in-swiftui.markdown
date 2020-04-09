---
layout: post
author: Jan Timar
title:  "MapView in SwiftUI"
date:   2020-04-16 10:10:00 +0100
---
SwiftUI is still at the beginning of his road. When you remember Swift 1.2 or Swift 2.0 you probably know what I mean. There is still something missing. 

One of the base `View` which is missing in SwiftUI is `MKMapView`. Now, let’s go fix it with `UIViewRepresentable`.

The first solution can look like this:

```swift
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {

	@Binding var annotations: [MKAnnotation]

	// MARK: - UIViewRepresentable
	typealias UIViewType = MKMapView

	func makeUIView(context: UIViewRepresentableContext<MapView>) -> MapView.UIViewType {
		return MKMapView()
	}

	func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
		uiView.removeAnnotations(uiView.annotations)
		uiView.addAnnotations(annotations)
	}
}
```

However, in this solution, all annotation should implement `MKAnnotation` which means everyone pin will inherit from `NSObject` and import `MapKit`

So let’s now go fix this with new `MapAnnotation` protocol.

```swift
protocol MapAnnotation {
	/// The center point (specified as a map coordinate) of the annotation.
	var coordinate: CLLocationCoordinate2D { get }
	/// The string containing the annotation’s title.
	var title: String? { get }
	/// The string containing the annotation’s subtitle.
	var subtitle: String? { get }
}

extension MapAnnotation {
	var title: String? { nil }
	var subtitle: String? { nil }
}
```

And update `MapView` to accept `MapAnnotation` protocol with `MKAnnotationWrapper` helper class.

```swift
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {

	@Binding var annotations: [MapAnnotation]

	// MARK: - UIViewRepresentable
	typealias UIViewType = MKMapView

	func makeUIView(context: UIViewRepresentableContext<MapView>) -> MapView.UIViewType {
		return MKMapView()
	}

	func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
		uiView.removeAnnotations(uiView.annotations)
		uiView.addAnnotations(annotations.map(MKAnnotationWrapper.init(annotation:)))
	}
}

/// Enable remove `NSObject` and `MKAnnotation` depedencies from `MapView` annotations.
private final class MKAnnotationWrapper: NSObject, MKAnnotation {
	/// The center point (specified as a map coordinate) of the annotation.
	var coordinate: CLLocationCoordinate2D { annotation.coordinate }
	/// The string containing the annotation’s title.
	var title: String? { annotation.title }
	/// The string containing the annotation’s subtitle.
	var subtitle: String? { annotation.subtitle }

	var annotation: MapAnnotation

	init(annotation: MapAnnotation) {
		self.annotation = annotation
	}
}
```

Finally, our implementation will look more Swift and is independent of `NSObject`, `import MapKit` and `UIKit`. This solution works perfectly on a real device or simulator only in Preview shows like empty view.

```swift
struct Prague {
    let title = "Prague"
}

extension Prague: MapAnnotation {
    var coordinate: CLLocationCoordinate2D { .init(latitude: 50.08804, longitude: 14.42076) }
}

struct SampleView: View {
    var body: some View {
        MapView(annotations: .constant([Prague()]))
    }
}
```

{:refdef: style="text-align: center;"}
![MapView on iPhone simulator](/assets/MapView/mapView.png){:class="img-responsive"}
{: refdef}

[Look at final MapView][1] implementation or on more other `UIKit` [views implemented to SwiftUI][2].

[1]:https://github.com/jantimar/SwiftUI-snippets/blob/master/MapView.swift
[2]:https://github.com/jantimar/SwiftUI-snippets
