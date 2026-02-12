//
//  Year.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 10/02/26.
//

import Foundation

struct Year: Decodable, CustomStringConvertible, Identifiable {
    let id: Int
    let jan: [Day]
    let feb: [Day]
    let may: [Day]
    let apr: [Day]
    let mar: [Day]
    let jun: [Day]
    let jul: [Day]
    let aug: [Day]
    let sep: [Day]
    let oct: [Day]
    let nov: [Day]
    let dec: [Day]

       var description: String {
        return "\(id)"
    }

    func getMonths() -> [[String: [Day]]] {
        return [
            ["Janeiro": jan],
            ["Fevereiro": feb],
            ["Maio": may],
            ["Abril": apr],
            ["Março": mar],
            ["Junho": jun],
            ["Julho": jul],
            ["Agosto": aug],
            ["Setembro": sep],
            ["Outubro": oct],
            ["Novembro": nov],
            ["Dezembro": dec],
        ]
    }
}
