//
//  SplashView.swift
//  ECommerceTCA
//
//  Created by Bakr mohamed on 04/03/2024.
//

import SwiftUI
import BMSwiftUI
import ComposableArchitecture

@Reducer
struct AppMasterFeature {
    
    @ObservableState
    struct State {
        @Shared(.appStorage(AppConstants.PreferencesKeys.appRootView))
        var appRootView: AppRootView = .language
        var contentView: AppRootView?
        var languageState: LanguageSelectionFeature.State?
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case updateView
        case languageAction(LanguageSelectionFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
                case .binding:
                    return .none
                case .updateView:
                    switch state.appRootView {
                        case .language:
                            state.languageState = .init()
                            state.contentView = .language
                        default:
                            break
                    }
                    return .none
                case .languageAction:
                    return .none
            }
        }
    }
    
}

struct AppMasterView: View {
    @Perception.Bindable var store: StoreOf<AppMasterFeature>
    
    var body: some View {
        WithPerceptionTracking {
            Unwrap(store.contentView) { contentView in
                switch contentView {
                    case .language:
                        Unwrap(
                            store.scope(
                                state: \.languageState,
                                action: \.languageAction
                            )
                        ) {
                            LanguageSelectionView(store: $0)
                        }
                    default:
                        EmptyView()
                }
            } fallbackContent: {
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
                .onAppear {
                    store.send(.updateView)
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
