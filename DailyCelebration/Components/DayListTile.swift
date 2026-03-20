//
//  DateTile.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 10/02/26.
//

import Foundation
import SwiftUI

struct DayListTile: View {
    let day: Day

    var body: some View {
        VStack(alignment: .leading) {
            Text(day.date.ddMMM).font(.title3.bold())

            ForEach(day.events, id: \.self) { event in
                Text("- \(event)")
            }
        }.padding(16)
    }
}

#Preview {
    DayListTile(
        day: Day(
            id: 0,
            date: Calendar.current
                .date(from: DateComponents(year: 2026, month: 1, day: 1))!,
            events: [
                "Dia da paz universal",
                "Dia da paz universal",
                "Dia da paz universal",
            ]
        )
    )
}
