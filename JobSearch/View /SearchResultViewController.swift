//
//  SearchResultViewController.swift
//  JobSearch
//
//  Created by Nickolay Vasilchenko on 11.11.2023.
//

import UIKit
import Combine

class SearchResultViewController: UIViewController {
//MARK: - Properties
    private let searchResultView = SearchResultView()
    private let viewModel = VacancyViewModel()
    private var cancellable = Set<AnyCancellable>()
    private var currentPage = 0
    private var isLoadingPage = false
    private var vacansyData: VacancyData?
//MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResultView.transferTableViewDelegate(delegate: self)
        searchResultView.transferTableViewDataSource(dataSource: self)
        binding()
    }

    override func loadView() {
        super.loadView()
        view = searchResultView
    }
//MARK: - Combine
    func binding() {
        searchResultView.$text
                    .receive(on: DispatchQueue.main)
                    .assign(to: \.vacancyName, on: viewModel)
                    .store(in: &cancellable)
        
        viewModel.$vacancyData.sink { [weak self] vacansyData in
            self?.currentPage = 0
            self?.vacansyData = vacansyData
            self?.reloadTable()
        }
        .store(in: &cancellable)
    }

    private func loadNextPage() {
        viewModel.loadPage(with: currentPage)
            .sink { [weak self] _ in
                self?.isLoadingPage = false
                self?.reloadTable()
            } receiveValue: { [weak self] data in
                guard var items = self?.vacansyData?.items,
                      let downloadedItems = data.items
                else { return }
                items += downloadedItems
                self?.vacansyData?.items = items
                self?.currentPage += 1
            }
            .store(in: &cancellable)
    }

//MARK: - Private methods
    private func reloadTable() {
        searchResultView.reloadTable()
    }

    private func returnSalaryString(index: Int) -> String? {
        guard let from = vacansyData?.items?[index].salary?.from else { return nil }
        guard let to = vacansyData?.items?[index].salary?.to else { return nil }
        guard let currency = vacansyData?.items?[index].salary?.currency else { return nil }
        return "\(from) - \(to) \(currency)"
    }
}
//MARK: - UITableViewDelegate extension
extension SearchResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.y
        let scrollHeight = scrollView.frame.size.height
        let contentSize = scrollView.contentSize.height
        
        if (offSet + scrollHeight) > (contentSize - 1250) && !isLoadingPage {
            isLoadingPage = true
            loadNextPage()
        }
    }
}
//MARK: - UITableViewDataSourse extension 
extension SearchResultViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vacansyData?.items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VacancyCell.id, for: indexPath) as? VacancyCell else {
            return VacancyCell()
        }
        cell.vacancyName = vacansyData?.items?[indexPath.row].name ?? ""
        cell.salary = returnSalaryString(index: indexPath.row)
        cell.companyLogo = vacansyData?.items?[indexPath.row].employer?.logoURL?.withSize90
        cell.companyName = vacansyData?.items?[indexPath.row].employer?.name ?? ""
        cell.requirements = vacansyData?.items?[indexPath.row].snippet?.requirement ?? ""
        cell.requirements = vacansyData?.items?[indexPath.row].snippet?.responsibility ?? ""
        return cell
    }
}


