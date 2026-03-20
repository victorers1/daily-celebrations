//
//  HomeView.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 10/02/26.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @StateObject private var vm: HomeViewModel
    private var appState: DailyCelebrationAppViewModel

    @State private var stackPath: [Day] = []
    @State private var searchText: String = ""

    init(appState: DailyCelebrationAppViewModel) {
        self.appState = appState
        _vm = StateObject(wrappedValue: HomeViewModel(appState: appState))
    }

    var body: some View {
        NavigationStack(path: $stackPath) {
            if vm.isLoading {
                ProgressView()
            } else {
                List {
                    Section {
                        // Compute months and names with explicit types to help type-checker
                        let months: [[String: [Day]]] = appState.year.getMonths()

                        ForEach(months, id: \.self.keys.first) { month in
                            let monthName = month.keys.first

                            Section {
                                // Safely unwrap days for this month and iterate with a stable id
                                if let days = month.values.first {
                                    ForEach(days, id: \.self) { day in
                                        DayListTile(day: day)
                                            .onTapGesture {
                                                stackPath.append(day)
                                            }
                                    }
                                }
                            } header: {
                                Text(monthName ?? "")
                            }
                        }
                    }
                }
                .navigationBarTitle(Text(verbatim: String(describing: appState.year)))
                .searchable(text: $searchText)
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button {
                        } label: {
                            Image(systemName: "square.and.arrow.down.badge.clock")
                        }
                    }
                }
                .navigationDestination(for: Day.self) { day in
                    let initialDayIndex: Int = self.appState.allDays.firstIndex { d in
                        d.date == day.date
                    } ?? 0
                    DayDetailsView(appState: self.appState, initialDayIndex: initialDayIndex)
                }
            }
        }
        .task {
            await vm.getYear(of: "\(Date().year)")
        }
    }
}

#Preview {
    let appState = DailyCelebrationAppViewModel()
    HomeView(appState: appState)
}
