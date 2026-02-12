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

    let daysMock: [Day] = [
        Day(date: Date.now, events: ["Dia tal", "Dia tal"]),
        Day(
            date: Date.now.advanced(by: 1),
            events: ["Dia tal", "Dia tal"]
        ),
        Day(date: Date.now.advanced(by: 2), events: ["Dia tal", "Dia tal"]),
    ]

    var body: some View {
        NavigationStack(path: $stackPath) {
            List {
                
                Section {
                    ForEach(daysMock, id: \.self.date) { day in
                        DayListTile(day: day).onTapGesture {
                            stackPath.append(day)
                        }
                    }
                } header : {
                    Text("Test")
                }
                
                ForEach(vm.years, id: \.year) { year in
                    Section {
                        // Compute months and names with explicit types to help type-checker
                        let months: [String: [Day]] = year.getMonths()
                        let monthNames: [String] = months.keys.sorted()

                        ForEach(monthNames, id: \.self) { monthName in
                            Section {
                                // Safely unwrap days for this month and iterate with a stable id
                                if let days = months[monthName] {
                                    ForEach(days, id: \.self) { day in
                                        DayListTile(day: day)
                                            .onTapGesture {
                                                stackPath.append(day)
                                            }
                                    }
                                }
                            } header: {
                                Text(monthName)
                            }
                        }
                    } header: {
                        Text(verbatim: String(describing: year))
                    }
                }
            }
            .navigationDestination(for: Day.self) { day in
                DayDetailsView(day: day)
            }
        }
        .navigationBarTitle(Text("Calendar"))
    }
}

#Preview {
    HomeView()
}
