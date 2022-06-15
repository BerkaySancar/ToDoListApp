//
//  ToDoViewController.swift
//  ToDoListApp
//
//  Created by Berkay Sancar on 3.06.2022.
//

import UIKit

final class ToDoViewController: UIViewController {
   
    private let viewModel: ToDoViewModel = ToDoViewModel()
    private let tableView: UITableView = UITableView()
    private var selectedTitle: String = ""
    private var selectedDate: String = ""
    private var selectedDescription: String = ""
    private let emptyBox = UIImage(named: "empty")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
    private let doneBox = UIImage(named: "done")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
  
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
        tableView.backgroundColor = .white
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.Identifier.custom.rawValue)
        tableView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview()
        }
        
        design()
    }
    
    private func design() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = .systemGreen
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.topItem?.title = "To-Do List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white];
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.rightBarButtonItem =
        UIBarButtonItem(title: "ADD",
                        style: .plain,
                        target: self,
                        action: #selector(didTapAddButton))
    }
    
    @objc func didTapAddButton() {
        self.navigationController?.pushViewController(AddViewController(), animated: false)
    }
    
    @objc func checkButtonTapped(_ sender: UIButton) {
            
        self.viewModel.updateToDo(item: viewModel.items[sender.tag])
            self.tableView.reloadData()
    }
}

extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.Identifier.custom.rawValue) as! ToDoTableViewCell
        
        cell.selectionStyle = .none
        cell.toDoTitle.text = viewModel.items[indexPath.row].title
        cell.toDoDate.text = viewModel.items[indexPath.row].date
        cell.toDoDescription.text = viewModel.items[indexPath.row].description
        cell.toDoCheckButton.tag = indexPath.row
        cell.toDoCheckButton.addTarget(self, action: #selector(checkButtonTapped), for: UIControl.Event.touchUpInside)
        
        if viewModel.items[indexPath.row].isCompleted == true {
            cell.toDoCheckButton.setBackgroundImage(doneBox, for: UIControl.State.normal)
            cell.toDoTitle.textColor = .systemGreen
            cell.toDoDate.textColor = .systemGreen
            cell.toDoDescription.textColor = .systemGreen
        } else {
            cell.toDoCheckButton.setBackgroundImage(emptyBox, for: UIControl.State.normal)
            cell.toDoTitle.textColor = .black
            cell.toDoDate.textColor = .black
            cell.toDoDescription.textColor = .black
        }
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
        
        self.navigationController?.pushViewController(UpdateViewController(title: selectedTitle, date: selectedDate, description: selectedDescription), animated: true)
    }
}
