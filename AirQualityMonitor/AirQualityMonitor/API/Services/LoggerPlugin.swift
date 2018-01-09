//
//  LoggerPlugin.swift
//  AirQualityMonitor
//
//  Created by Karol on 09.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import Foundation
import Result
import Moya

public final class LoggerPlugin: PluginType {
    fileprivate let loggerId = "Moya_Logger"
    fileprivate let dateFormatString = "dd/MM/yyyy HH:mm:ss"
    fileprivate let dateFormatter = DateFormatter()
    fileprivate let separator = ", "
    fileprivate let terminator = "\n"
    fileprivate let cURLTerminator = "\\\n"
    fileprivate let output: (_ separator: String, _ terminator: String, _ items: Any...) -> Void
    fileprivate let responseDataFormatter: ((Data) -> Data)?
    
    public let isVerbose: Bool
    public let cURL: Bool
    
    public init(verbose: Bool = true, cURL: Bool = true, output: @escaping (_ separator: String, _ terminator: String, _ items: Any...) -> Void = LoggerPlugin.reversedPrint, responseDataFormatter: ((Data) -> Data)? = nil) {
        self.cURL = cURL
        isVerbose = verbose
        self.output = output
        self.responseDataFormatter = responseDataFormatter
    }
    
    public func willSend(_ request: RequestType, target _: TargetType) {
        if let request = request as? CustomDebugStringConvertible, cURL {
            var out = ""
            out += "\n ====================cURL======================= \n"
            out += request.debugDescription
            out += " \n ====================end cURL======================= \n"
            output(separator, terminator, out)
        }
        outputItems(logNetworkRequest(request.request as URLRequest?))
    }
    
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        if case let .success(response) = result {
            outputItems(logNetworkResponse(response.response, data: response.data, target: target))
        } else {
            outputItems(logNetworkResponse(nil, data: nil, target: target))
        }
    }
    
    fileprivate func outputItems(_ items: [String]) {
        if isVerbose {
            items.forEach { output(separator, terminator, $0) }
        } else {
            output(separator, terminator, items)
        }
    }
}

private extension LoggerPlugin {
    
    var date: String {
        dateFormatter.dateFormat = dateFormatString
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: Date())
    }
    
    func format(_: String, date _: String, identifier: String, message: String) -> String {
        return "\(identifier): \n \(message)"
    }
    
    func logNetworkRequest(_ request: URLRequest?) -> [String] {
        
        var output = [String]()
        output += [" \n =====================HTTP Request====================== \n"]
        output += [format(loggerId, date: date, identifier: "Request", message: request?.description ?? "(invalid request)")]
        
        if let headers = request?.allHTTPHeaderFields {
            output += [format(loggerId, date: date, identifier: "Request Headers", message: headers.description)]
        }
        
        if let bodyStream = request?.httpBodyStream {
            output += [format(loggerId, date: date, identifier: "Request Body Stream", message: bodyStream.description)]
        }
        
        if let httpMethod = request?.httpMethod {
            output += [format(loggerId, date: date, identifier: "HTTP Request Method", message: httpMethod)]
        }
        
        if let body = request?.httpBody, let stringOutput = String(data: body, encoding: .utf8), isVerbose {
            output += [format(loggerId, date: date, identifier: "Request Body", message: stringOutput)]
        }
        
        return output
    }
    
    func logNetworkResponse(_ response: URLResponse?, data: Data?, target: TargetType) -> [String] {
        var output = [String]()
        output += ["\n"]
        output += [" =====================HTTP Response====================== "]
        output += ["\n"]
        guard let response = response else {
            output += [format(loggerId, date: date, identifier: "Response", message: "Received empty network response for \(target).")]
            return output
        }
        
        let statusCode = "\(response.description.matchingStrings(regex: "Status Code: \\d\\d\\d").flatMap { $0 }.joined(separator: "\n")) \n"
        let pagination = "\(response.description.matchingStrings(regex: "\"X-Pagination\\S{1,} = \\d{1,}").flatMap { $0 }.joined(separator: "\n")) \n"
        let header = statusCode + pagination
        output += [format(loggerId, date: date, identifier: "Response", message: header)]
        
        if let data = data, let stringData = String(data: responseDataFormatter?(data) ?? data, encoding: String.Encoding.utf8), isVerbose {
            output += [" =====================Data====================== "]
            output += ["\n"]
            output += [stringData]
        }
        
        return output
    }
}

extension LoggerPlugin {
    public static func reversedPrint(_ separator: String, terminator: String, items: Any...) -> Void {
        for item in items {
            print(item, separator: separator, terminator: terminator)
        }
    }
}

extension String {
    func matchingStrings(regex: String) -> [[String]] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
        let nsString = self as NSString
        let results = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
        return results.map { result in
            (0 ..< result.numberOfRanges).map { result.range(at: $0).location != NSNotFound
                ? nsString.substring(with: result.range(at: $0))
                : ""
            }
        }
    }
}
