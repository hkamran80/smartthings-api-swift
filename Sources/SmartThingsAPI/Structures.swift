//
//  Structures.swift
//  SmartThingsAPI
//
//  Created by H. Kamran on 3/25/21.
//

import Foundation

// MARK: - Structs

public struct Device {
    public let id: String
    public let name: String
    public let capabilities: [String]
}

public struct State {
    public let state: PowerState
    public let percentage: Double?
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
    case requestFailed
    case unknownError
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
