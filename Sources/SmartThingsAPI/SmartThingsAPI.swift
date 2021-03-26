//
//  SmartThingsAPI.swift
//  SmartThingsAPI
//
//  Created by H. Kamran on 3/25/21.
//

import Foundation
import SwiftyJSON

public final class SmartThingsAPI: API {
    // swiftformat:disable:next all
    final public let baseUrl: URL = URL(string: "https://api.smartthings.com/v1")!
    public var accessToken: String
    
    public init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    public func getDevices(completionHandler: @escaping (Result<[Device], RequestError>) -> Void) {
        self.performRequest(path: .devices, method: .get) { result in
            var devices: [Device] = []
            
            if case .success(let responseData) = result {
                do {
                    let json = try JSON(data: responseData)
                    
                    json["items"].forEach { _, device in
                        let deviceName = device["label"].stringValue != "" ? device["label"].stringValue : device["name"].stringValue
                        let deviceCapabilities = device["components"][0]["capabilities"]
                        
                        print(deviceCapabilities)
                        
                        let element = Device(id: device["deviceId"].stringValue, name: deviceName, capabilities: [])

                        devices.append(element)
                    }
                    
                    completionHandler(.success(devices))
                } catch {
                    print("(getDevices) JSON error: \(error.localizedDescription)")
                    completionHandler(.failure(.badJson))
                }
            } else {
                print("(getDevices) Request failed")
                completionHandler(.failure(.requestFailed))
            }
        }
    }
    
    public func getState(deviceId: String) -> State {
        return State(state: .off, percentage: nil)
    }
    
    public func setState(deviceId: String, state: PowerState, percentage: Double?) -> State {
        return State(state: .off, percentage: nil)
    }
    
    private func performRequest(path: Endpoints, method: HTTPMethods, completionHandler: @escaping (Result<Data, RequestError>) -> Void) {
        guard let url = URL(string: path.rawValue, relativeTo: self.baseUrl) else {
            completionHandler(.failure(.badUrl))
            return
        }
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.setValue("Bearer \(self.accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { data, _, error in
            if let error = error {
                print("(performRequest) Error: \(error.localizedDescription)")
                completionHandler(.failure(.unknownError))
            } else {
                if let data = data {
                    completionHandler(.success(data))
                } else {
                    completionHandler(.failure(.dataNotSet))
                }
            }
        }
        
        task.resume()
    }
}
