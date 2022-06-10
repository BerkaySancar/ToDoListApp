//
//  ToDoViewController.swift
//  ToDoListApp
//
//  Created by Berkay Sancar on 3.06.2022.
//

import UIKit

final class ToDoViewController: UIViewController {
    
    let tableView: UITableView = UITableView()
    let viewModel: ToDoViewModel = ToDoViewModel()
    var selectedTitle: String = ""
    var selectedDate: String = ""
    var selectedDescription: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.viewModel.getItems()
            self.tableView.reloadData()
        }
    }
    
    private func configure() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.Identifier.custom.rawValue)
        tableView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview()
        }
        
        drawDesign()
    }
    
    private func drawDesign() {
        self.navigationController?.navigationBar.topItem?.title = "To-Do List"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white];
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .systemOrange
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem =
        UIBarButtonItem(title: "ADD",
                        style: .plain,
                        target: self,
                        action: #selector(didTapAddButton))
    }
    
    @objc func didTapAddButton() {
        self.navigationController?.pushViewController(AddToDoViewController(), animated: false)
    }
}

extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ToDoTableViewCell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.Identifier.custom.rawValue) as? ToDoTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.showModel(model: viewModel.items[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            viewModel.items.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            self.tableView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedTitle = viewModel.items[indexPath.row].title
        selectedDate = viewModel.items[indexPath.row].date
        selectedDescription = viewModel.items[indexPath.row].description
        
        self.navigationController?.pushViewController(DetailsViewController(title: selectedTitle, date: selectedDate, description: selectedDescription), animated: true)
        
    }
}

