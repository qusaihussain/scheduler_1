//
//  User.swift
//  Scheduler_1
//
//  Created by Ben Baker on 11/10/16.
//  Copyright © 2016 Ben Baker. All rights reserved.
//

import Foundation
import Firebase

struct User {
    
    let uid: String
    let email: String

    init(authData: FIRUser) {
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
}

