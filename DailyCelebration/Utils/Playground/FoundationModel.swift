//
//  Prompting.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 19/02/26.
//

import FoundationModels
import Playgrounds

#Playground {
    let seconds: Range<Int> = 0 ..< 60
    let secs: ClosedRange<Int> = 0 ... 59
    for num in secs {
        print(num)
    }

    let natoAlphabet = ["Alpha", "Bravo", "Delta", "Echo", "Foxtrot"]
    for letter in natoAlphabet {
        print(letter)
    }

    for (index, second) in seconds.enumerated() {
        if index % 2 == 0 { continue }
        if second > 30 { break }
        print("second \(index) == \(second)")
    }
}
