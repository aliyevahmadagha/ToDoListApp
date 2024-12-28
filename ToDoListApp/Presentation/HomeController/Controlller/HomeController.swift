//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Khalida Aliyeva on 26.12.24.
//

import UIKit

final class HomeController: UIViewController {
    
    private let helper = RealmHelper()
    
    var homeList: [HomeModel] = [
        .init(imageName: "list.bullet.clipboard", labelText: "My Tasks"),
        .init(imageName: "list.star", labelText: "Important Tasks")
    ]
    
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
        helper.findPath()
        
        navigationItem.title = "Welcome"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableCell.self, forCellReuseIdentifier: "HomeTableCell")
    }
    
    fileprivate func configureView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func configureRestriction() {
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as! HomeTableCell
        
        let model = homeList[indexPath.row]
        cell.configureCell(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            let controller = MyTasksController()
            navigationController?.pushViewController(controller, animated: true)
        case 1:
            let controller = ImportantController()
            navigationController?.pushViewController(controller, animated: true)
        default:
            break
        }
    }
}

