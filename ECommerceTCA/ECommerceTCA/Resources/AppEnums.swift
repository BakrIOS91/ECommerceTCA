//
//  AppEnums.swift
//  ECommerceTCA
//
//  Created by Bakr mohamed on 05/03/2024.
//

import Foundation
import BMSwiftUI
import SwiftUI

enum AppRootView: String {
    case language
    case login
    case root
}

enum SupportedLanguage: String, CaseIterable {
    case en
    case ar
    
    var title: LocalizedStringResource {
        switch self {
            case .en:
                    .localizable.language_English
            case .ar:
                    .localizable.language_Arabic
        }
    }
    
    var image: Image {
        switch self {
            case .en:
                Image(.english)
            case .ar:
                Image(.arabic)
        }
    }
    
    var locale: Locale {
        switch self {
            case .en:
                Locale.SupportedLocale.en.locale
            case .ar:
                Locale.SupportedLocale.ar.locale
        }
    }
    
}
