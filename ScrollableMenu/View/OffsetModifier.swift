//
//  OffsetModifier.swift
//  ScrollableMenu
//
//  Created by nakamura motoki on 2022/02/23.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    
    var tab: Tab
    @Binding var currentTab: String
    func body(content: Content) -> some View {
        content
            .overlay(
                
                // Getting Scroll Offset using GeometryReader..
                // proxy = 代理、代理人
                GeometryReader{ proxy in
                    Color.clear
                        .preference(key: OffsetKey.self, value: proxy.frame(in: .named("SCROLL")))
                }// GeometryReader
            )//  .overlay
            .onPreferenceChange(OffsetKey.self){ proxy in
                
                // if minY is between 20 to -half of the midX
                // then updating current tab...
                let offset = proxy.minY
                
                // Since on change on Home is Updating Scroll...
                // to avoid that...
                
                // ADDING SCROLL TO LAST OF ID...
                // TO IDENTIFY EASILY
                withAnimation(.easeInOut){
                    currentTab = (offset < 20 && -offset < (proxy.minX / 2) && currentTab != "\(tab.id) SCROLL") ? tab.id : currentTab
                }
            }
    }
}

struct OffsetModifier_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Prefrence Key...
struct OffsetKey: PreferenceKey{
    
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
