//
//  TaskDetailController.swift
//  ToDoListApp
//
//  Created by Khalida Aliyeva on 27.12.24.
//

import Foundation
import UIKit

final class TaskDetailController: UIViewController {
    
    var index: Int?
    
    private lazy var textView: UITextView = {
        let text = UITextView()
        text.isEditable = false
        text.font = UIFont(name: "Times New Roman", size: 24)
        text.layer.borderWidth = 1
        text.layer.cornerRadius = 12
        text.layer.borderColor = UIColor.lightGray.cgColor
        return text
    }()
    
    private lazy var updateImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "rectangle.and.pencil.and.ellipsis")
        image.isUserInteractionEnabled = true
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView()
        configureRestriction()
        addGesture()
    }
    
    func editTextView(model: TaskDTO) {
        textView.text = model.task
    }
    
    fileprivate func addGesture() {
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(goUpdate))
        updateImage.addGestureRecognizer(gesture)
    }
    
    @objc private func goUpdate() {
        
        guard let index = index else {return}
        guard let task = textView.text else {return}
        guard !task.isEmpty else {return}
        
        let controller = UpdateController()
        let _ = controller.getIndex(index: index)
        controller.configureTextView(text: task)
        navigationController?.pushViewController(controller, animated: true)
        
        
        controller.callback = { [weak self] text in
            guard let self = self else {return}
            textView.text = text
        }
    }
    
    fileprivate func configureView() {
        view.addSubview(textView)
        view.addSubview(updateImage)

        updateImage.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func configureRestriction() {
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 72),
            textView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24),
            textView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -24),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
        ])
        
        NSLayoutConstraint.activate([
            updateImage.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -24),
            updateImage.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: -4),
            updateImage.heightAnchor.constraint(equalToConstant: 36),
            updateImage.widthAnchor.constraint(equalToConstant: 48),
        ])
    }
}
