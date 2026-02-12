//
//  DayDetailsView.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 11/02/26.
//

import SwiftUI

struct DayDetailsView: View {
    let day: Day;
    
    init(day: Day) {
        self.day = day
    }
    
    var body: some View {
        Text(day.date.formatted()).frame(alignment: .center)
    }
}

#Preview {
    DayDetailsView(
        day: Day(date: Date.now, events: ["Event 1", "Event 2"])
    )
}
