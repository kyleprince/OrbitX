//
//  Orbit.swift
//  Orbit X
//
//  Created by Kyle Prince on 9/27/19.
//  Copyright © 2019 galaxxy. All rights reserved.
//

import Foundation

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* Class: Orbit
* Description: Isolated Encryption Class - Ported from C#
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
*
* ex. let orbit = Orbit(); Initializer builds the key
*      <object>.encryptMessage(message)
*      <object>.decryptMessage(message, orbit.privKey)
*
*  Create a new instance to get a new key
*  Encrypt & Decrypt had to be modified for Swift so they take
*  and return Strings as before, but XOR is done at Byte level
*
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
*
* Key_Store Methods
*
* keyStore() : store the key used by that instance and return
*              whole database of keys to write back
* call keyStoreIndex() immediately after to get the index
* keyStoreReturn() : return the specified key given the index
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

class Orbit {
    var privKey: Character
    
    init() {
        let signature = Int.random(in: 65 ..< 91)
        let unicodeScalar = UnicodeScalar(signature)
        privKey = Character(unicodeScalar!)
    }
    
    func encryptMessage(message: String) -> String {
        if message.isEmpty { return String() }
        
        var encMessage = [UInt8]()
        var encMessageReturn = ""
        let plainText = [UInt8](message.utf8)
        let key = [UInt8](privKey.utf8)
        let length = key.count
        
        // Encrypt Bytes
        for t in plainText.enumerated() {
            encMessage.append(t.element ^ key[t.offset % length])
        }
        
        // Convert bytes to Characters
        for e in encMessage {
            encMessageReturn.append(Character(UnicodeScalar(e)))
        }
        
        return encMessageReturn
    }

    func decryptMessage(encmessage: String, fKey: Character) -> String {
        if encmessage.count == 0 { return "" }
        
        // create byte array from string message
        let message = encmessage.utf8.map{ UInt8($0) }
        
        var decrypted = [UInt8]()
        let cypher = message
        let key = [UInt8](fKey.utf8)
        let length = key.count
        
        // decrypt bytes
        for c in cypher.enumerated() {
            decrypted.append(c.element ^ key[c.offset % length])
        }
        
        return String(bytes: decrypted, encoding: .utf8)!
    }
    
    func keyStore(keys: String) -> String{
        var database = keys
        database.append(privKey)
        return database
    }
    
    func keyStoreindex(keys: String) -> Int {
        var count = 0
        if (keys.count != 0) {
            count = keys.count - 1
        }
        return count
    }
    
    func keyStoreReturn(keys: String, pubKey: Int) -> Character {
        var i = 0
        var prKey : Character = "a"
        
        for k in keys {
            if (i == pubKey) {
                prKey = k
            }
            else {
                i += 1
            }
        }
        return prKey
    }
    
}
