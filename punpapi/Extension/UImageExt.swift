

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImageKF(_ url: URL) {
        self.kf.setImage(
            with: url,
            placeholder: R.image.stripes(),
            options: [
                //.processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                break
                // print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
    func setImageKF(_ urls: String?) {
        if let urls = urls, let url = URL(string: urls) {
            setImageKF(url)
        }
    }
}

