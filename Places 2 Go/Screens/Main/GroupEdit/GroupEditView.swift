//
//  GroupEditView.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 23/09/21.
//

import SwiftUI
import RealmSwift

var groupEditViewData = GroupData()

func clearGroupEditViewData() {
  groupEditViewData = GroupData()
}

struct GroupEditView: View {
  @Environment(\.presentationMode) var presentationMode
  @State var groupNameField: String = groupEditViewData.name
  @State var addParticipantSheetIsPresented = false
  @State var selectedColorField: CardsColorOptions = groupEditViewData.color
  //  @State var participantsField: [ParticipantData] = Array(groupEditViewData.participants)
  @State var participantsField: [ParticipantData] = []
  @State var deleteConfirmationDialogIsPresented = false
  
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
  
  var excludeGroupButton: some View {
    Group {
      Button(action: {
        deleteConfirmationDialogIsPresented.toggle()
      }, label: {
        Text("Excluir Grupo")
          .font(.system(size: 17, weight: .regular))
          .foregroundColor(.red)
      })
        .alert(isPresented: $deleteConfirmationDialogIsPresented) {
          Alert(
            title: Text("Tem certeza?"),
            message: Text("Não será possível recuperar o grupo depois."),
            primaryButton: .default(
              Text("Cancelar"),
              action: {}
            ),
            secondaryButton: .destructive(
              Text("Excluir"),
              action: {
                realm.objects(GroupData.self).forEach { group in
                  if group._id == groupEditViewData._id {
                    try! realm.write {
                      realm.delete(group)
                      return
                    }
                  }
                }
                
                groupEditViewData = GroupData()
                updateMainViewList()
                presentationMode.wrappedValue.dismiss()
              }
            )
          )
        }
    }
    .frame(maxWidth: .infinity, alignment: .center)
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
        
        excludeGroupButton
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
      .padding(.horizontal, 20)
      .padding(.bottom, 20)
      .navigationBarTitle(groupNameField != "" ? groupNameField : "Nome", displayMode: .inline)
      .navigationBarBackButtonHidden(true)
      .navigationBarItems(
        leading: Button(action: {
          clearGroupEditViewData()
          presentationMode.wrappedValue.dismiss()
        }, label: {
          Text("Cancelar")
            .font(.system(size: 17))
            .foregroundColor(Color.accentColor)
        }),
        trailing: Button(action: {
          realm.objects(GroupData.self).forEach({ group in
            if group._id == groupEditViewData._id {
              try! realm.write {
                group.name = groupNameField
                
                group.color = selectedColorField
              }
              
              return
            }
          })
          
          clearGroupEditViewData()
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

struct GroupEditView_Previews: PreviewProvider {
  static var previews: some View {
    GroupEditView()
  }
}
