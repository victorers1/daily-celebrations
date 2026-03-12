//
//  DayDetailsView.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 11/02/26.
//

import SwiftUI

struct DayDetailsView: View {
    @State private var day: Day
    @State private var celebrationPlanner: CelebrationPlanner?

    init(day: Day) {
        self.day = day
    }

    var body: some View {
        ScrollView {
            if let planner = self.celebrationPlanner {
                VStack {
                    Text("IA Generated Image")
                        .frame(maxWidth: .infinity, minHeight: 200, alignment: .center)
                        .background(Color(.blue))
                        .padding(.bottom, 36)

                    if planner.isPlanning {
                        HStack() {
                            Image(systemName: "sparkles")
                                .pulseOpacityEffect()
                                .font(.largeTitle)
                                
                            Text("Generating description...")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }.transition(.opacity)
                    }

                    if let dayActivities = planner.currentDayActivities {
                        getDayActivitiesView(dayActivities: dayActivities)
                    }

                }
                .animation(.easeInOut(duration: 0.5), value: planner.isPlanning)
                .navigationTitle(day.date.ddMMMyyyy)
                    .navigationSubtitle("Details")
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            ToolbarButton(systemName: "chevron.left") {
                                print("chevron.left pressed")
                            }

                            ToolbarButton(systemName: "arrow.clockwise") {
                                Task {
                                    do {
                                        print("arrow.clockwise pressed")
                                        try await planner.suggestItinerary()
                                    } catch {
                                        // TODO: Surface error to the UI
                                        print("Failed to suggest itinerary: \(error)")
                                    }
                                }
                            }

                            ToolbarButton(systemName: "square.and.arrow.up") {
                                print("square.and.arrow.up pressed")
                            }

                            ToolbarButton(systemName: "chevron.right") {
                                print("chevron.right pressed")
                            }
                        }

                        ToolbarSpacer(.fixed, placement: .bottomBar)
                        
                        ToolbarItem(placement: .bottomBar) {
                            Button {
                                print("square.and.arrow.down.badge.clock pressed")
                            } label: {
                                Image(systemName: "square.and.arrow.down.badge.clock")
                            }
                        }
                    }
                    .padding(16)
            }

        }.task {
            guard celebrationPlanner == nil else { return }

            celebrationPlanner = CelebrationPlanner(day: day)
            print("Created planner on day \(day)")

            do {
                try await celebrationPlanner?.suggestItinerary()
            } catch {
                // TODO: Surface error to the UI
                print("Failed to suggest itinerary: \(error)")
            }
        }
    }

    func getDayActivitiesView(dayActivities: DayActivities.PartiallyGenerated) -> some View {
        VStack {
            Text(dayActivities.description ?? "")
                .padding(.bottom, 32)
                .frame(maxWidth: .infinity, alignment: .leading)

            if let activities = dayActivities.activities {
                ForEach(activities) { activity in
                    DayActivityListTile(
                        iconName: activity.type?.description, title: activity.title, description: activity.description
                    ).padding(.bottom, 16)
                }
            }
        }.transition(.blurReplace)
            .animation(.easeInOut, value: dayActivities)
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
        day: Day(date: Date.now, events: ["Dia do sanitarista", "Dia mundial do introvertido"]),
    )
}
