//
//  ECommerceTCAApp.swift
//  ECommerceTCA
//
//  Created by Bakr mohamed on 04/03/2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct ECommerceTCAApp: App {
    var body: some Scene {
        WindowGroup {
            AppMasterView(
                store: .init(
                    initialState: AppMasterFeature.State()
                ){
                    AppMasterFeature()
                        ._printChanges()
                }
            )
        }
    }
}
