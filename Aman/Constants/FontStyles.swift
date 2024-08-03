import SwiftUI

struct FontStyles {
    struct Heading {
        static let h1 = Font.custom("SFProDisplay-Bold", size: 40)
        static let h2 = Font.custom("SFProDisplay-Bold", size: 32)
        static let h3 = Font.custom("SFProDisplay-Bold", size: 24)
        static let h4 = Font.custom("SFProDisplay-Bold", size: 20)
        static let h5 = Font.custom("SFProDisplay-Bold", size: 18)
        static let h6 = Font.custom("SFProDisplay-Bold", size: 16)
    }

    struct Body {
        static let xLargeBold = Font.custom("SFProDisplay-Bold", size: 18)
        static let xLargeSemibold = Font.custom("SFProDisplay-SemiboldItalic", size: 18)
        static let xLargeMedium = Font.custom("SFProDisplay-Medium", size: 18)
        static let xLargeRegular = Font.custom("SFProDisplay-Regular", size: 18)

        static let largeBold = Font.custom("SFProDisplay-Bold", size: 16)
        static let largeSemibold = Font.custom("SFProDisplay-SemiboldItalic", size: 16)
        static let largeMedium = Font.custom("SFProDisplay-Medium", size: 16)
        static let largeRegular = Font.custom("SFProDisplay-Regular", size: 16)

        static let mediumBold = Font.custom("SFProDisplay-Bold", size: 14)
        static let mediumSemibold = Font.custom("SFProDisplay-SemiboldItalic", size: 14)
        static let mediumMedium = Font.custom("SFProDisplay-Medium", size: 14)
        static let mediumRegular = Font.custom("SFProDisplay-Regular", size: 14)

        static let smallBold = Font.custom("SFProDisplay-Bold", size: 12)
        static let smallSemibold = Font.custom("SFProDisplay-SemiboldItalic", size: 12)
        static let smallMedium = Font.custom("SFProDisplay-Medium", size: 12)
        static let smallRegular = Font.custom("SFProDisplay-Regular", size: 12)

        static let xSmallBold = Font.custom("SFProDisplay-Bold", size: 10)
        static let xSmallSemibold = Font.custom("SFProDisplay-SemiboldItalic", size: 10)
        static let xSmallMedium = Font.custom("SFProDisplay-Medium", size: 10)
        static let xSmallRegular = Font.custom("SFProDisplay-Regular", size: 10)
    }
}
