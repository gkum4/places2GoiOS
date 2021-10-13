//
//  Steps.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 17/07/21.
//

import SwiftUI

struct Steps: View {
  var step: Int
  
  var body: some View {
    HStack(alignment: .center) {
      Circle()
        .frame(width: 10, height: 10)
        .foregroundColor(step == 1 ? Color(.systemPurple) : Color("baseWhiteColor"))
      Spacer()
      Circle()
        .frame(width: 10, height: 10)
        .foregroundColor(step == 2 ? Color(.systemPurple) : Color("baseWhiteColor"))
      Spacer()
      Circle()
        .frame(width: 10, height: 10)
        .foregroundColor(step == 3 ? Color(.systemPurple) : Color("baseWhiteColor"))
      
    }
    .frame(width: 52, height: 10)
  }
}

struct Steps_Previews: PreviewProvider {
  static var previews: some View {
    Steps(step: 1)
  }
}
