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
        var appRootView: AppRootView? = nil
        
        @Shared(.fileStorage(URL.documentsDirectory.appending(path: AppConstants.PreferencesKeys.appLanguage)))
        var appLocale: Locale = .bestMatching

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
                            state.appRootView = .language
                        default:
                            state.languageState = .init()
                            state.appRootView = .language
                    }
                    return .none
                case .languageAction:
                    return .none
            }
        }
        .ifLet(\.languageState, action: \.languageAction) {
            LanguageSelectionFeature()
        }
    }
    
}

struct AppMasterView: View {
    @Perception.Bindable var store: StoreOf<AppMasterFeature>
    
    var body: some View {
        WithPerceptionTracking {
            ZStack {
                if let contentView = store.appRootView {
                    switch contentView {
                        case .language:
                            if let langStore = store.scope(
                                state: \.languageState,
                                action: \.languageAction
                            ) {
                                LanguageSelectionView(store: langStore)
                            }
                        default:
                            EmptyView()
                    }
                } else {
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
            .locale(store.appLocale)
            .onAppear {
                store.send(.updateView)
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
