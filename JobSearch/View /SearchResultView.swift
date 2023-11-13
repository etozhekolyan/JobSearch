//
//  SearchResultView.swift
//  JobSearch
//
//  Created by Nickolay Vasilchenko on 11.11.2023.
//

import UIKit

class SearchResultView: UIView {
    @Published var text: String = ""
//MARK: - UI elements
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()

    private lazy var textField: UITextField = {
        let field = UITextField()
        field.placeholder = "Text here"
        field.layer.borderColor = UIColor.gray.cgColor
        field.layer.borderWidth = 1
        field.delegate = self
        return field
    }()
//MARK: - init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        configureView()
        registerCells()
        addToHierarchy()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: - View preparation
    private func registerCells() {
        tableView.register(VacancyCell.self, forCellReuseIdentifier: VacancyCell.id)
    }

    private func configureView() {
        self.backgroundColor = .white
    }

    private func setLayout() {
        let guide = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: textField.topAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func addToHierarchy() {
        self.addSubview(tableView)
        self.addSubview(textField)
    }
//MARK: - public methods
    func transferTableViewDelegate(delegate:UITableViewDelegate) {
        tableView.delegate = delegate
    }

    func transferTableViewDataSource(dataSource: UITableViewDataSource) {
        tableView.dataSource = dataSource
    }

    func reloadTable() {
        tableView.reloadData()
    }
}


extension SearchResultView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let typedText = textField.text, typedText.count >= 3 {
            text = typedText
        }
    }
}
