//
//  ColorOptions.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 23/09/21.
//

import SwiftUI

struct ColorOptions: View {
  @State var selectedOption: CardsColorOptions = .orange
  var onOptionChange: (_: CardsColorOptions) -> Void = {_ in ()}
  
  private func checkIfIsSelected(_ circleColor: CardsColorOptions) -> Bool {
    if circleColor == selectedOption {
      return true
    }
    
    return false
  }
  
  var body: some View {
    HStack() {
      ForEach(CardsColorOptionsManager.getAllColors(), id: \.self) { color in
        Button(action: {
          selectedOption = color
          onOptionChange(selectedOption)
        }, label: {
          Circle()
            .strokeBorder(Color.accentColor, lineWidth: checkIfIsSelected(color) ? 2 : 0)
            .background(Circle().fill(CardsColorOptionsManager.getColor(from: color)))
            .frame(width: 24, height: 24)
        })
      }
    }
  }
}
