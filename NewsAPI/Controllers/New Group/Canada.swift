//
//  Canada.swift
//  NewsAPI
//
//  Created by Migy Yabut on 7/30/21.
//

import UIKit
import SnapKit
import SafariServices

class CanadaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView: UITableView = {
        let label = UITableView()
        label.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return label
    }()
    
    private var articles = [Properties]()
    private var newsCellViewModel = [NewsTVCViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        NewsViewModel.NewsAPI.newsDisplayCA { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.newsCellViewModel = articles.compactMap({
                    NewsTVCViewModel(header: $0.author ?? "No Author",
                                     title: $0.title,
                                     detail: $0.publishedAt)
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }

        tableView.snp.makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsCellViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        cell.configure(with: newsCellViewModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let articles = articles[indexPath.row]
        guard let url = URL(string: articles.url ?? "") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
