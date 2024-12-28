//
//  AddTaskController.swift
//  ToDoListApp
//
//  Created by Khalida Aliyeva on 27.12.24.
//

import Foundation
import UIKit

final class AddTaskController: UIViewController {
    
    var callback: ((String, String) -> Void)?
    
    private lazy var titleField: UITextField = {
        let field = UITextField()
        field.placeholder = "Title"
        return field
    }()
    
    private lazy var fieldView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    private lazy var taskView: UITextView = {
        let view = UITextView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.font = UIFont(name: "Times New Roman", size: 18)
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create", for: .normal)
        button.addTarget(self, action: #selector(createButtonClicked), for: .touchUpInside)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 12
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureView()
        configureRestriction()
    }
    
    @objc private func createButtonClicked() {
        guard let title = titleField.text else {return}
        guard let task = taskView.text else {return}
        guard !title.isEmpty else {return}
        guard !task.isEmpty else {return}
        
        callback?(title, task)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    fileprivate func configureView() {
        view.addSubview(fieldView)
        fieldView.addSubview(titleField)
        view.addSubview(taskView)
        view.addSubview(createButton)
        
        titleField.translatesAutoresizingMaskIntoConstraints = false
        taskView.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false
        fieldView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func configureRestriction() {
        NSLayoutConstraint.activate([
            fieldView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            fieldView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            fieldView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -24),
            fieldView.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            titleField.topAnchor.constraint(equalTo: fieldView.topAnchor, constant: 12),
            titleField.leftAnchor.constraint(equalTo: fieldView.leftAnchor, constant: 12),
            titleField.rightAnchor.constraint(equalTo: fieldView.rightAnchor, constant: -12),
            titleField.bottomAnchor.constraint(equalTo: fieldView.bottomAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            taskView.topAnchor.constraint(equalTo: fieldView.bottomAnchor, constant: 24),
            taskView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            taskView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -24),
            taskView.bottomAnchor.constraint(equalTo: createButton.topAnchor, constant: -48)
        ])
        
        NSLayoutConstraint.activate([
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            createButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            createButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -24),
            createButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
