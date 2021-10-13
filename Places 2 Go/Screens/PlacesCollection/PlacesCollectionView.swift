//
//  PlacesCollectionView.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 11/10/21.
//

import SwiftUI
import RealmSwift

var updatePlacesCollectionViewList: () -> Void = {}

struct PlacesCollectionView: View {
  var data: GroupData = GroupData()
  @State var list: [[PlaceData]] = []
  @State var addPlaceModalIsPresented = false
  
  func updatePlacesList() {
    let realm = try! Realm()
    
    var arr: [PlaceData] = []
    
    realm.objects(GroupData.self).forEach { group in
      if group._id == data._id {
        group.places.forEach { place in
          arr.append(copyPlaceData(place: place))
        }
      }
    }
    
    list = organizeList(placesList: arr)
  }
  
  func organizeList(placesList: [PlaceData]) -> [[PlaceData]] {
    var newList: [[PlaceData]] = []
    
    for i in 0..<placesList.count {
      if i%2 == 0 {
        if i+1 < placesList.count {
          newList.append([placesList[i], placesList[i+1]])
        } else {
          newList.append([placesList[i]])
        }
      }
    }
    
    return newList
  }
  
  var body: some View {
    ScrollView {
      VStack(spacing: 20) {
        ForEach(list, id: \.self) { row in
          HStack(spacing: 20) {
            ForEach(row, id: \.self) { place in
              PlaceCard(data: place)
            }
            if row.count == 1 {
              PlaceCard(data: PlaceData())
                .disabled(true)
                .opacity(0)
            }
          }
          .frame(maxWidth: .infinity, alignment: .center)
        }
      }
      .padding(.top, 15)
      .padding(.horizontal, 20)
      .navigationBarTitle(data.name)
      .navigationBarItems(
        trailing: Button(action: {
          newPlaceViewGroupData = data
          addPlaceModalIsPresented.toggle()
        }, label: {
          Image(systemName: "plus")
            .font(.system(size: 22, weight: .regular))
            .foregroundColor(Color.accentColor)
        })
      )
      .sheet(isPresented: $addPlaceModalIsPresented, content: {
        NewPlaceView()
      })
      .onAppear {
        updatePlacesList()
        updatePlacesCollectionViewList = updatePlacesList
      }
    }
  }
}

struct PlacesCollectionView_Previews: PreviewProvider {
  static var previews: some View {
    PlacesCollectionView()
  }
}
