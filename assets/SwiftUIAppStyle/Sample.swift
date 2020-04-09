import SwiftUI

// Define AppStyle protocols

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

// AppStyle implementations

struct AppFonts: AppFontsProtocol {
    let title: Font = Font.headline
}

// Implement Lime AppStyle

struct LimeAppStyle: AppStyleProtocol {
    let colors: AppColorsProtocol = LimeAppColors()
    let fonts: AppFontsProtocol = AppFonts()
}

struct LimeAppColors: AppColorsProtocol {
    let text = Color.red
    let background = Color.green
}

// Implement Orange AppStyle

struct OrangeAppStyle: AppStyleProtocol {
    let colors: AppColorsProtocol = OrangeAppColors()
    let fonts: AppFontsProtocol = AppFonts()
}

struct OrangeAppColors: AppColorsProtocol {
    let text = Color.white
    let background = Color.orange
}

// Define AppStyle environment key

struct AppStyleKey: EnvironmentKey {
    static let defaultValue: AppStyleProtocol = LimeAppStyle()
}

extension EnvironmentValues {
    var style: AppStyleProtocol {
        get { self[AppStyleKey.self] }
        set { self[AppStyleKey.self] = newValue }
    }
}

// Helpful extensions

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

// View implementation

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

struct SampleViewDefault_Previews: PreviewProvider {
    static var previews: some View {
        SampleView()
            .environment(\.style, AppStyleKey.defaultValue)
            .previewLayout(.fixed(width: 300, height: 70))
    }
}

struct SampleViewLime_Previews: PreviewProvider {
    static var previews: some View {
        SampleView()
            .environment(\.style, LimeAppStyle())
            .previewLayout(.fixed(width: 300, height: 70))
    }
}

struct SampleViewOrange_Previews: PreviewProvider {
    static var previews: some View {
        SampleView()
            .environment(\.style, OrangeAppStyle())
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
