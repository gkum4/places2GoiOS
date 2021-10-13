//
//  NewGroupView.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 11/10/21.
//

import SwiftUI
import RealmSwift

struct NewGroupView: View {
  @Environment(\.presentationMode) var presentationMode
  @State var groupNameField: String = ""
  @State var addParticipantSheetIsPresented = false
  @State var selectedColorField: CardsColorOptions = .orange
  @State var participantsField: [ParticipantData] = []
  
  let realm = try! Realm()
  
  init() {
    UINavigationBar.appearance().barTintColor = .clear
    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
  }
  
  var firstSection: some View {
    VStack(spacing: 35) {
      TextField(groupNameField != "" ? groupNameField : "Novo Grupo", text: $groupNameField)
        .font(.system(size: 24, weight: .bold))
        .multilineTextAlignment(.center)
        .disableAutocorrection(true)
      
      ColorOptions(
        selectedOption: selectedColorField,
        onOptionChange: { newColor in
          selectedColorField = newColor
        }
      )
    }
    .padding(.top, 50)
  }
  
  var secondSection: some View {
    VStack {
      HStack {
        Text("Participantes")
          .font(.system(size: 12, weight: .regular))
        
        Spacer()
        
        Button(action: {
          addParticipantSheetIsPresented.toggle()
        }, label: {
          Image(systemName: "plus.circle.fill")
            .font(.system(size: 18, weight: .regular))
            .foregroundColor(.accentColor)
        })
      }
      .padding(.bottom, 5)
      
      HStack {
        ForEach(participantsField, id: \._id) { participant in
          UserCircle(size: .small, name: participant.name)
        }
        
        Spacer()
      }
    }
  }
  
  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        firstSection
        
        Divider()
          .padding(.top, 35)
          .padding(.bottom, 5)
        
        secondSection
        
        Spacer()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
      .padding(.horizontal, 20)
      .padding(.bottom, 20)
      .navigationBarTitle(groupNameField != "" ? groupNameField : "Novo Grupo", displayMode: .inline)
      .navigationBarBackButtonHidden(true)
      .navigationBarItems(
        leading: Button(action: {
          presentationMode.wrappedValue.dismiss()
        }, label: {
          Text("Cancelar")
            .font(.system(size: 17))
            .foregroundColor(Color.accentColor)
        }),
        trailing: Button(action: {
          print("Salvar grupo press")
          
          let newGroup = GroupData()
          newGroup.name = groupNameField
          newGroup.color = selectedColorField
          
          try! realm.write {
            realm.add(newGroup)
          }
          
          updateMainViewList()
          
          presentationMode.wrappedValue.dismiss()
        }, label: {
          Text("Salvar")
            .font(.system(size: 17))
            .foregroundColor(Color.accentColor)
        })
        .disabled(groupNameField == "")
      )
    }
    .onTapGesture {
      self.hideKeyboard()
    }
    .sheet(isPresented: $addParticipantSheetIsPresented, content: {
      AddParticipantView()
    })
  }
}

struct NewGroupView_Previews: PreviewProvider {
  static var previews: some View {
    NewGroupView()
  }
}
