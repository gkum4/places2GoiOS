//
//  PlaceCard.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 11/10/21.
//

import SwiftUI
import RealmSwift

struct PlaceCard: View {
  var data: PlaceData
  @State private var editPlaceModalIsPresented = false
  @State private var showingActionSheet = false
  @State private var deleteConfirmationDialogIsPresented = false
  let realm = try! Realm()
  
  var cardTop: some View {
    HStack {
      Text(data.emoji)
        .font(.system(size: 58))
      
      Spacer()
    }
    .padding(.horizontal, 10)
    .frame(
      minWidth: 0,
      maxWidth: .infinity,
      minHeight: 0,
      maxHeight: .infinity,
      alignment: .bottom
    )
  }
  
  var cardBottom: some View {
    VStack(alignment: .leading) {
      HStack {
        if data.done {
          Image(systemName: "checkmark.circle.fill")
            .font(.system(size: 10, weight: .regular))
            .foregroundColor(Color(UIColor.label))
        }
        if data.address != "" {
          Image(systemName: "mappin.and.ellipse")
            .font(.system(size: 10))
            .foregroundColor(Color(UIColor.label))
        }
        if data.comment != "" {
          Image(systemName: "text.bubble")
            .font(.system(size: 10))
            .foregroundColor(Color(UIColor.label))
        }
      }
      Text(data.name)
        .font(.system(size: 18))
        .lineLimit(1)
        .minimumScaleFactor(0.5)
        .padding(.top, 2)
    }
    .padding(10)
    .frame(
      minWidth: 0,
      maxWidth: .infinity,
      minHeight: 57,
      maxHeight: 57,
      alignment: .leading
    )
    .background(Color(UIColor.systemBackground))
    .cornerRadius(12.8, corners: [.bottomLeft, .bottomRight])
    .border(CardsColorOptionsManager.getColor(from: data.color), width: 1)
  }
  
  func checkPlace() {
    realm.objects(PlaceData.self).forEach { place in
      if place._id == data._id {
        try! realm.write {
          place.thaw()!.done = !place.done
        }
        
        updatePlacesCollectionViewList()
        return
      }
    }
  }
  
  func openEditModal() {
    editPlaceViewPlaceData = data
    realm.objects(GroupData.self).forEach { group in
      if group._id == data.groupId {
        editPlaceViewGroupData = group
        
        return
      }
    }
    
    editPlaceModalIsPresented.toggle()
  }
  
  func deletePlace() {
    realm.objects(GroupData.self).forEach { group in
      if group._id == data.groupId {
        group.places.forEach { place in
          if place._id == data._id {
            try! realm.write {
              for (index, item) in group.emojis.enumerated() {
                if item == place.emoji {
                  group.emojis.remove(at: index)
                  break
                }
              }
              
              realm.delete(place)
            }
            
            updatePlacesCollectionViewList()
            return
          }
        }
      }
    }
  }
  
  var body: some View {
    Menu(content: {
      Button(action: checkPlace, label: {
        Label(
          data.done ? "Desmarcar" : "Marcar",
          systemImage: data.done ? "multiply" : "checkmark"
        )
      })
      
      Button(action: openEditModal, label: {
        Label(
          "Editar",
          systemImage: "pencil"
        )
      })
      
      Button(
        role: .destructive,
        action: {
          deleteConfirmationDialogIsPresented.toggle()
        },
        label: {
          Label(
            "Excluir",
            systemImage: "trash"
          )
        }
      )
    }, label: {
      VStack(alignment: .leading) {
        cardTop
        
        cardBottom
      }
      .frame(
        minWidth: 100,
        idealWidth: 159,
        maxWidth: 159,
        minHeight: 150,
        idealHeight: 159,
        maxHeight: 159,
        alignment: .leading
      )
      .background(CardsColorOptionsManager.getColor(from: data.color))
      .cornerRadius(10, corners: [.allCorners])
    })
    .sheet(isPresented: $editPlaceModalIsPresented, content: {
      EditPlaceView()
    })
    .alert(isPresented: $deleteConfirmationDialogIsPresented) {
      Alert(
        title: Text("Tem certeza?"),
        message: Text("Não será possível recuperar o lugar depois."),
        primaryButton: .default(
          Text("Cancelar"),
          action: {}
        ),
        secondaryButton: .destructive(
          Text("Excluir"),
          action: deletePlace
        )
      )
    }
  }
}

struct PlaceCard_Previews: PreviewProvider {
  static var previews: some View {
    PlaceCard(data: PlaceData())
  }
}
