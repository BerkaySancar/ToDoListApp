//
//  AddToDoViewController.swift
//  ToDoListApp
//
//  Created by Berkay Sancar on 5.06.2022.
//

import UIKit

final class AddViewController: UIViewController {
    
    private let viewModel: ToDoViewModel = ToDoViewModel()
    private let titleTextField: UITextField = UITextField()
    private let dateTextField: UITextField = UITextField()
    private let descriptionTextField: UITextField = UITextField()
    private let saveButton: UIButton = UIButton(type: .system)
    private let datePicker = UIDatePicker()
    private let toolbar = UIToolbar()
    private let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(dateTextField)
        view.addSubview(saveButton)
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
            make.right.left.equalTo(titleTextField)
            make.height.equalTo(titleTextField)
        }
        descriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(20)
            make.right.left.equalTo(dateTextField)
            make.height.equalTo(titleTextField)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextField.snp.bottom).offset(40)
            make.height.equalTo(50)
            make.width.equalTo(100)
            make.centerX.equalTo(view.center.x)
        }
       design()
    }
    
    private func design() {
        navigationItem.title = "Create To-Do"
        view.backgroundColor = .white

        titleTextField.placeholder = "Title:"
        titleTextField.font = UIFont.systemFont(ofSize: 20)
        titleTextField.borderStyle = .line
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.borderColor = UIColor.systemGreen.cgColor
        titleTextField.layer.cornerRadius = 7
        titleTextField.layer.masksToBounds = true
        titleTextField.setLeftPaddingPoints(5)
        
        createDatePicker()
        dateTextField.placeholder = "Date:"
        dateTextField.font = UIFont.systemFont(ofSize: 20)
        dateTextField.borderStyle = .line
        dateTextField.layer.borderWidth = 1
        dateTextField.layer.borderColor = UIColor.systemGreen.cgColor
        dateTextField.layer.cornerRadius = 7
        dateTextField.layer.masksToBounds = true
        dateTextField.setLeftPaddingPoints(5)
        
        descriptionTextField.placeholder = "Description:"
        descriptionTextField.font = UIFont.systemFont(ofSize: 20)
        descriptionTextField.borderStyle = .line
        descriptionTextField.layer.borderWidth = 1
        descriptionTextField.layer.borderColor = UIColor.systemGreen.cgColor
        descriptionTextField.layer.cornerRadius = 7
        descriptionTextField.layer.masksToBounds = true
        descriptionTextField.setLeftPaddingPoints(5)
        
        saveButton.setTitle("Save", for: UIControl.State.normal)
        saveButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        saveButton.backgroundColor = .systemGreen
        saveButton.titleLabel?.font = .systemFont(ofSize: 20)
        saveButton.layer.cornerRadius = 20
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: UIControl.Event.touchUpInside)
    }
    
    private func createDatePicker() {
        toolbar.sizeToFit()
       
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: nil,
                                         action: #selector(doneTapped))
        
        toolbar.setItems([doneButton], animated: true)
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .inline
        datePicker.backgroundColor = .white
    }
    
    @objc private func doneTapped() {
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        
        dateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc private func saveButtonTapped() {
        if titleTextField.text != "" && descriptionTextField.text != "" && dateTextField.text != "" {
            viewModel.addToDo(title: titleTextField.text!,
                              date: dateTextField.text!,
                              description: descriptionTextField.text!)
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}
