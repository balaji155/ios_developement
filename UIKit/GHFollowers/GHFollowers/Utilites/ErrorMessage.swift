//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by balaji.papisetty on 20/08/25.
//

import Foundation

enum GFError: String, Error {
    case noInternetConnection = "Please check your internet connection."
    case invalidResponse = "Invalid response.Please try again"
    case invalidData = "Invalid response from server.Please try again"
    case invalidUserName   = "User name causing invalid Url please try again with another username"
}
