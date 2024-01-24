//
//  KeyChain.swift
//  LolStat_Ios
//
//  Created by 권희철 on 1/24/24.
//

import Foundation

class KeyChain{
    //create
    class func create(key: String, token : String){
        let query : NSDictionary = [
            kSecClass: kSecClassKey,
            kSecAttrLabel : key,
            kSecValueData:token.data(using: .utf8, allowLossyConversion: false)as Any
        ]
        SecItemDelete(query) //key 중복방지를 위해 비우고 생성
        
        let status = SecItemAdd(query, nil)
        assert(status == noErr, "failed to save token")
    }
    
    //read
    class func read(key: String) -> String?{
        let query: NSDictionary = [
            kSecClass:kSecClassKey,
            kSecAttrLabel: key,
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var dataTypeRef:AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)
        
        if status == errSecSuccess{
            if let retrievedData:Data = dataTypeRef as? Data{
                let value = String(data:retrievedData, encoding: String.Encoding.utf8)
                return value
            }else{
                return nil
            }
        }else{
            print("failed to loading, Status code = \(status)")
            return nil
        }
    }
    
    //Delete
    class func delete(key:String){
        let query:NSDictionary = [
            kSecClass:kSecClassKey,
            kSecAttrLabel:key
        ]
        let status = SecItemDelete(query)
        assert(status == noErr, "failed to delete the value, status code = \(status)")
    }
}
