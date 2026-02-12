//
//  HomeView.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 10/02/26.
//

import Foundation
import SwiftUI

struct HomeView: View {
    let vm = HomeViewModel()

    @State private var stackPath: [Day] = []
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack(path: $stackPath) {
            List {
                ForEach(vm.years) { year in
                    Section {
                        // Compute months and names with explicit types to help type-checker
                        let months: [[String: [Day]]] = year.getMonths()

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
                    } header: {
                        Text(verbatim: String(describing: year))
                    }
                }
            }
            .navigationDestination(for: Day.self) { day in
                DayDetailsView(day: day)
            }.navigationBarTitle(Text("Calendar"))
            .searchable(text: $searchText)
        }
    }
}

#Preview {
    HomeView()
}
