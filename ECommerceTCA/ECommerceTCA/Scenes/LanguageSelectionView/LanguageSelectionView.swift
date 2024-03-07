//
//  LanguageSelectionView.swift
//  ECommerceTCA
//
//  Created by Bakr mohamed on 05/03/2024.
//

import SwiftUI
import BMSwiftUI
import ComposableArchitecture

@Reducer
struct LanguageSelectionFeature {
    @ObservableState
    struct State {
        @Shared(.fileStorage(URL.documentsDirectory.appending(path: AppConstants.PreferencesKeys.appLanguage)))
        var appLocale: Locale = .bestMatching

    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case setLanguage(Locale)
    }
    
    var body: some ReducerOf<Self> {
        
        Reduce { state, action in
            switch action {
                case .binding:
                    return .none
                case let .setLanguage(locale):
                    state.appLocale = locale
                    return .none
            }
        }
    }
    
    
    
}

struct LanguageShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let offset = rect.height * 0.2
            path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY - offset))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        }
    }
    
    
}

struct LanguageSelectionView: View {
    @Perception.Bindable var store: StoreOf<LanguageSelectionFeature>

    
    var body: some View {
        WithPerceptionTracking {
            ZStack {
                Color.appMain
                    .ignoresSafeArea(.all)
                
                LanguageShape()
                    .ignoresSafeArea(edges: .bottom)
                    .foregroundStyle(Color.white)
                
                VStack {
                    Text(.localizable.language_Title)
                        .font(.title)
                        .fontWeight(.medium)
                    
                    
                    ForEach(SupportedLanguage.allCases, id: \.self) { lang in
                        
                        Button {
                            store.send(.setLanguage(lang.locale))
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundStyle(Color.white)
                                    .frame(width: 250,height: 60)
                                    .shadow(color: .appMain, radius: 2)
                                
                                HStack(spacing: 20) {
                                    lang.image
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                        .shadow(color: .appMain, radius: 2)
                                    
                                    Text(lang.title)
                                        .font(.title2)
                                }
                            }
                            .padding(.vertical, 10)
                        }
                    }
                    .buttonStyle(.plain)
                    
                }
                .multilineTextAlignment(.center)
                .padding()
            }
        }
    }
    
    
    
}

struct LanguageSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageSelectionView(
            store:
                    .init(
                        initialState: LanguageSelectionFeature.State()) {
                            LanguageSelectionFeature()
                                ._printChanges()
                        }
        )
    }
}
