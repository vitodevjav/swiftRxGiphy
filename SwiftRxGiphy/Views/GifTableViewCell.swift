//
//  GifTableViewCell.swift
//  SwiftRxGiphy
//
//  Created by Kazakevich, Vitaly on 3/28/18.
//  Copyright © 2018 Vitali Kazakevich. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class GifTableViewCell: UITableViewCell {
    static let identifier = "GifTableViewCell"
    
    private var isTrended = false
    private let viewInsets: CGFloat = 5.0
    private var gifImageViewHeightConstraint: NSLayoutConstraint?
    private let trendedIconHeight: CGFloat = 44.0
    private var disposeBag = DisposeBag()

    private lazy var gifImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var trendedIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "trended")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(gifImageView)
        addSubview(trendedIcon)
        configureConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        isTrended = false
        gifImageViewHeightConstraint?.constant = 0.0
        disposeBag = DisposeBag()
    }

    public func configure(with giphy: GIPHYData) {
        guard let url = URL.init(string: giphy.image.gifUrl) else { return }

        gifImageViewHeightConstraint?.constant = CGFloat(giphy.image.height)
        loadAnimatedImage(from: url)
    }

    private func loadAnimatedImage(from url: URL) {
        Loader.sharedInstance.loadData(with: url).subscribe(onNext: { [weak self] value in
			DispatchQueue.main.async {
				self?.setupImageView(with: value)
			}
        }).disposed(by: disposeBag)
    }

    private func setupImageView(with data: Data) {
        guard let animatedImage = AnimatedImage(data: data) else { return }

        gifImageView.showAnimatedImage(animatedImage)
        gifImageView.startAnimating()
    }

    private func configureConstraints() {
        let gifImageViewHeightConstraint = gifImageView.heightAnchor.constraint(equalToConstant: 0.0)
        NSLayoutConstraint.activate([gifImageView.topAnchor.constraint(equalTo: topAnchor, constant: viewInsets),
                                     gifImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: viewInsets),
                                     gifImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -viewInsets),
                                     gifImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -viewInsets),
                                     gifImageViewHeightConstraint,

                                     trendedIcon.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     trendedIcon.topAnchor.constraint(equalTo: topAnchor),
                                     trendedIcon.heightAnchor.constraint(equalToConstant: trendedIconHeight),
                                     trendedIcon.widthAnchor.constraint(equalToConstant: trendedIconHeight),
                                     ])

        self.gifImageViewHeightConstraint = gifImageViewHeightConstraint
    }
}
