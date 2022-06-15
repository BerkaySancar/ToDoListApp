//
//  ToDoTableViewCell.swift
//  ToDoListApp
//
//  Created by Berkay Sancar on 3.06.2022.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    private let viewModel: ToDoViewModel = ToDoViewModel()
    let toDoTitle: UILabel = UILabel()
    let toDoDescription: UILabel = UILabel()
    let toDoDate: UILabel = UILabel()
    let toDoCheckButton: UIButton = UIButton(type: .system)

    enum Identifier: String {
        case custom = "ToDoCell"
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        contentView.addSubview(toDoTitle)
        contentView.addSubview(toDoDescription)
        contentView.addSubview(toDoDate)
        contentView.addSubview(toDoCheckButton)
        
        toDoTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        toDoDate.snp.makeConstraints { make in
            make.top.equalTo(toDoTitle.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        toDoDescription.snp.makeConstraints { make in
            make.top.equalTo(toDoDate.snp.bottom).offset(20)
            make.left.right.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
        }
        toDoCheckButton.snp.makeConstraints { make in
            make.top.equalTo(toDoTitle.snp.bottom)
            make.right.equalToSuperview().offset(-30)
            make.width.height.equalTo(30)
        }
        design()
    }
    
    private func design() {
        toDoTitle.font = .boldSystemFont(ofSize: 25)
        toDoDescription.font = .systemFont(ofSize: 15)
        toDoDate.font = .systemFont(ofSize: 15)
        
    }
    
 

}
