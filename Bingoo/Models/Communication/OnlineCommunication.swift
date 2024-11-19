//
//  OnlineCommunication.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 19/11/24.
//

import Foundation
import FirebaseDatabase

class OnlineCommunication {
  private lazy var databasePath: DatabaseReference? = {
    // 2
    let ref = Database.database()
      .reference()
      .child("ABCD")
    return ref
  }()
  
  func writeData() {
    databasePath?.setValue("HelloWorld")
  }
}
