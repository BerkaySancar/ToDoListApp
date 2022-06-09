//
//  DetailsViewController.swift
//  ToDoListApp
//
//  Created by Berkay Sancar on 9.06.2022.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    let titleLabel: UILabel = UILabel()
    let dateLabel: UILabel = UILabel()
    let descriptionLabel: UILabel = UILabel()
    let showTitleTextView: UITextView = UITextView()
    let showDateTextView: UITextView = UITextView()
    let showDescriptionTextView: UITextView = UITextView()
    private let datePicker = UIDatePicker()
    private let toolbar = UIToolbar()
    private let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
            configure()
    }
    
    func configure() {
        view.addSubview(titleLabel)
        view.addSubview(showTitleTextView)
        view.addSubview(dateLabel)
        view.addSubview(showDateTextView)
        view.addSubview(descriptionLabel)
        view.addSubview(showDescriptionTextView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        showTitleTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(showTitleTextView.snp.bottom).offset(20)
            make.left.equalTo(showTitleTextView)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        showDateTextView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.left.equalTo(dateLabel)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(showDateTextView.snp.bottom).offset(20)
            make.left.equalTo(showDateTextView)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        showDescriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.left.equalTo(descriptionLabel)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        drawDesing()
    }
    func drawDesing() {
        view.backgroundColor = .white
        titleLabel.text = "To-Do:"
        dateLabel.text = "Date:"
        descriptionLabel.text = "Description:"
        
        showTitleTextView.isEditable = true
        showDateTextView.isEditable = true
        showDescriptionTextView.isEditable = true
        
        
    }
    private func createDatePicker() {
        toolbar.sizeToFit()
       
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: nil,
                                         action: #selector(doneTapped))
        
        toolbar.setItems([doneButton], animated: true)
        
        showDateTextView.inputAccessoryView = toolbar
        showDateTextView.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.backgroundColor = .white
    }
    
    @objc private func doneTapped() {
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        
        showDateTextView.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
}
