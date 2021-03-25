//
//  Structures.swift
//  SmartThingsAPI
//
//  Created by H. Kamran on 3/25/21.
//

import Foundation

// MARK: - Structs

public struct Device {
    let id: String
    let name: String
    let capabilities: [String]
}

public struct State {
    let state: PowerState
    let percentage: Double?
}

// MARK: - Enums

public enum PowerState {
    case on
    case off
    case toggle
}

public enum RequestError: Error {
    case badUrl
    case badJson
    case other
}

// MARK: - Internal Enums

internal enum apiPath: String {
    case devices = "/devices"
}

internal enum httpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}
