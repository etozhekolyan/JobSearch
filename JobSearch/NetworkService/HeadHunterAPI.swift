//
//  HeadHunterAPI.swift
//  JobSearch
//
//  Created by Nickolay Vasilchenko on 12.11.2023.
//

import Foundation
import Combine

final class HeadHunterAPI {
    private let baseURL = "https://api.hh.ru/vacancies"
    
    static var shared = HeadHunterAPI()
    
    private func assembleURLRequest(vacancyName: String, page: Int) -> URL? {
        let queryURL = URL(string: baseURL)!
        let queryPage = String(page)
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
        guard var components = components else { return nil }
        components.queryItems = [
            URLQueryItem(name: "per_page", value: "10"),
            URLQueryItem(name: "page", value: queryPage),
            URLQueryItem(name: "text", value: vacancyName),
            URLQueryItem(name: "only_with_salary", value: "true")
        ]
        return components.url
    }
    
    func fetchData(for vacancyName: String, page: Int = 0) -> AnyPublisher<VacancyData, Never> {
        guard let url = assembleURLRequest(vacancyName: vacancyName, page: page) else {
            return Just(VacancyData())
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: VacancyData.self, decoder: JSONDecoder())
            .catch { error in Just(VacancyData()) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
