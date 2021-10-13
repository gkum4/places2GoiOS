//
//  UserCircle.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 17/07/21.
//

import SwiftUI

struct UserCircle: View {
  enum UserCircleSize {
    case big
    case regular
    case small
  }
  
  let size: UserCircleSize
  let name: String
  
  // name parameter must not have double spaces
  func getInitialsFrom(_ name: String) -> String {
    if name == "" {
      return ""
    }
    
    let arr = Array(name)
    
    if arr.count == 1 {
      return String(arr[0]).uppercased()
    }
    
    if arr.count == 2 && arr[1] == " " {
      return String(arr[0]).uppercased()
    }
    
    for i in 0..<arr.count {
      if arr[i] == " " && i != arr.count-1 {
        return String(arr[0]).uppercased()+String(arr[i+1]).uppercased()
      }
    }
    
    return String(arr[0]).uppercased()+String(arr[1])
  }
  
  var body: some View {
    switch size {
    case .big:
      Text(getInitialsFrom(name))
        .font(.system(size: 80, weight: .thin))
        .foregroundColor(Color(.systemPurple))
        .frame(width: 115, height: 115)
        .padding()
        .overlay(
          Circle()
            .stroke(Color(.systemPurple), lineWidth: 2)
        )
    case .regular:
      Text(getInitialsFrom(name))
        .font(.system(size: 50, weight: .thin))
        .foregroundColor(Color(.systemPurple))
        .frame(width: 71, height: 71)
        .padding()
        .overlay(
          Circle()
            .stroke(Color(.systemPurple), lineWidth: 2)
        )
    case .small:
      Text(getInitialsFrom(name))
        .font(.system(size: 28, weight: .thin))
        .foregroundColor(Color(.systemPurple))
        .frame(width: 40, height: 40)
        .padding()
        .overlay(
          Circle()
            .stroke(Color(.systemPurple), lineWidth: 1)
        )
    }
  }
}

struct UserCircle_Previews: PreviewProvider {
  static var previews: some View {
    UserCircle(size: .regular, name: "Gustavo")
  }
}
