//
//  GroupCard.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 04/08/21.
//

import SwiftUI

struct GroupCard: View {
  var props: GroupData
  @State var emojisText: String = ""
  @State private var editGroupModalIsPresented = false
  
  private func getUnusedRandomNumber(usedNumbers: [Int], in range: Range<Int>) -> Int {
    var result = Int.random(in: range)
    
    if range.count <= usedNumbers.count {
      return result
    }
    
    while usedNumbers.contains(result) {
      result = Int.random(in: range)
    }
    
    return result
  }
  
  private func organizeEmojisText() {
    if props.emojis.isEmpty {
      return
    }
    
    emojisText = ""
    
    if props.emojis.count == 1 {
      for _ in 1...4 {
        emojisText += props.emojis[0]
      }
      
      emojisText += "\n" + emojisText
      
      return
    }
    
    var usedPositions: [Int] = []
    
    for i in 1...8 {
      if i == 5 {
        emojisText += "\n"
      }
      
      let randomPosition = getUnusedRandomNumber(
        usedNumbers: usedPositions,
        in: 0..<props.emojis.count
      )
      
      emojisText += props.emojis[randomPosition]
      
      usedPositions.append(randomPosition)
    }
  }
  
  var elements: some View {
    Group {
      Group {
        Text(emojisText)
          .font(.system(size: 36, weight: .bold))
          .tracking(30)
          .lineLimit(2)
          .lineSpacing(21)
          .onAppear {
            organizeEmojisText()
          }
          .padding(.top, 1)
          .multilineTextAlignment(.center)
      }
    }
    .fixedSize()
    .frame(
      minWidth: 0,
      maxWidth: .infinity,
      minHeight: 0,
      maxHeight: .infinity,
      alignment: .center
    )
    
  }
  
  var cardBottom: some View {
    Button(action: {
      groupEditViewData = props
      editGroupModalIsPresented.toggle()
    }, label: {
      HStack(alignment: .center) {
        Group {
          Text(props.name)
            .font(.system(size: 18, weight: .bold))
            .lineLimit(1)
            .minimumScaleFactor(0.5)
          
          Spacer()
          
          Image(systemName: "ellipsis")
            .font(.system(size: 18, weight: .regular))
        }
        .padding(.horizontal, 15)
      }
      .frame(
        minWidth: 0,
        maxWidth: .infinity,
        minHeight: 40,
        maxHeight: 40,
        alignment: .center
      )
      .background(Color(UIColor.systemBackground))
      .cornerRadius(12.8, corners: [.bottomLeft, .bottomRight])
      .border(CardsColorOptionsManager.getColor(from: props.color), width: 1)
    })
  }
  
  var body: some View {
    NavigationLink(destination: PlacesCollectionView(
      data: props
    ), label: {
      VStack(alignment: .leading) {
        elements
        
        cardBottom
      }
      .frame(
        minWidth: 300,
        idealWidth: 337,
        maxWidth: 337,
        minHeight: 150,
        idealHeight: 159,
        maxHeight: 159,
        alignment: .leading
      )
      .background(CardsColorOptionsManager.getColor(from: props.color))
      .cornerRadius(10, corners: [.allCorners])
      .sheet(isPresented: $editGroupModalIsPresented, content: {
        GroupEditView()
      })
    })
  }
}



struct GroupCard_Previews: PreviewProvider {
  static var previews: some View {
    GroupCard(props: GroupData())
  }
}
