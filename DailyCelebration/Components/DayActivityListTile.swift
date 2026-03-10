//
//  DayActivityListTile.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 20/02/26.
//

import SwiftUI
import FoundationModels

struct DayActivityListTile: View {
    let iconName: String?
    let title: String?
    let description: String?
    
    @State private var isExpanded: Bool = false

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            if let iconName = iconName {
                Image(systemName: iconName)
                    .font(Font.largeTitle)
            }

            VStack(alignment: .leading, spacing: 8) {
                if let title = title {
                    Text(title)
                        .font(.headline)
                        .lineLimit(isExpanded ? nil : 2)
                }

                if let description = description {
                    Text(description)
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .lineLimit(isExpanded ? nil : 4)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onTapGesture {
            withAnimation {
                isExpanded = !isExpanded
                print("isExpanded: \(isExpanded)")
            }
        }
    }
}

#Preview {
    
    DayActivityListTile(
        iconName: "checkmark", title: Constants.loremIpsum, description: Constants.loremIpsum
    ).padding(16)
}
