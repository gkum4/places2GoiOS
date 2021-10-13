//
//  PlaceData.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 11/10/21.
//

import RealmSwift

class PlaceData: Object, Identifiable {
  @objc dynamic var _id = UUID()
  @objc dynamic var groupId = UUID()
  @objc dynamic var emoji: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var color: CardsColorOptions = .brown
  @objc dynamic var address: String = ""
  //  @objc dynamic var images:
  @objc dynamic var comment: String = ""
  @objc dynamic var done: Bool = false
  override static func primaryKey() -> String? {
    return "_id"
  }
}

func copyPlaceData(place: PlaceData) -> PlaceData {
  let newPlace = PlaceData()
  newPlace._id = place._id
  newPlace.groupId = place.groupId
  newPlace.emoji = place.emoji
  newPlace.name = place.name
  newPlace.color = place.color
  newPlace.address = place.address
  newPlace.comment = place.comment
  newPlace.done = place.done
  
  return newPlace
}
