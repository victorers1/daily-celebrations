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
        HStack {
            VStack(alignment: .leading) {
                Text(
                    day.date
                        .formatted(
                            Date
                                .FormatStyle()
                                .year()
                                .month()
                                .day(.twoDigits)
                        )
                ).font(Font.title3.bold())

                ForEach(day.events, id: \.self) { event in
                    Text("- \(event)")
                }
            }
        }.padding(16)
    }
}

#Preview {
    DayListTile(
        day: Day(date: Date(), events: ["Dia da paz universal"])
    )
}
