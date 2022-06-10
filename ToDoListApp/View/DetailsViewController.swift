//
//  DetailsViewController.swift
//  ToDoListApp
//
//  Created by Berkay Sancar on 9.06.2022.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    init(title: String, date: String, description: String) {
        self.showTitleTextField.text = title
        self.showDateTextField.text = date
        self.showDescriptionTextField.text = description
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: ToDoViewModel = ToDoViewModel()
    let titleLabel: UILabel = UILabel()
    let dateLabel: UILabel = UILabel()
    let descriptionLabel: UILabel = UILabel()
    let showTitleTextField: UITextField = UITextField()
    let showDateTextField: UITextField = UITextField()
    let showDescriptionTextField: UITextField = UITextField()
    let updateButton: UIButton = UIButton(type: UIButton.ButtonType.system)
    private let datePicker = UIDatePicker()
    private let toolbar = UIToolbar()
    private let formatter = DateFormatter()
    private var index: Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        index = viewModel.items.firstIndex(where: {$0.title == showTitleTextField.text})!
    }
    
    func configure() {
        view.addSubview(titleLabel)
        view.addSubview(showTitleTextField)
        view.addSubview(dateLabel)
        view.addSubview(showDateTextField)
        view.addSubview(descriptionLabel)
        view.addSubview(showDescriptionTextField)
        view.addSubview(updateButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        showTitleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(showTitleTextField.snp.bottom).offset(20)
            make.left.equalTo(showTitleTextField)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        showDateTextField.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.left.equalTo(dateLabel)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(showDateTextField.snp.bottom).offset(20)
            make.left.equalTo(showDateTextField)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        showDescriptionTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.left.equalTo(descriptionLabel)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        updateButton.snp.makeConstraints { make in
            make.top.equalTo(showDescriptionTextField.snp.bottom).offset(40)
            make.centerX.equalTo(view.center.x)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        drawDesing()
    }
    func drawDesing() {
        navigationItem.title = "Detail & Update To-Do"
        view.backgroundColor = .white
        titleLabel.text = "To-Do:"
        titleLabel.textColor = .systemOrange
        dateLabel.text = "Date:"
        dateLabel.textColor = .systemOrange
        descriptionLabel.text = "Description:"
        descriptionLabel.textColor = .systemOrange
        
        showTitleTextField.font = UIFont.systemFont(ofSize: 20)
        showTitleTextField.borderStyle = .line
        showTitleTextField.layer.borderWidth = 1.0
        showTitleTextField.layer.borderColor = UIColor.systemOrange.cgColor
        showTitleTextField.layer.cornerRadius = 7
        showTitleTextField.layer.masksToBounds = true
        
        createDatePicker()
        showDateTextField.font = UIFont.systemFont(ofSize: 20)
        showDateTextField.borderStyle = .line
        showDateTextField.layer.borderWidth = 1.0
        showDateTextField.layer.borderColor = UIColor.systemOrange.cgColor
        showDateTextField.layer.cornerRadius = 7
        showDateTextField.layer.masksToBounds = true
        
        showDescriptionTextField.font = UIFont.systemFont(ofSize: 20)
        showDescriptionTextField.borderStyle = .line
        showDescriptionTextField.layer.borderWidth = 1.0
        showDescriptionTextField.layer.borderColor = UIColor.systemOrange.cgColor
        showDescriptionTextField.layer.cornerRadius = 7
        showDescriptionTextField.layer.masksToBounds = true
        
        updateButton.setTitle("Update", for: UIControl.State.normal)
        updateButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        updateButton.backgroundColor = .systemOrange
        updateButton.titleLabel?.font = .systemFont(ofSize: 20)
        updateButton.layer.cornerRadius = 20
        updateButton.addTarget(self, action: #selector(updateButtonTapped), for: UIControl.Event.touchUpInside)
        
    }
    private func createDatePicker() {
        toolbar.sizeToFit()
       
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: nil,
                                         action: #selector(doneTapped))
        
        toolbar.setItems([doneButton], animated: true)
        
        showDateTextField.inputAccessoryView = toolbar
        showDateTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.backgroundColor = .white
    }
    
    @objc private func doneTapped() {
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        
        showDateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func updateButtonTapped() {
        viewModel.items[index].title = showTitleTextField.text ?? ""
        viewModel.items[index].date = showDateTextField.text ?? ""
        viewModel.items[index].description = showDescriptionTextField.text ?? ""
        
        self.navigationController?.popViewController(animated: true)
        
    }
}
