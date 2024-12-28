//
//  ImportantController.swift
//  ToDoListApp
//
//  Created by Khalida Aliyeva on 27.12.24.
//

import Foundation
import UIKit

final class ImportantController: UIViewController {
    
    private let helper = RealmHelper()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 48
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupTableView()
        configureView()
        configureRestriction()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: .reloadDataNotification, object: nil)
    }
    
    @objc func reloadTable() {
        tableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func getImportantCount() -> Int {
        let list = helper.fetchImportantTasks()
        return list.count
    }
    
    fileprivate func getImportantItem(index: Int) -> ImportantDTO {
        let list = helper.fetchImportantTasks()
        return list[index]
    }
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImportantCell.self, forCellReuseIdentifier: "ImportantCell")
    }
    
    fileprivate func configureView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
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

extension ImportantController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getImportantCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImportantCell", for: indexPath) as! ImportantCell
        
        let model = getImportantItem(index: indexPath.row)
        cell.configureCell(model: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { _, _, _ in
            
            self.helper.deleteImportantTask(index: indexPath.row)
            self.tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = getImportantItem(index: indexPath.row)
        let controller = ImportantDetailController()
        controller.editTextView(model: model)
        
        navigationController?.pushViewController(controller, animated: true)
    }
}


