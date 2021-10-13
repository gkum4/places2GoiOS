//
//  FontStyles.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 17/07/21.
//

import SwiftUI

public func getFontStyle(_ name: String) -> Font {
  switch name {
  case "Big Title":
    return .system(size: 36, weight: .bold)
  case "Title":
    return .system(size: 24, weight: .semibold)
  case "Text":
    return .system(size: 14, weight: .regular)
  default:
    return .body
  }
}
