//
//  GifTableViewCell.swift
//  SwiftRxGiphy
//
//  Created by Kazakevich, Vitaly on 3/28/18.
//  Copyright © 2018 Vitali Kazakevich. All rights reserved.
//

import Foundation
import UIKit

class GifTableViewCell: UITableViewCell {
    static let identifier = "GifTableViewCell"
    
    private var isTrended = false
    private let viewInsets: CGFloat = 5.0
    private var gifImageViewHeight: NSLayoutConstraint?

    private lazy var gifImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(gifImageView)
        configureConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        isTrended = false
        gifImageViewHeight?.constant = 0.0
    }

    public func configure(with giphy: GIPHYData) {
        let url = giphy.image.gifUrl

    }

    private func loadAnimatedImage(fromUrl url: URL) {

    }

    private func configureConstraints() {
        let gifImageViewHeight = gifImageView.heightAnchor.constraint(equalToConstant: 0.0)
        NSLayoutConstraint.activate([gifImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: viewInsets),
                                     gifImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: viewInsets),
                                     gifImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -viewInsets),
                                     gifImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -viewInsets),
                                     gifImageViewHeight,
                                     ])

        self.gifImageViewHeight = gifImageViewHeight
    }
}
