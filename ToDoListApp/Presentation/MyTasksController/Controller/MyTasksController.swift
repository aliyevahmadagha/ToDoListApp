//
//  MyTasksController.swift
//  ToDoListApp
//
//  Created by Khalida Aliyeva on 26.12.24.
//

import Foundation
import UIKit

final class MyTasksController: UIViewController {
    
    private let helper = RealmHelper()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 48
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addTaskButtonClicked))
        navigationItem.rightBarButtonItem = button
        
        view.backgroundColor = .systemBackground
        setupTableView()
        configureView()
        configureRestriction()
    }
    
    @objc private func addTaskButtonClicked() {
        
        let controller = AddTaskController()
        navigationController?.pushViewController(controller, animated: true)
        
        controller.callback = { [weak self] text, task in
            guard let self = self else {return}
            
            let dto = TaskDTO()
            dto.title = text
            dto.task = task
            
            helper.saveTask(dtoModel: dto)
            
            tableView.reloadData()
        }
    }
    
    fileprivate func getCount() -> Int {
        let list = helper.fetchTasks()
        return list.count
    }
    
    fileprivate func getItem(index: Int) -> TaskDTO {
        let list = helper.fetchTasks()
        return list[index]
    }
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyTasksTableCell.self, forCellReuseIdentifier: "MyTasksTableCell")
    }
    
    fileprivate func configureView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func reloadTable() {
        NotificationCenter.default.post(name: .reloadDataNotification, object: nil)
    }
    
    fileprivate func configureRestriction() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MyTasksController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTasksTableCell", for: indexPath) as! MyTasksTableCell
        
        let model = getItem(index: indexPath.row)
        cell.configureCell(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = getItem(index: indexPath.row)
        let controller = TaskDetailController()
        controller.editTextView(model: model)
        controller.index = indexPath.row
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { _, _, _ in
            
            self.helper.deleteTask(index: indexPath.row)
            self.tableView.reloadData()
        }
        
        let addImportant = UIContextualAction(style: .normal, title: "add") { _, _, _ in
            
            let list = self.helper.fetchTasks()
            
            let task = list[indexPath.row].task
            let title = list[indexPath.row].title
            
            let importantDTO = ImportantDTO()
            importantDTO.importantTask = task
            importantDTO.importantTitle = title
            
            self.helper.saveImportantTask(dtoModel: importantDTO)
            
            self.reloadTable()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, addImportant])
    }
}

