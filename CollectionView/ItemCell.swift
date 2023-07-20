//
//  ItemCell.swift
//  CollectionView
//
//  Created by Никитин Артем on 3.04.23.
// 

import UIKit

class ItemCell: UICollectionViewCell {
    let titleLabel = UILabel(frame: .zero)
    let subTitleLable = UILabel(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLable)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15.0),
            
            subTitleLable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15.0),
            subTitleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0),
            subTitleLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0),
            subTitleLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15.0),
        ])
        
        subTitleLable.setContentHuggingPriority(.defaultLow - 2, for: .vertical)
        subTitleLable.contentMode = .center
        contentView.layer.borderColor = UIColor.green.cgColor
        contentView.layer.borderWidth = 0.5
    }
    
    //для того что-бы очистить значения
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
        subTitleLable.text = ""
    }
    
    func setup(title: String, subTitle: String) {
        titleLabel.text = title
        subTitleLable.text = subTitle
    }
    
    // сделали фиксированный размер ячейки
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        
        attributes.size = CGSize.init(width: 100.0, height: 100.0)
        return attributes
    }
}
