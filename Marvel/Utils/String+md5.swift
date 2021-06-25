//
//  String+md5.swift
//  Marvel
//
//  Created by Alberto on 21/6/21.
//

import CryptoKit

func md5Hash(_ source: String) -> String {
    return Insecure.MD5.hash(data: source.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
}
