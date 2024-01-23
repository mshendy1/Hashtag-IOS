//
//  UserData.swift
//  HashTag
//
//  Created by Mohamed Shendy on 07/02/2023.
//

import Foundation

struct UserData: Decodable {
    
    static var shared = UserData()
    private init() {}
    
    var userDetails: UserDetails? {
        mutating get {fetchUser()}
        set {}
    }

    var token: String? {
        get { return UserDefaults.standard.string(forKey: "token") }
        set {
            newValue == nil ? UserDefaults.standard.removeObject(forKey: "token") : UserDefaults.standard.set(newValue, forKey: "token")
        }
    }
    var deviceId: String? {
        get { return UserDefaults.standard.string(forKey: "UUID") }
        set {
            newValue == nil ? UserDefaults.standard.removeObject(forKey: "UUID") : UserDefaults.standard.set(newValue, forKey: "UUID")
        }
    }
   
    
    private mutating func fetchUser() -> UserDetails? {
        guard let user = UserDefaults.standard.data(forKey: "userDetails") else { return nil }
        do {
            let userDetails = try JSONDecoder().decode(UserDetails.self, from: user)
            return userDetails
        }catch{
            print("hey check me out!!")
            print(error)
            return nil
        }
    }
   
   
    func saveUser(from data: Data) {
        UserDefaults.standard.set(data, forKey: "userDetails")
    }
    
    
   
    
    static func isLoggedIn()->Bool{
        // if there is userDetails >> this mean user is login
        guard (UserDefaults.standard.object(forKey: "userDetails") as? Data) != nil  else { return false }
        return true
    }
    
    static func userLoggedOut(){
        self.shared.token = nil
        UserDefaults.standard.removeObject(forKey: "userDetails")
       
    }
    
}
