//
//  HomeTableCell.swift
//  ToDoListApp
//
//  Created by Khalida Aliyeva on 26.12.24.
//

import UIKit

final class HomeTableCell: UITableViewCell {
    
    private lazy var cellImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var cellLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureRestriction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(model: HomeModelProtocol) {
        cellImage.image = UIImage(systemName: model.imageTitle)
        cellLabel.text = model.labelTitle
    }
    
    fileprivate func configureView() {
        contentView.addSubview(cellImage)
        contentView.addSubview(cellLabel)
        
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func configureRestriction() {
        NSLayoutConstraint.activate([
            cellImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cellImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            cellImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            cellImage.widthAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            cellLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            cellLabel.leftAnchor.constraint(equalTo: cellImage.rightAnchor, constant: 8),
            cellLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            cellLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        
    }
}
