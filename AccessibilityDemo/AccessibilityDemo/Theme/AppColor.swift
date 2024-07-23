//
//  AppColor.swift
//  AccessibilityDemo
//

import SwiftUI

struct AppColor {
    static let primary = Color("MainColor")
    static let onPrimary = Color("OnMainColor")
    static let secondary = Color("SupplementaryColor")
    static let onSecondary = Color("OnSupplementaryColor")
    static let background = Color("BackgroundColor")
    static let onBackground = Color("OnBackgroundColor")
    static let surface = Color("SurfaceColor")
    static let onSurface = Color("OnSurfaceColor")
    static let accent = Color("AccentColor")
    
    static var happy: Color {
        switch Locale.current.region?.identifier {
        case "CN", "IN", "KR", "VN", "NG":
            Color(UIColor.systemRed)
        default:
            Color(UIColor.systemGreen)
        }
    }
    
    static let neutral = Color(UIColor.systemTeal)
    static let concerned = Color(UIColor.systemOrange)
    
    static var sad: Color {
        switch Locale.current.region?.identifier {
        case "CN", "IN", "KR", "VN", "NG":
            Color(UIColor.systemGreen)
        default:
            Color(UIColor.systemRed)
        }
    }
}

#Preview {
    NavigationStack {
        ZStack {
            AppColor.background.ignoresSafeArea()
            
            VStack {
                Text(verbatim: "Background")
                    .foregroundStyle(AppColor.onBackground)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading) {
                    Text(verbatim: "Surface")
                        .foregroundStyle(AppColor.onSurface)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 10)
                    
                    Text(verbatim: "PRIMARY")
                        .foregroundStyle(AppColor.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(verbatim: "SECONDARY")
                        .foregroundStyle(AppColor.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(verbatim: "ACCENT")
                        .foregroundStyle(AppColor.accent)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(verbatim: "HAPPY")
                        .foregroundStyle(AppColor.happy)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(verbatim: "NEUTRAL")
                        .foregroundStyle(AppColor.neutral)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(verbatim: "CONCERNED")
                        .foregroundStyle(AppColor.concerned)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(verbatim: "SAD")
                        .foregroundStyle(AppColor.sad)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(AppColor.surface)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text(verbatim: "PRIMARY")
                    .foregroundStyle(AppColor.primary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Text(verbatim: "SECONDARY")
                    .foregroundStyle(AppColor.secondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Text(verbatim: "ACCENT")
                    .foregroundStyle(AppColor.accent)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Text(verbatim: "HAPPY")
                    .foregroundStyle(AppColor.happy)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Text(verbatim: "NEUTRAL")
                    .foregroundStyle(AppColor.neutral)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Text(verbatim: "CONCERNED")
                    .foregroundStyle(AppColor.concerned)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Text(verbatim: "SAD")
                    .foregroundStyle(AppColor.sad)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Spacer()
            }
            .padding()
        }
        .toolbarBackground(AppColor.surface, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            Text(verbatim: "ACCENT")
                .foregroundStyle(AppColor.accent)
        }
    }
}
