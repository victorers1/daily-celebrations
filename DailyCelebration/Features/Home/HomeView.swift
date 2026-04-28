//
//  HomeView.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 10/02/26.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @Environment(\.appState) private var appState
    @StateObject private var vm: HomeViewModel

    @State private var stackPath: [Day] = []
    @State private var searchText: String = ""
    
    init() {
        _vm = StateObject(wrappedValue: HomeViewModel(appState: DailyCelebrationAppViewModel()))
    }

    var body: some View {
        NavigationStack(path: $stackPath) {
            ScrollViewReader { proxy in
                if vm.isLoading {
                    ProgressView()
                } else {
                    listView(proxy: proxy)
                }
            }
            .task {
                appState.db = RemoteDatabase()
                await vm.getYear(of: "\(Date().year)")
            }
        }
    }

    func listView(proxy: ScrollViewProxy) -> some View {
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
                                    .id(day.id)
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
                    withAnimation {
                        proxy.scrollTo(appState.todayIndex, anchor: .top)
                    }
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
        .onAppear {
            withAnimation {
                proxy.scrollTo(appState.todayIndex, anchor: .top)
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environment(\.appState, DailyCelebrationAppViewModel())
            .environment(\.remoteDatabase, RemoteDatabase())
    }
    
}

