//
//  HomeView.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 10/02/26.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()

    @State private var stackPath: [Day] = []
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack(path: $stackPath) {
            if vm.isLoading {
                ProgressView()
            } else {
                List {
                    Section {
                        // Compute months and names with explicit types to help type-checker
                        let months: [[String: [Day]]] = vm.year.getMonths()

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
                .navigationDestination(for: Day.self) { day in
                    DayDetailsView(day: day)
                }.navigationBarTitle(Text(verbatim: String(describing: vm.year)))
                .searchable(text: $searchText)
                .toolbar {
                    DefaultToolbarItem(kind: .search, placement: .bottomBar)

                    ToolbarSpacer(.fixed, placement: .bottomBar)

                    ToolbarItem(placement: .bottomBar) {
                        Button {
                        } label: {
                            Image(systemName: "square.and.arrow.down.badge.clock")
                        }
                    }
                }
                .tabBarMinimizeBehavior(.onScrollDown)
            }

        }.task {
            vm.decodeYear()
        }
    }
}

#Preview {
    HomeView()
}
