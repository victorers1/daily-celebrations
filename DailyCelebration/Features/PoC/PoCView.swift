//
//  PoCView.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 10/02/26.
//

import SwiftUI

struct PoCView: View {
    let fruits = ["apple", "orange", "banana"]
    
    @State private var stackPath: [String] = ["Mango"]

    var body: some View {
        NavigationStack(path: $stackPath) {
            ScrollView {
                VStack(spacing: 40) {
                    
                    Button {
                        // Push to multiple screen in the same time
                        stackPath.append(contentsOf: ["Coconut", "Watermelon", "Mango"])
                    } label: {
                        Text("Super segue")
                    }

                    ForEach(fruits, id: \.self) { fruit in
                        NavigationLink(value: fruit) {
                            Text(fruit)
                        }
                    }
                    
                    // This wont work
                    // NavigationStack is waiting for String paths
                    ForEach(0 ..< 10) { x in
                        NavigationLink(value: x) {
                            Text("Click me: \(x)")
                        }
                    }
                }
                .padding(.top, 40)
                .navigationTitle("Nav Stack")
                .navigationDestination(for: Int.self) { value in
                    SecondScreen(value: value)
                }
                .navigationDestination(for: String.self) { value in
                    Text("Another Screen: \(value)")
                }
            }
        }
    }
}


struct SecondScreen: View {
    let value: Int

    init(value: Int) {
        self.value = value
        print("INIT SCREEN: \(value)")
    }

    var body: some View {
        Text("Screen \(value)")
    }
}


#Preview {
    PoCView()
}
