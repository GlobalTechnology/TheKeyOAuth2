//
//  TheKeyOAuth2Client+PasswordGrant.swift
//  TheKeyOAuth2
//
//  Created by Ryan Carlson on 12/27/17.
//  Copyright © 2017 TheKey. All rights reserved.
//

import Foundation

public extension TheKeyOAuth2Client {
    public func passwordGrantLogin(for username: String, password: String) {
        if !isConfigured() {
            return
        }
        
        let request = buildAccessTokenRequest(for: username, password: password)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let usableData = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: usableData, options: .allowFragments) as? Dictionary<String, Any?> else {
                        return
                    }
                    
//                    self.guid = json["thekey_guid"] as? String
//                    self.username = json["thekey_username"] as? String
//                    self.accessToken = json["access_token"] as? String
                    
                } catch {
                    print(error)
                }
            }
            }.resume()
    }
    
    private func buildAccessTokenRequest(for username: String, password: String) -> URLRequest {
        var formURLString = "username=\(username)"
        
        formURLString = formURLString.appending("&password=\(password)")
        formURLString = formURLString.appending("&client_id=\(clientId!)")
        formURLString = formURLString.appending("&scope=fullticket extended")
        formURLString = formURLString.appending("&grant_type=password")
        
        var request = URLRequest(url: serverURL!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = formURLString.data(using: .utf8, allowLossyConversion: false)
        
        return request
    }
}
