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
    final let baseUrl: URL = URL(string: "https://api.smartthings.com/v1")!
    var accessToken: String
    
    public init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    public func getDevices(completionHandler: @escaping (Result<[Device], RequestError>) -> Void) {
        var devices = [Device]()
        performRequest(path: .devices, method: .get) { result in
            if case .success(let data) = result {
                do {
                    let json = try JSON(data: data)
                    
                    json.forEach { _, device in
                        devices.append(Device(id: device["deviceId"].stringValue, name: device["label"].stringValue != "" ? device["label"].stringValue : device["name"].stringValue, capabilities: device["components"]["capabilities"].map { $1["id"].stringValue }))
                    }
                    
                    completionHandler(.success(devices))
                } catch {
                    print("[JSON Error] \(error.localizedDescription)")
                    completionHandler(.failure(.badJson))
                }
            }
        }
        
    }
    
    public func getState(deviceId: String) -> State {
        return State(state: .off, percentage: nil)
    }
    
    public func setState(deviceId: String, state: PowerState, percentage: Double?) -> State {
        return State(state: .off, percentage: nil)
    }
    
    private func performRequest(path: apiPath, method: httpMethod, completionHandler: @escaping (Result<Data, RequestError>) -> Void) {
        let url = self.baseUrl.appendingPathComponent(path.rawValue)
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.setValue("Bearer \(self.accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { data, _, error in
            if error == nil {
                if let data = data {
                    completionHandler(.success(data))
                }
            } else {
                completionHandler(.failure(.other))
            }
        }
        
        task.resume()
    }
}
