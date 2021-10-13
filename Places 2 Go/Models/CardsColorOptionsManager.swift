//
//  CardsColorOptions.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 23/09/21.
//

import SwiftUI
import RealmSwift

class CardsColorOptionsManager {
  static func getAllColors() -> [CardsColorOptions] {
    return [
      .orange,
      .indigo,
      .brown,
      .green,
    ]
  }
  
  static func getColor(from color: CardsColorOptions) -> Color {
    switch color {
    case .brown:
      return Color("brownColor")
    case .green:
      return Color("greenColor")
    case .orange:
      return Color("orangeColor")
    case .indigo:
      return Color("indigoColor")
    }
  }
  
  static func getColorOption(from color: Color) -> CardsColorOptions {
    switch color {
    case Color("brownColor"):
      return .brown
    case Color("greenColor"):
      return .green
    case Color("orangeColor"):
      return .orange
    case Color("indigoColor"):
      return .indigo
    default:
      return .brown
    }
  }
}

@objc enum CardsColorOptions: Int, RealmEnum {
  case brown
  case green
  case orange
  case indigo
}


