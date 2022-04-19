//
//  AsyncImageView.swift
//  TheMovieDB
//
//  Created by Jake Haslam on 4/19/22.
//

import UIKit

class AsyncImageView: UIImageView, APIDataProvidable {

    func setImage(using urlRequest: URLRequest) {
        perform(urlRequest) { [weak self] result in
            DispatchQueue.main.async {
                guard let imageData = try? result.get() else { return }
                self?.image = UIImage(data: imageData)
            }
        }
    }
}
