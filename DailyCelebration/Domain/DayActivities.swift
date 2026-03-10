//
//  Itinerary.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 19/02/26.
//

import Foundation
import FoundationModels

@Generable
struct DayActivities: Equatable {
    @Guide(description: "An explanation of what is celebrated on this date.")
    let description: String
    
    @Guide(description: "A list of plans for this celebration")
    @Guide(.count(3))
    let activities: [Activity]
}

@Generable
struct Activity : Equatable {

    let type: ActivityKind
    
    @Guide(description: "A fun title for the activity")
    let title: String
    
    @Guide(description: "What the user should do")
    let description: String
}

@Generable
enum ActivityKind {
    case sightseeing
    case foodAndDining
    case shopping
    case hotelAndLodging
}

extension ActivityKind: CustomStringConvertible {
    var description: String {
        switch self {
            case .sightseeing: return "binoculars.circle"
            case .foodAndDining: return "fork.knife.circle"
            case .shopping: return "bag.circle"
            case .hotelAndLodging: return "house.lodge.circle"
        }
    }
}
