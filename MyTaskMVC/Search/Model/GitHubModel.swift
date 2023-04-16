//
//  GitHubModel.swift
//  MyTaskMVC
//
//  Created by koala panda on 2023/04/15.
//

import Foundation
struct GitHubModel: Codable {

    var fullname: String
    var urlStr: String { "https://github.com/\(fullname)"}
    // jsonのkeyとパラメータの対応付け
    enum CodingKeys: String, CodingKey {
        case fullname = "full_name"
    }
}

struct GitHubResponse: Codable {
    var items: [GitHubModel]
}
