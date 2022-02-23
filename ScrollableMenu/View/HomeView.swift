//
//  HomeView.swift
//  ScrollableMenu
//
//  Created by nakamura motoki on 2022/02/23.
//

import SwiftUI

struct HomeView: View {
    // Current Tab...
    @State var currentTab = ""
    
    @Namespace var animation
    
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        VStack(spacing: 0){
            VStack{
                HStack(spacing: 15){
                    Button{
                        
                    }label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                    }// Button
                    
                    Text("McDonalds's - Chinatown")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button{
                        
                    }label: {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                    }// Button
                }// HStack
                .foregroundColor(.primary)
                .padding(.horizontal)
                
                // Scroll View Reader...
                // to scroll tab automatically when user scrolls.
                ScrollViewReader{ proxy in
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 30){
                            ForEach(tabsItems){ tab in
                                VStack{
                                    Text(tab.tab)
                                        .foregroundColor(currentTab.replacingOccurrences(of: "SCROLL", with: "") == tab.id ? .blue : .gray)
                                    
                                    // For matched geometry effect...
                                    if currentTab.replacingOccurrences(of: "SCROLL", with: "") == tab.id{
                                        Capsule()
                                            .fill(.blue)
                                            .matchedGeometryEffect(id: "TAB", in: animation)
                                            .frame(height: 3)
                                            .padding(.horizontal, -10)
                                    }else{
                                        Capsule()
                                            .fill(.clear)
                                            .frame(height: 3)
                                            .padding(.horizontal, -10)
                                    }
                                    
                                }// VStack
                                .onTapGesture {
                                    withAnimation(.easeInOut){
                                        currentTab = "\(tab.id) TAP"
                                        proxy.scrollTo(currentTab.replacingOccurrences(of: " TAP", with: ""), anchor: .topTrailing)
                                    }
                                }
                            }// ForEach
                        }// HStack
                        .padding(.horizontal, 30)
                    }// ScrollView
                    .onChange(of: currentTab){ _ in
                        
                        // Ebabling scrolling...
                        if currentTab.contains(" SCROLL"){
                            withAnimation(.easeInOut){
                                proxy.scrollTo(currentTab.replacingOccurrences(of: " SCROLL", with: ""), anchor: .topTrailing)
                            }
                        }
                    }
                }// ScrollViewReader
                .padding(.top)
            }// VStack
            .padding([.top])
            // Divider...
            .background(scheme == .dark ? Color.black : Color.white)
            .overlay(
                
                Divider()
                    .padding(.horizontal, -15)
                
                ,alignment: .bottom
            )//  .overlay
            ScrollView(.vertical, showsIndicators: false){
                
                // Scroll view reader to scroll the content...
                ScrollViewReader{proxy in
                    VStack(spacing: 15){
                        ForEach(tabsItems){ tab in
                            // Menu Card View...
                            MenuCardView(tab: tab, currentTab: $currentTab)
                                .padding(.top)
                        }// ForEach
                    }// VStack
                    .padding([.horizontal, .bottom])
                    .onChange(of: currentTab){ newValue in
                        
                        // avoiding scroll if its tap...
                        if currentTab.contains(" TAP"){
                            // Scrolling to content...
                            withAnimation(.easeInOut){
                                proxy.scrollTo(currentTab.replacingOccurrences(of: " TAP", with: ""), anchor: .topTrailing)
                            }
                        }
                    }
                }// ScrollViewRader
            }// ScrollView
            // Setting Coordinate Space name for offset...
            .coordinateSpace(name: "SCROLL")
        }// VStack(spacing: 0)
        // Setting first tab...
        .onAppear{
            currentTab = tabsItems.first?.id ?? ""
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct MenuCardView: View{
    
    var tab: Tab
    
    @Binding var currentTab: String
    
    var body: some View{
        VStack(alignment: .leading, spacing: 20){
            Text(tab.tab)
                .font(.title.bold())
                .padding(.vertical)
            
            ForEach(tab.foods){ food in
                // Food View
                HStack(spacing: 15){
                    VStack(alignment: .leading, spacing: 10){
                        Text(food.title)
                            .font(.title3.bold())
                        
                        Text(food.description)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Text("Price: \(food.price)")
                            .fontWeight(.bold)
                    }// VStack
                    .frame(maxWidth: .infinity,alignment: .leading)
                    
                    Image(food.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 75, height: 75)
                        .cornerRadius(10)
                }// HStack
                
                Divider()
            }// ForEach
        }// VStack
        .modifier(OffsetModifier(tab: tab, currentTab: $currentTab))
        // ScrollViewReaderのIDを設定する...
        .id(tab.id)
    }
}
