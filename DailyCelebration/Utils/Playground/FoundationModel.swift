//
//  Prompting.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 19/02/26.
//


import FoundationModels
import Playgrounds

#Playground {
    let session = LanguageModelSession()

    let response = try await session.respond(to: "Write an paragraph about what is celebrated on February 1st")

}
