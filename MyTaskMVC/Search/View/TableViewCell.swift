//
//  TableViewCell.swift
//  MyTaskMVC
//
//  Created by koala panda on 2023/04/15.
//

import UIKit
final class TableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var urlLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        urlLabel.text = nil
    }

    func congigure(gitHubModel: GitHubModel) {
        self.titleLabel.text = gitHubModel.fullname
        self.urlLabel.text = gitHubModel.urlStr
    }
    
}
