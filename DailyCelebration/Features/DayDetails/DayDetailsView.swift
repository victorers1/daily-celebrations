//
//  DayDetailsView.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 11/02/26.
//

import SwiftUI

struct DayDetailsView: View {
    @StateObject private var vm: DayDetailsViewModel
    private var appState: DailyCelebrationAppViewModel

    init(appState: DailyCelebrationAppViewModel, initialDayIndex: Int) {
        self.appState = appState
        let ddvm = DayDetailsViewModel(
            allDays: appState.allDays,
            initialDayIndex: initialDayIndex
        )
        _vm = StateObject(wrappedValue: ddvm)
    }

    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    Text("IA Generated Image")
                        .frame(maxWidth: .infinity, minHeight: 200, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .glassEffect(
                            .regular.tint(.blue).interactive(),
                            in: .rect(cornerRadius: 20)
                        )
                        .padding(.bottom, 36)
                }

                if vm.planner.isPlanning {
                    HStack {
                        Image(systemName: "sparkles")
                            .pulseOpacityEffect()
                            .font(.largeTitle)

                        Text("Gerando descrição...")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }.transition(.opacity)
                }

                if let dayActivities = vm.planner.currentDayActivities {
                    getDayActivitiesView(dayActivities: dayActivities)
                }
            }
            .animation(.easeInOut(duration: 0.5), value: vm.planner.isPlanning)
            .navigationTitle(vm.day.date.ddMMMyyyy)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    ToolbarButton(systemName: "chevron.left") {
                        print("chevron.left pressed")
                    }

                    ToolbarButton(systemName: "arrow.clockwise") {
                        Task {
                            do {
                                print("arrow.clockwise pressed")
                                try await vm.suggestItinerary()
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

        }.task {
            do {
                try await vm.suggestItinerary()
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
    let ddvm = DailyCelebrationAppViewModel()
    DayDetailsView(
        appState: ddvm, initialDayIndex: 0
    )
}
