//
//  UserModel.swift
//  SwiftDataExample
//
//  Created by Sachin Patoliya on 13/04/24.
//

import Foundation
import SwiftData

@Model
final class UserModel{
    var id: UUID
    var name: String
    @Attribute(.unique) var email: String
    @Attribute(.unique) var phone: String
    
    init(name: String, email: String, phone: String) {
        self.id = UUID()
        self.name = name
        self.email = email
        self.phone = phone
    }
}
