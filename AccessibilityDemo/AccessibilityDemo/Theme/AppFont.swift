//
//  AppFont.swift
//  AccessibilityDemo
//

import SwiftUI

struct AppFont {
    static var largeTitle: Font {
        UIAccessibility.isBoldTextEnabled ? Font.custom("HelveticaNeue-Bold", size: 34) : Font.custom("HelveticaNeue-Medium", size: 34)
    }
    
    static var title1: Font {
        UIAccessibility.isBoldTextEnabled ? Font.custom("HelveticaNeue-Medium", size: 28) : Font.custom("HelveticaNeue", size: 28)
    }
    
    static var title2: Font {
        UIAccessibility.isBoldTextEnabled ? Font.custom("HelveticaNeue-Medium", size: 22) : Font.custom("HelveticaNeue", size: 22)
    }
    
    static var title3: Font {
        UIAccessibility.isBoldTextEnabled ? Font.custom("HelveticaNeue-Medium", size: 20) : Font.custom("HelveticaNeue", size: 20)
    }
    
    static var headline: Font {
        UIAccessibility.isBoldTextEnabled ? Font.custom("AvenirNext-Heavy", size: 17) : Font.custom("AvenirNext-Bold", size: 17)
    }
    
    static var body1: Font {
        UIAccessibility.isBoldTextEnabled ? Font.custom("AvenirNext-Bold", size: 17) : Font.custom("AvenirNext-Regular", size: 17)
    }
    
    static var body2: Font {
        UIAccessibility.isBoldTextEnabled ? Font.custom("AvenirNext-Bold", size: 15) : Font.custom("AvenirNext-Regular", size: 15)
    }
    
    static var button: Font {
        UIAccessibility.isBoldTextEnabled ? Font.custom("AvenirNext-Bold", size: 17) : Font.custom("AvenirNext-Regular", size: 17)
    }
    
    static var caption: Font {
        UIAccessibility.isBoldTextEnabled ? Font.custom("AvenirNext-Bold", size: 13) : Font.custom("AvenirNext-Regular", size: 13)
    }
    
}

#Preview {
    List {
        Text(verbatim: "largeTitle").font(AppFont.largeTitle)
        Text(verbatim: "title1").font(AppFont.title1)
        Text(verbatim: "title2").font(AppFont.title2)
        Text(verbatim: "title3").font(AppFont.title3)
        Text(verbatim: "headline").font(AppFont.headline)
        Text(verbatim: "body").font(AppFont.body1)
        Text(verbatim: "bodySmall").font(AppFont.body2)
        Text(verbatim: "button").font(AppFont.button)
        Text(verbatim: "caption").font(AppFont.caption)
    }
}
