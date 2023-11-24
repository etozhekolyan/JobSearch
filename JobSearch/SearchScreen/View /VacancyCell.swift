//
//  VacancyCell.swift
//  JobSearch
//
//  Created by Nickolay Vasilchenko on 11.11.2023.
//

import UIKit

class VacancyCell: UITableViewCell {
//MARK: - Properties
    public static let id = "VacancyCell"
    public var vacancyName: String? {
        didSet {
            vacancyNameLabel.text = vacancyName
        }
    }
    public var salary: String? {
        didSet {
            salaryLabel.text = salary
        }
    }
    public var companyName: String? {
        didSet {
            employerNameLabel.text = companyName
        }
    }
    public var companyLogo: String? {
        didSet {
            employerLogo.loadFromURL(url: companyLogo, placeholder: "empLogo")
        }
    }
    public var requirements: String? {
        didSet {
            requirementsLabel.text = requirements
        }
    }
    public var jobResponsibilities: String? {
        didSet {
            responsibilityLabel.text = jobResponsibilities
        }
    }
//MARK: - UI elements
    private var vacancyNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        label.numberOfLines = 0
        return label
    }()

    private var salaryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        return label
    }()

    private var employerNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    private var requirementsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()

    private var responsibilityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()

    private var employerLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
//MARK: - init methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addToHierarchy()
        setupCell()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: - View preparations
    
    private func addToHierarchy() {
        addSubview(vacancyNameLabel)
        addSubview(salaryLabel)
        addSubview(employerLogo)
        addSubview(employerNameLabel)
        addSubview(requirementsLabel)
        addSubview(responsibilityLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        employerLogo.layer.cornerRadius = employerLogo.bounds.size.width / 2

    }

    private func setupCell() {
        vacancyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        salaryLabel.translatesAutoresizingMaskIntoConstraints = false
        employerLogo.translatesAutoresizingMaskIntoConstraints = false
        employerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        requirementsLabel.translatesAutoresizingMaskIntoConstraints = false
        responsibilityLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setLayout() {
        NSLayoutConstraint.activate([
            vacancyNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            vacancyNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            vacancyNameLabel.widthAnchor.constraint(equalToConstant: 250),
            
            salaryLabel.topAnchor.constraint(equalTo: vacancyNameLabel.bottomAnchor, constant: 10),
            salaryLabel.leadingAnchor.constraint(equalTo: vacancyNameLabel.leadingAnchor),
            salaryLabel.heightAnchor.constraint(equalToConstant: 25),
            
            employerLogo.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            employerLogo.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            employerLogo.widthAnchor.constraint(equalToConstant: 100),
            employerLogo.heightAnchor.constraint(equalToConstant: 100),
            
            employerNameLabel.topAnchor.constraint(equalTo: salaryLabel.topAnchor, constant: 40),
            employerNameLabel.leadingAnchor.constraint(equalTo: salaryLabel.leadingAnchor),
            employerNameLabel.heightAnchor.constraint(equalToConstant: 25),
            
            requirementsLabel.topAnchor.constraint(equalTo: employerNameLabel.topAnchor, constant: 35),
            requirementsLabel.leadingAnchor.constraint(equalTo: employerNameLabel.leadingAnchor),
            requirementsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            requirementsLabel.heightAnchor.constraint(equalToConstant: 50),
            
            responsibilityLabel.topAnchor.constraint(equalTo: requirementsLabel.topAnchor, constant: 55),
            responsibilityLabel.leadingAnchor.constraint(equalTo: requirementsLabel.leadingAnchor),
            responsibilityLabel.trailingAnchor.constraint(equalTo: requirementsLabel.trailingAnchor),
            responsibilityLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
