//
//  Crypto.swift
//  FormCycle
//
//  Created by Valle, Cody J on 3/3/16.
//  Copyright © 2016 Merrill Lines. All rights reserved.
//

import Foundation
import CryptoSwift

extension String {

  func aesEncrypt(key: String, iv: String) throws -> String{
    let data = self.dataUsingEncoding(NSUTF8StringEncoding)
    let enc = try AES(key: key, iv: iv, blockMode:.CBC).encrypt(data!.arrayOfBytes(), padding: PKCS7())
    let encData = NSData(bytes: enc, length: Int(enc.count))
    let base64String: String = encData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0));
    let result = String(base64String)
    return result
  }

  func aesDecrypt(key: String, iv: String) throws -> String {
    let data = NSData(base64EncodedString: self, options: NSDataBase64DecodingOptions(rawValue: 0))
    let dec = try AES(key: key, iv: iv, blockMode:.CBC).decrypt(data!.arrayOfBytes(), padding: PKCS7())
    let decData = NSData(bytes: dec, length: Int(dec.count))
    let result = NSString(data: decData, encoding: NSUTF8StringEncoding)
    return String(result!)
  }
}

class Crypto
{
  // Encryption stuffs /* THESE SHOULD NOT BE HARDOCDED LIKE THIS*/
  private static var key = "bbC2H19lkVbQDfakxcrtNMQdd0FloLyw" // length == 32
  private static var iv = "gqLOHUioQ0QjhuvI" // length == 16

  internal static func encrypt(str: String) -> String
  {
		return try! str.aesEncrypt(self.key, iv: self.iv)
  }

  internal static func decrypt(str: String) -> String
  {
    return try! str.aesDecrypt(self.key, iv: self.iv)
  }

}
