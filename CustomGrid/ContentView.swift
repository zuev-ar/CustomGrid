//
//  ContentView.swift
//  CustomGrid
//
//  Created by Arkasha Zuev on 21.11.2021.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let title: String
    let image: String
    let imgColor: Color
}

struct ContentView: View {
    
    let items = [
        Item(title: "Home", image: "house", imgColor: .orange),
        Item(title: "Car", image: "car", imgColor: .black.opacity(0.5)),
        Item(title: "Bank", image: "banknote", imgColor: .black.opacity(0.8)),
        Item(title: "Vacation", image: "sun.max", imgColor: .yellow),
        Item(title: "User", image: "person", imgColor: .blue),
        Item(title: "Charts", image: "chart.bar", imgColor: .orange),
        Item(title: "Support", image: "phone.circle", imgColor: .purple)
    ]
    
    let spacing: CGFloat = 10
    @State private var numberOfColumns = 3
    
    var body: some View {
        
        let columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: numberOfColumns)
        
        ScrollView {
            
            headerView
            
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(items) { item in
                    Button(action: {}) {
                        ItemVew(item: item)
                    }
                    .buttonStyle(ItemButtonStyle(cornerRadious: 20))
                }
            }
            .padding(.horizontal)
            .offset(y: -50)
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
    
    var headerView: some View {
        VStack {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 110, height: 110)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .onTapGesture {
                    numberOfColumns = numberOfColumns % 3 + 1
                }
            
            Text("Your name")
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .medium, design: .rounded))
            
            Text("Change the world by being yourself")
                .foregroundColor(Color.white.opacity(0.7))
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .multilineTextAlignment(.center)
        }
        .frame(height: 350)
        .frame(maxWidth: .infinity)
        .background(Color.purple)
    }
}

struct ItemButtonStyle: ButtonStyle {
    let cornerRadious: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
            
            if configuration.isPressed {
                Color.black.opacity(0.2)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
    }
}

struct ItemVew: View {
    let item: Item
    
    var body: some View {
        GeometryReader { reader in
            let fontSize = min(reader.size.width * 0.2, 28)
            let imageWidth: CGFloat = min(50, reader.size.width * 0.6)
            
            VStack(spacing: 5) {
                Image(systemName: item.image)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(item.imgColor)
                    .frame(width: imageWidth)
                
                Text(item.title)
                    .font(.system(size: fontSize, weight: .bold, design: .rounded))
                    .foregroundColor(Color.black.opacity(0.9))
            }
            .frame(width: reader.size.width, height: reader.size.height, alignment: .center)
            .background(Color.white)
        }
        .frame(height: 150)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
