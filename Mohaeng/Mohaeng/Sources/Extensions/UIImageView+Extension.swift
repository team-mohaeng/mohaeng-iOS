//
//  UIImageView+Extension.swift
//  Mohaeng
//
//  Created by 김윤서 on 2021/10/09.
//

import UIKit
import Kingfisher

extension UIImageView {
    @discardableResult
    func updateServerImage(_ imagePath: String) -> Bool {
        guard let url = URL(string: imagePath) else {
            return false
        }
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0)),
                .cacheOriginalImage
            ]) { result in
            switch result {
            case .success:
                return
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        return true
    }
}
