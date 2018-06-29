//
//  Extensions.swift
//  Movister
//
//  Created by Admin on 6/28/18.
//  Copyright © 2018 ahmednader. All rights reserved.
//

import UIKit

class CircleImage: UIImageView {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        // Makes it a circle if it has equal width and height
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
    }
}

class RoundedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 15
    }
}

extension UIImageView {
    
    // Load and image from a given url if the imagView still exists
    func loadImage(url:URL) -> URLSessionDownloadTask{
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url){
            [weak self] url,response,error in
            
            // Check for errors and try to get the image from the data.
            if error == nil,let url = url, let data = try? Data(contentsOf: url),let image = UIImage(data: data){
                DispatchQueue.main.async {
                    if let strongSelf = self {
                        // Set the image if self isn't dismissed
                        strongSelf.image = image
                    }
                }
            }
        }
        downloadTask.resume()
        return downloadTask
    }
}

class CircleLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Makes it a circle if it has equal width and height
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
    }
}
