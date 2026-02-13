//
//  DayDetailsView.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 11/02/26.
//

import SwiftUI

struct DayDetailsView: View {
    let day: Day

    init(day: Day) {
        self.day = day
    }

    var body: some View {
        VStack {
            Text("IA Generated img")
            Text("IA Generated text")
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
