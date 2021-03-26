import Foundation
import SmartThingsAPI
import SwiftyJSON

let accessToken = ""

let st_api = SmartThingsAPI(accessToken: accessToken)

st_api.getDevices { result in
    if case .success(let deviceList) = result {
        print(deviceList)
    } else {
        print("Nope")
    }
}

//func performRequest(path: apiPath, method: httpMethod, completionHandler: @escaping (Result<Data, RequestError>) -> Void) {
//    let url = URL(string: "https://api.smartthings.com/v1")!.appendingPathComponent(path.rawValue)
//
//    let session = URLSession.shared
//    var request = URLRequest(url: url)
//
//    request.httpMethod = method.rawValue
//    request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//
//    let task = session.dataTask(with: request) { data, _, error in
//        if error == nil {
//            if let data = data {
//                completionHandler(.success(data))
//            }
//        } else {
//            completionHandler(.failure(.unknownError))
//        }
//    }
//
//    task.resume()
//}
//
//enum RequestError: Error {
//    case badUrl
//    case badJson
//    case requestFailed
//    case unknownError
//}
//
//struct Device {
//    let id: String
//    let name: String
//    let capabilities: [String]
//}
//
//enum apiPath: String {
//    case devices = "/devices"
//}
//
//enum httpMethod: String {
//    case get = "GET"
//    case post = "POST"
//    case put = "PUT"
//}
//
//var devices = [Device]()
//performRequest(path: .devices, method: .get) { result in
//    if case .success(let responseData) = result {
//        do {
//            let json = try JSON(data: responseData)
//
////            print(json)
//
//            json["items"].forEach { _, device in
//                devices.append(Device(id: device["deviceId"].stringValue, name: device["label"].stringValue != "" ? device["label"].stringValue : device["name"].stringValue, capabilities: device["components"]["capabilities"].map { $1["id"].stringValue }))
//            }
//        } catch {
//            print("[JSON Error] \(error.localizedDescription)")
//        }
//    } else {
//        print("the hell?")
//    }
//}
//
//print(devices.prefix(5))
