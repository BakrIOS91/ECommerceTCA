//
//  ECommerceTCAApp.swift
//  ECommerceTCA
//
//  Created by Bakr mohamed on 04/03/2024.
//

import SwiftUI

@main
struct ECommerceTCAApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(
                store: .init(
                    initialState: SplashFeature.State()
                ){
                    SplashFeature()
                        ._printChanges()
                }
            )
        }
    }
}
