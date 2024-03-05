//
//  SplashView.swift
//  ECommerceTCA
//
//  Created by Bakr mohamed on 04/03/2024.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct AppMasterFeature {
    
    @ObservableState
    struct State {
        @Shared(.appStorage(AppConstants.PreferencesKeys.appRootView))
        var appRootView: AppRootView = .splash
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
                case .binding:
                    return .none
            }
        }
    }
    
}

struct AppMasterView: View {
    @Perception.Bindable var store: StoreOf<AppMasterFeature>
    
    var body: some View {
        WithPerceptionTracking {
            ZStack {
                Color.appMain.ignoresSafeArea(.all)
                
                Image(.appLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 240,
                        height: 128,
                        alignment: .center
                    )
                
                VStack {
                    Spacer()
                    
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                }
            }
        }
    }
}

#Preview {
    AppMasterView(
        store: .init(
            initialState: AppMasterFeature.State()
        ){
            AppMasterFeature()
        }
    )
}
