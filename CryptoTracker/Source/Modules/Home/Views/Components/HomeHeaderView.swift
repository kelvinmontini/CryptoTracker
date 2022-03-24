import SwiftUI

struct HomeHeaderView: View {

    @Binding var showPortfolio: Bool

    var body: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )

            Spacer()

            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.accent)
                .animation(.none, value: showPortfolio)

            Spacer()

            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(
                    Angle(degrees: showPortfolio ? 180 : 0)
                )
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}

#if DEBUG
struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeHeaderView(showPortfolio: .constant(false))
                .previewLayout(.sizeThatFits)

            HomeHeaderView(showPortfolio: .constant(false))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)

            HomeHeaderView(showPortfolio: .constant(true))
                .previewLayout(.sizeThatFits)

            HomeHeaderView(showPortfolio: .constant(true))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
#endif
