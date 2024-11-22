//
//  OnlineCommunication.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 19/11/24.
//

import Foundation
import FirebaseDatabase

class OnlineCommunication {
  let joiningCode: String
  let isHost: Bool
  init(joiningCode: String, isHost: Bool) {
    self.joiningCode = joiningCode
    self.isHost = isHost
  }
  
  private lazy var databasePath: DatabaseReference? = {
    // 2
    let ref = Database.database()
      .reference()
      .child(joiningCode)
    return ref
  }()
  
  func writeData() {
    databasePath?.setValue("HelloWorld")
  }
}
