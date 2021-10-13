//
//  NewPlaceView.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 11/10/21.
//

import SwiftUI
import RealmSwift

var newPlaceViewGroupData = GroupData()

struct NewPlaceView: View {
  @Environment(\.presentationMode) var presentationMode
  @State var emojiField = String(
    UnicodeScalar(Array(0x1F300...0x1F3F0).randomElement()!)!
  )
  @State var nameField: String = ""
  @State var colorField: CardsColorOptions = .brown
  @State var addressField: String = ""
  @State var commentField: String = ""
  
  var firstSection: some View {
    VStack(spacing: 35) {
      TextField("", text: $emojiField)
        .font(.system(size: 96, weight: .bold))
        .multilineTextAlignment(.center)
        .disableAutocorrection(true)
        .onChange(of: emojiField, perform: { text in
          if text.count > 1 {
            emojiField = String(describing: text.first!)
          }
        })
      
      TextField(nameField != "" ? nameField : "Novo Lugar", text: $nameField)
        .font(.system(size: 24, weight: .bold))
        .multilineTextAlignment(.center)
        .disableAutocorrection(true)
      
      ColorOptions(
        selectedOption: colorField,
        onOptionChange: { newColor in
          colorField = newColor
        }
      )
    }
    .padding(.top, 50)
  }
  
  var secondSection: some View {
    HStack {
      Image(systemName: "mappin.and.ellipse")
        .font(.system(size: 18))
        .foregroundColor(Color(UIColor.systemGray4))
        .padding(.trailing, 15)
      
      TextField("Endereço", text: $addressField)
        .disableAutocorrection(true)
    }
  }
  
  var thirdSection: some View {
    HStack(alignment: .top) {
      Image(systemName: "text.bubble")
        .font(.system(size: 18))
        .foregroundColor(Color(UIColor.systemGray4))
        .padding(.trailing, 15)
      
      ZStack {
        TextEditor(text: $commentField)
          .font(.system(size: 18))
        Text(commentField).opacity(0).padding(.all, 8)
      }
    }
  }
  
  var saveButton: some View {
    Button(action: {
      let realm = try! Realm()
      
      let newPlace = PlaceData()
      newPlace.groupId = newPlaceViewGroupData._id
      newPlace.name = nameField
      newPlace.emoji = emojiField
      newPlace.color = colorField
      newPlace.comment = commentField
      newPlace.address = addressField
      
      realm.objects(GroupData.self).forEach { group in
        if group._id == newPlaceViewGroupData._id {
          try! realm.write {
            group.emojis.append(newPlace.emoji)
            group.places.append(newPlace)
          }
          return
        }
      }
      
      newPlaceViewGroupData = GroupData()
      updatePlacesCollectionViewList()
      presentationMode.wrappedValue.dismiss()
    }, label: {
      Text("Salvar")
        .font(.system(size: 17))
        .foregroundColor(Color.accentColor)
    })
    .disabled(nameField == "" || emojiField == "")
  }
  
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .center) {
          firstSection
          
          Divider()
            .padding(.top, 35)
            .padding(.bottom, 10)
          
          secondSection
          
          Divider()
            .padding(.vertical, 10)
          
          thirdSection
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 20)
        .navigationBarTitle("Novo Lugar", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
          leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
          }, label: {
            Text("Cancelar")
              .font(.system(size: 17))
              .foregroundColor(Color.accentColor)
          }),
          trailing: saveButton
        )
      }
    }
    .onTapGesture {
      self.hideKeyboard()
    }
  }
}

struct NewPlaceView_Previews: PreviewProvider {
  static var previews: some View {
    NewPlaceView()
  }
}
