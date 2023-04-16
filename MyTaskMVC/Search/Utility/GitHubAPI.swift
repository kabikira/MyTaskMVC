//
//  GitHubAPI.swift
//  MyTaskMVC
//
//  Created by koala panda on 2023/04/15.
//

import Foundation
enum GitHubError: Error {
    case error
}
final class GitHubAPI {
    func get (searchTextField: String ,completion: ((Result<[GitHubModel], GitHubError>) -> Void)? = nil) {
        if let url = URL(string: "https://api.github.com/search/repositories?q=\(searchTextField)&sort=stars") {
            let urlRequest = URLRequest(url: url)
            let session = URLSession.shared
            let task = session.dataTask(with: urlRequest) { (data, response, error) in
                let jsonDecoder = JSONDecoder()
                guard let data  = data,
                      let decoded = try? jsonDecoder.decode(GitHubResponse.self, from: data) else {
                    completion?(.failure(.error))
                    return
                }
                completion?(.success(decoded.items))
            }
            task.resume()
        }
    }
}
