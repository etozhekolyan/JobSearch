//
//  ViewModel .swift
//  JobSearch
//
//  Created by Nickolay Vasilchenko on 12.11.2023.
//

import Foundation
import Combine

final class VacancyViewModel: ObservableObject {
    @Published var vacancyName = ""
    @Published var vacancyData = VacancyData()
    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        $vacancyName
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { (vacansyName: String) -> AnyPublisher<VacancyData, Never> in
                HeadHunterAPI.shared.fetchData(for: vacansyName)
            }
            .assign(to: \.vacancyData, on: self)
            .store(in: &self.cancellableSet)
    }

    func loadPage(with number: Int) -> AnyPublisher<VacancyData, Never> {
        HeadHunterAPI.shared.fetchData(for: vacancyName, page: number)
    }
}
