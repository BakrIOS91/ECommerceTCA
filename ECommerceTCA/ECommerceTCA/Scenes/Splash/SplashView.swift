//
//  SplashView.swift
//  ECommerceTCA
//
//  Created by Bakr mohamed on 04/03/2024.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct SplashFeature {
    
    @ObservableState
    struct State {
        
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
    }
    
}

struct SplashView: View {
    @Perception.Bindable var store: StoreOf<SplashFeature>
    
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
    SplashView(
        store: .init(
            initialState: SplashFeature.State()
        ){
            SplashFeature()
        }
    )
}
