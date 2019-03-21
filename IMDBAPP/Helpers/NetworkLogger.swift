//
//  NetworkLogger.swift
//  IMDBAPP
//
//  Created by MACBOOK PRO on 17/02/2019.
//  Copyright © 2019 MACBOOK PRO. All rights reserved.
//

import Foundation

class NetworkLogger {
    static func logRequest(request: URLRequest){
        
        let urlString = request.url?.absoluteString ?? ""
        let components = NSURLComponents(string: urlString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod!)": ""
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        let host = "\(components?.host ?? "")"
        
        var requestLog = "\n---------- OUT ---------->\n"
        requestLog += "\(urlString)"
        requestLog += "\n\n"
        requestLog += "\(method) \(path)?\(query) HTTP/1.1\n"
        requestLog += "Host: \(host)\n"
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            requestLog += "\(key): \(value)\n"
        }
        if let body = request.httpBody{
            requestLog += "\n\(NSString(data: body, encoding: String.Encoding.utf8.rawValue)!)\n"
        }
        
        requestLog += "\n------------------------->\n";
        print(requestLog)
    }
    
    static func logResponse(data: Data?, response: HTTPURLResponse?, error: Error?){
        
        let urlString = response?.url?.absoluteString
        let components = NSURLComponents(string: urlString ?? "")
        
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        
        var responseLog = "\n<---------- IN ----------\n"
        if let urlString = urlString {
            responseLog += "\(urlString)"
            responseLog += "\n\n"
        }
        
        if let statusCode =  response?.statusCode{
            responseLog += "HTTP \(statusCode) \(path)?\(query)\n"
        }
        if let host = components?.host{
            responseLog += "Host: \(host)\n"
        }
        for (key,value) in response?.allHeaderFields ?? [:] {
            responseLog += "\(key): \(value)\n"
        }
        if let body = data{
            responseLog += "\n\(NSString(data: body, encoding: String.Encoding.utf8.rawValue)!)\n"
        }
        if error != nil{
            responseLog += "\nError: \(error!.localizedDescription)\n"
        }
        
        responseLog += "<------------------------\n";
        print(responseLog)
    }
}
