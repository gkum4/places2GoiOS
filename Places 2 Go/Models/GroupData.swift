//
//  GroupData.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 24/09/21.
//

import RealmSwift

class GroupData: Object, Identifiable {
  @objc dynamic var _id = UUID()
  @objc dynamic var name: String = ""
  var emojis = List<String>()
  @objc dynamic var color: CardsColorOptions = .orange
  //  var participants = List<ParticipantData>()
  var places = List<PlaceData>()
  
  override static func primaryKey() -> String? {
    return "_id"
  }
}

func copyGroupData(group: GroupData) -> GroupData {
  let newGroup = GroupData()
  newGroup._id = group._id
  newGroup.name = group.name
  newGroup.emojis = group.emojis
  newGroup.color = group.color
  newGroup.places = group.places
  
  return newGroup
}
