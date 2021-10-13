//
//  ParticipantData.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 24/09/21.
//

import RealmSwift

class ParticipantData: Object, Identifiable {
  @objc dynamic var _id = UUID()
  @objc dynamic var name: String = ""
  override static func primaryKey() -> String? {
    return "_id"
  }
}
