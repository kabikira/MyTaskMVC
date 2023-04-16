//
//  ViewController.swift
//  MyTaskMVC
//
//  Created by koala panda on 2023/04/15.
//

import UIKit

class ViewController: UIViewController {

    private let cellClassName = "TableViewCell"
    private let reuseId = "TableViewCell"

    private let api = GitHubAPI()
    private var items: [GitHubModel] = []

    @IBOutlet private weak var serchTextField: UITextField!
    @IBOutlet private weak var searchButton: UIButton! {
        didSet {
          searchButton.addTarget(self, action: #selector(tapSearchButton(_sender:)), for: .touchUpInside)
        }
    }

    @IBOutlet weak var indicator: UIActivityIndicatorView!


    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            let cellNib = UINib(nibName: cellClassName, bundle: nil)
            tableView.register(cellNib, forCellReuseIdentifier: reuseId)
            tableView.delegate = self
            tableView.dataSource = self

            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.isHidden = true
        indicator.isHidden = true
        
    }
    @objc func tapSearchButton(_sender: UIResponder) {
        indicator.isHidden = false
        tableView.isHidden = true
        api.get(searchTextField: serchTextField.text!) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let items):
                    self.items = items
                    self.indicator.isHidden = true
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                }
            }
        }
    }
}



extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Router.shared.showWeb(from: self, gitHubModel: items[indexPath.item])
        return
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellClassName) as?
                TableViewCell else {
            fatalError()
        }
        let gitHubModel = items[indexPath.item]
        cell.congigure(gitHubModel: gitHubModel)
        return cell
    }
}
