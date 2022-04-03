import SwiftUI

struct SaveButton: View {

    let showCheckmark: Bool
    let showButton: Bool
    let didTappedSave: () -> Void

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "checkmark.circle")
                .opacity(showCheckmark ? 1.0 : 0.0)
                .foregroundColor(Color.theme.green)

            Button {
                didTappedSave()
            } label: {
                Text("Save".uppercased())
            }
            .opacity(showButton ? 1.0 : 0.0)
        }
        .font(.headline)
        .foregroundColor(Color.theme.accent)
    }
}

#if DEBUG
struct SaveButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SaveButton(showCheckmark: false, showButton: true) { }
                .previewLayout(.sizeThatFits)

            SaveButton(showCheckmark: false, showButton: true) { }
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)

            SaveButton(showCheckmark: true, showButton: true) { }
                .previewLayout(.sizeThatFits)

            SaveButton(showCheckmark: true, showButton: true) { }
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
#endif
