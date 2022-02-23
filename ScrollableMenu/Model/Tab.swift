//
//  Tab.swift
//  ScrollableMenu
//
//  Created by nakamura motoki on 2022/02/23.
//

import SwiftUI

// Sample Tabs with sample foods...
struct Food: Identifiable{
    var id = UUID().uuidString
    var title: String
    var description: String
    var price: String
    var image: String
}

var foods = [
    
    Food(title: "Choclate Cake", description: "Chocolate cake or chocolate gåteau is a cake flavored with melted chocolate", price: "$19", image: "choclates"),
    Food(title: "Cookies", description: "Chocolate cake or chocolate gåteau is a cake flavored with melted chocolate", price: "$9", image: "cookies"),
    Food(title: "Sandwich", description: "Chocolate cake or chocolate gåteau is a cake flavored with melted chocolate", price: "$9", image: "sandwich"),
    Food(title: "French Fries", description: "Chocolate cake or chocolate gåteau is a cake flavored with melted chocolate", price: "$15", image: "food"),
    Food(title: "Choclate Cake", description: "Chocolate cake or chocolate gåteau is a cake flavored with melted chocolate", price: "$19", image: "choclates"),
    Food(title: "Pizza", description: "Chocolate cake or chocolate gåteau is a cake flavored with melted chocolate", price: "$39", image: "pizza")
]

// Tab Model...
struct Tab: Identifiable{
    
    var id = UUID().uuidString
    var tab: String
    var foods: [Food]
}

// Tab Items...
var tabsItems = [
    
    Tab(tab: "Home Style", foods: foods.shuffled()),
    Tab(tab: "Promotions", foods: foods.shuffled()),
    Tab(tab: "Snacks", foods: foods.shuffled()),
    Tab(tab: "McCafe", foods: foods.shuffled()),
]
