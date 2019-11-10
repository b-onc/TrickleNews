//
//  ArticleCollectionViewCell.swift
//  TrickleNews
//
//  Created by Bahadir Oncel on 10.11.2019.
//  Copyright © 2019 Piyuv OU. All rights reserved.
//

import UIKit
import SnapKit
import AlamofireImage

class ArticleCollectionViewCell: UICollectionViewCell {
    static let identifier = "ArticleCollectionViewCell"
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let dateLabel = UILabel()
    private let sourceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    func configure(for article: Article) {
        titleLabel.text = article.title
        subtitleLabel.text = article.description ?? article.content
        dateLabel.text = article.publishedAt?.relativeToNowString()
        if let author = article.author {
            sourceLabel.text = "From: \(author)"
        }
        if let imageURL = article.urlToImage {
            imageView.af_setImage(withURL: imageURL)
        }
    }
    
    private func setupUI() {
        contentView.backgroundColor = .white
        
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail
        
        subtitleLabel.font = .systemFont(ofSize: 12)
        subtitleLabel.numberOfLines = 1
        subtitleLabel.lineBreakMode = .byTruncatingTail
        
        dateLabel.font = .systemFont(ofSize: 10)
        
        sourceLabel.font = .systemFont(ofSize: 11)
        
        [imageView, titleLabel, subtitleLabel, dateLabel, sourceLabel].forEach({ contentView.addSubview($0) })
        
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(imageView.snp.width).multipliedBy(9.0/16.0)
        }
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.trailing.equalTo(imageView).offset(-12)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.leading.equalTo(imageView).offset(12)
            make.trailing.equalTo(imageView).offset(-12)
        }
        
        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        sourceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
}

fileprivate extension Date {
    func relativeToNowString() -> String {
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.hour, .day, .month], from: self, to: Date())

        var stringDescription = ""
        for (component, name) in [(components.month, "month"), (components.day, "day"), (components.hour, "hour")] {
            if let diff = component, diff != 0 {
                stringDescription += "\(diff) \(name)\(diff == 0 ? "" : "s") "
            }
        }
        stringDescription += "ago"
        if stringDescription == "ago" { stringDescription = "now" }
        return stringDescription
    }
}
