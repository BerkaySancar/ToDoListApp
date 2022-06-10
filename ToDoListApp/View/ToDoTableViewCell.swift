//
//  ToDoTableViewCell.swift
//  ToDoListApp
//
//  Created by Berkay Sancar on 3.06.2022.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    private let toDoTitle: UILabel = UILabel()
    private let toDoDescription: UILabel = UILabel()
    private let toDoDate: UILabel = UILabel()
    private let toDoCheckButton: UIButton = UIButton(type: .system)
    
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
        
        addSubview(toDoTitle)
        addSubview(toDoDescription)
        addSubview(toDoDate)
        addSubview(toDoCheckButton)
        
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
        drawDesign()
    }
    
    private func drawDesign() {
        toDoTitle.font = .boldSystemFont(ofSize: 20)
        toDoDescription.font = .systemFont(ofSize: 10)
        toDoDate.font = .systemFont(ofSize: 15)
        
       
        
    }
    
    func showModel(model: ToDoModel) {
        toDoTitle.text = model.title
        toDoDate.text = model.date
        toDoDescription.text = model.description
        
        if model.isCompleted {
            toDoCheckButton.setBackgroundImage(UIImage(named: "completed"), for: UIControl.State.normal)
        } else {
            toDoCheckButton.setBackgroundImage(UIImage(named: "emptyBox"), for: UIControl.State.normal)
        }
    }
}
