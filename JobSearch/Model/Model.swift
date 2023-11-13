//
//  VacancyData.swift
//  JobSearch
//
//  Created by Nickolay Vasilchenko on 12.11.2023.
//

import Foundation

struct VacancyData: Codable {
    var items: [VacancyItem]?
    var pages: Int?
    var perPage: Int?
    var page: Int?

    enum CodingKeys: String, CodingKey {
        case items, pages, page
        case perPage = "per_page"
    }
}

struct VacancyItem: Codable {
    var id: String?
    var name: String?
    var salary: Salary?
    var employer: Employer?
    var snippet: Snippet?
}

struct Salary: Codable {
    var from: Int?
    var to: Int?
    var currency: String?
}

struct Employer: Codable {
    var id: String?
    var name: String?
    var logoURL: LogoURL?
}

struct LogoURL: Codable {
    var withSize90: String?
    var withSize240: String?
    var original: String?
    
    enum CodingKeys: String, CodingKey {
        case original
        case withSize90 = "90"
        case withSize240 = "240"
    }
}

struct Snippet: Codable {
    var requirement: String?
    var responsibility: String?
}
