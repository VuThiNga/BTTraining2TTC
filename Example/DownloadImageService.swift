//
//  DownloadImageService.swift
//  Example
//
//  Created by Ngavt on 1/18/21.
//

import Foundation
import Moya

enum DownloadImageService {
    case photos(params: [String: Any])
}

extension DownloadImageService: TargetType {
    var baseURL: URL {
        return URL(string: URLs.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .photos:
            return "/photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .photos:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case let .photos(params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        let header = ["Content-type": "application/json"]
        return header
    }
    
    
}
