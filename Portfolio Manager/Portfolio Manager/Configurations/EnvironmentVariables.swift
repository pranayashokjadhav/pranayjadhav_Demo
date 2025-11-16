//
//  EnvironmentVariables.swift
//  Portfolio Manager
//
//  Created by Pranay Jadhav on 15/11/25.
//
import Foundation

struct EnvironmentVariables {
    static let baseURL: String = (Bundle.main.object(forInfoDictionaryKey: "baseURL") as? String) ?? ""
}
