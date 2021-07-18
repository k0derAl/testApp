//
//  WeatherOfCityNetRouter.swift
//  WeatherApp

import Foundation
import Alamofire

class SittintNetRouter {
    static let mainPath = "https://api.punkapi.com/v2/"
    // static let apiKey = "6e4cccc00efdf57bfcf1a5a28d53e453"
}

public enum NetRouter: URLRequestConvertible {
    
    case getData([String: Any])
    
    public func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
                case
                    .getData:
                    return .get
            }
        }
        let params: ([String: Any]?) = {
            switch self {
                case .getData(let json):
                    return (json)
            }
        }()
        let url: URL = {
            // build up and return the URL for each endpoint
            let url = URL(string: SittintNetRouter.mainPath)!.appendingPathComponent(relativePath)
            return url
        }()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        let encoding: ParameterEncoding = {
            switch method {
                case .get:
                    return URLEncoding.default

                default:
                    return JSONEncoding.default
            }
        }()
        return try encoding.encode(urlRequest, with: params)
    }
    var relativePath: String {
        let path: String
        switch self {
            case .getData(let json):
                    path = "beers"
        }
        return path
    }
}
