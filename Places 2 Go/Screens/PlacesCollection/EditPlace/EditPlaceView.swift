//
//  EditPlaceView.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 12/10/21.
//

import SwiftUI
import RealmSwift

var editPlaceViewGroupData = GroupData()
var editPlaceViewPlaceData = PlaceData()

struct EditPlaceView: View {
  @Environment(\.presentationMode) var presentationMode
  @State var emojiField = editPlaceViewPlaceData.emoji
  @State var nameField: String = editPlaceViewPlaceData.name
  @State var colorField: CardsColorOptions = editPlaceViewPlaceData.color
  @State var addressField: String = editPlaceViewPlaceData.address
  @State var commentField: String = editPlaceViewPlaceData.comment
  @State var deleteConfirmationDialogIsPresented = false
  @State var scrollViewProxy: ScrollViewProxy!
  @State var commentFieldHeight: CGFloat!
  
  let realm = try! Realm()
  
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
        .font(.system(size: 18, weight: .regular))
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
          .font(.system(size: 18))
          .id("commentField")
      }
    }
  }
  
  var excludePlaceButton: some View {
    Group {
      Button(action: {
        deleteConfirmationDialogIsPresented.toggle()
      }, label: {
        Text("Excluir Lugar")
          .font(.system(size: 17, weight: .regular))
          .foregroundColor(.red)
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
              action: {
                realm.objects(GroupData.self).forEach { group in
                  if group._id == editPlaceViewGroupData._id {
                    group.places.forEach { place in
                      if place._id == editPlaceViewPlaceData._id {
                        try! realm.write {
                          realm.delete(place)
                        }
                        
                        return
                      }
                    }
                  }
                }
                
                editPlaceViewGroupData = GroupData()
                editPlaceViewPlaceData = PlaceData()
                updatePlacesCollectionViewList()
                presentationMode.wrappedValue.dismiss()
              }
            )
          )
        }
    }
    .frame(maxWidth: .infinity, alignment: .center)
  }
  
  var saveButton: some View {
    Button(action: {
      realm.objects(GroupData.self).forEach { group in
        if group._id == editPlaceViewGroupData._id {
          group.places.forEach { place in
            if place._id == editPlaceViewPlaceData._id {
              try! realm.write {
                for (index, item) in group.emojis.enumerated() {
                  if item == place.emoji {
                    group.emojis[index] = emojiField
                  }
                }
                  
                place.name = nameField
                place.emoji = emojiField
                place.color = colorField
                place.comment = commentField
                place.address = addressField
              }
              
              return
            }
          }
        }
      }
      
      editPlaceViewGroupData = GroupData()
      editPlaceViewPlaceData = PlaceData()
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

struct EditPlaceView_Previews: PreviewProvider {
  static var previews: some View {
    EditPlaceView()
  }
}
