//
//  File.swift
//  JobSearch
//
//  Created by Nickolay Vasilchenko on 12.11.2023.
//

import UIKit
import Combine

extension UIImageView {
    func loadFromURL(url: String?, placeholder: String) {
        guard let url = url else {
            self.image = UIImage(named: placeholder)
            return
        }
        self.image = nil
        let imageURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        if let url = URL(string: imageURL) {
            URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            self.image = downloadedImage
                        }
                    }
                }
            }.resume()
        }
    }
}
