//
//  UIImageExtension.swift
//  SwiftRxGiphy
//
//  Created by Kazakevich, Vitaly on 4/25/18.
//  Copyright © 2018 Vitali Kazakevich. All rights reserved.
//

import UIKit

extension UIImageView {

    func showAnimatedImage(_ animatedImage: AnimatedImage) {
        guard animatedImage.frameCount > 0 else {
            return
        }

        var frames = [CGImage]()
        for frameIndex in 0..<animatedImage.frameCount {
            guard let frame = animatedImage.imageAtIndex(index: frameIndex) else {
                continue
            }
            frames.append(frame)
        }

        let imageFrames = frames.map {UIImage(cgImage:$0)}
        self.animationImages = imageFrames
        self.animationDuration = animatedImage.duration
    }

}
