import SwiftUI

struct XMarkButton: View {

    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .foregroundColor(Color.theme.accent)
        }
    }
}

#if DEBUG
struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            XMarkButton {}
                .previewLayout(.sizeThatFits)
                .padding()

            XMarkButton {}
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .padding()
        }
    }
}
#endif
