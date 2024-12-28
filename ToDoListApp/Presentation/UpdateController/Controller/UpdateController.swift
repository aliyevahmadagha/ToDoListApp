//
//  UpdateController.swift
//  ToDoListApp
//
//  Created by Khalida Aliyeva on 28.12.24.
//

import Foundation
import UIKit

final class UpdateController: UIViewController {
    
    private let helper = RealmHelper()
    
    var callback: ((String) -> Void)?
    
    private lazy var taskView: UITextView = {
        let text = UITextView()
        text.font = UIFont(name: "Times New Roman", size: 24)
        text.layer.borderWidth = 1
        text.layer.cornerRadius = 12
        text.layer.borderColor = UIColor.lightGray.cgColor
        return text
    }()
    
    private lazy var updateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Update", for: .normal)
        button.addTarget(self, action: #selector(updateButtonClicked), for: .touchUpInside)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 12
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView()
        configureRestriction()
    }
    
    func configureTextView(text: String) {
        taskView.text = text
    }
    
    func getIndex(index: Int = 0) -> Int {
        return index
    }
    
    @objc private func updateButtonClicked() {
        guard let task = taskView.text else {return}
        guard !task.isEmpty else {return}
        
        helper.updateTask(index: getIndex(), text: task)
        
        callback?(task)
        
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func configureView() {
        view.addSubview(taskView)
        view.addSubview(updateButton)
        
        taskView.translatesAutoresizingMaskIntoConstraints = false
        updateButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func configureRestriction() {
        
        NSLayoutConstraint.activate([
            taskView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            taskView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            taskView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -24),
            taskView.bottomAnchor.constraint(equalTo: updateButton.topAnchor, constant: -24),
        ])
        
        NSLayoutConstraint.activate([
            updateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            updateButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            updateButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -24),
            updateButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
}
