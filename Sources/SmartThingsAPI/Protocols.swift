//
//  File.swift
//
//
//  Created by H. Kamran on 3/25/21.
//

import Foundation

internal protocol API {
    var baseUrl: URL { get }
    var accessToken: String { get }

    func getDevices(completionHandler: @escaping ([Device]) -> Void)
    func getState(deviceId: String) -> State
    func setState(deviceId: String, state: PowerState, percentage: Double?) -> State

    // TODO: Figure out a way to have a internal function in a protocol
    // func performRequest(path: apiPath, method: httpMethod, completionHandler: @escaping (Result<[Any], RequestError>) -> Void)
}
