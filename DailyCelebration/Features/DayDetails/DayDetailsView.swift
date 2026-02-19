//
//  DayDetailsView.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 11/02/26.
//

import SwiftUI

struct DayDetailsView: View {
    @State private var day: Day
    @State private var planner: CelebrationPlanner?

    init(day: Day) {
        self.day = day
    }

    var body: some View {
        VStack {
            Text(
                "IA Generated text IA Generated text IA Generated text IA Generated text IA Generated text IA Generated text IA Generated text IA Generated text IA Generated text IA Generated text "
            )
            
            if let today = planner?.dayActivities {
                Text(today.description
                ).padding(.bottom, 32)
            } else {
                Text("Loading itinerary")
            }
            
        }.navigationTitle(day.date.ddMMMyyyy)
            .navigationSubtitle("Details")
            .toolbar(id: "MOVETODAY") {
                ToolbarItem(id: "MOVE", placement: .bottomBar) {
                    Button {
                    } label: {
                        Image(systemName: "square.and.arrow.down.badge.clock")
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    ToolbarButton(systemName: "chevron.left") {
                    }

                    ToolbarButton(systemName: "arrow.clockwise") {
                    }

                    ToolbarButton(systemName: "square.and.arrow.up") {
                    }

                    ToolbarButton(systemName: "chevron.right") {
                    }
                }

                ToolbarSpacer(.fixed, placement: .bottomBar)
            }
            .padding(16)
            .task {
                planner = CelebrationPlanner(day: day)
                print("Created planner on day \(day)")
                
                do {
                    try await planner?.suggestItinerary()
                } catch {
                    // TODO: Surface error to the UI
                    print("Failed to suggest itinerary: \(error)")
                }
            }
    }
}

struct ToolbarButton: View {
    let systemName: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName).padding(10)
        }
    }
}

#Preview {
    DayDetailsView(
        day: Day(date: Date.now, events: ["Event 1", "Event 2"])
    )
}
