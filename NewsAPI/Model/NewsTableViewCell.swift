//
//  NewsTableViewCell.swift
//  NewsAPI
//
//  Created by Migy Yabut on 7/31/21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    
    private let headerLabel: UILabel = {
        //author
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let titleLabel: UILabel = {
        //title
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let detailLabel: UILabel = {
        //description
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(headerLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerLabel.frame = CGRect(x: 10, y: -5,
                                   width: contentView.frame.size.width - 20,
                                   height: contentView.frame.size.height/2)
        titleLabel.frame = CGRect(x: 10, y: 45,
                                   width: contentView.frame.size.width - 20,
                                   height: contentView.frame.size.height/2)
        detailLabel.frame = CGRect(x: 10, y: 90,
                                   width: contentView.frame.size.width - 20,
                                   height: contentView.frame.size.height/2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        headerLabel.text = nil
        titleLabel.text = nil
        detailLabel.text = nil 
    }
    
    func configure(with viewModel: NewsTVCViewModel) {
        headerLabel.text = viewModel.header
        titleLabel.text = viewModel.title
        detailLabel.text = viewModel.detail
    }
}
