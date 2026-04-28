//
//  ImageLoader.swift
//  DailyCelebration
//
//  Created by Victor Emanuel Ribeiro Silva on 15/04/26.
//

import Foundation
import Combine

class ImageLoader: ObservableObject {
    @Published var donwloadedData: Data?

    func donwloadImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

        URLSession.shared.dataTask(with: imageURL) { data, _, error in

            guard let data = data, error == nil else { return }

            DispatchQueue.main.async {
                self.donwloadedData = data
            }

        }.resume()
    }
}
