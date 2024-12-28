//
//  MyTasksTableCell.swift
//  ToDoListApp
//
//  Created by Khalida Aliyeva on 26.12.24.
//

import Foundation
import UIKit

final class MyTasksTableCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
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
    
    func configureCell(model: TaskModelProtocol) {
        titleLabel.text = model.titleOfTask
    }
    
    fileprivate func configureView() {
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func configureRestriction() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -48),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
