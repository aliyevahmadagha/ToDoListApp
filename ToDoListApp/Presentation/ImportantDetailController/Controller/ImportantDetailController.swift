//
//  ImportantDetailController.swift
//  ToDoListApp
//
//  Created by Khalida Aliyeva on 28.12.24.
//

import Foundation
import UIKit

final class ImportantDetailController: UIViewController {
    
    private lazy var textView: UITextView = {
        let text = UITextView()
        text.isEditable = false
        text.font = UIFont(name: "Times New Roman", size: 24)
        text.layer.borderWidth = 1
        text.layer.cornerRadius = 12
        text.layer.borderColor = UIColor.lightGray.cgColor
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView()
        configureRestriction()
    }
    
    func editTextView(model: ImportantDTO) {
        textView.text = model.importantTask
    }
    
    fileprivate func configureView() {
        view.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func configureRestriction() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 72),
            textView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            textView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -24),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
        ])
    }
    
}
