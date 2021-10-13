//
//  AddParticipantView.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 24/09/21.
//

import SwiftUI

struct AddParticipantView: View {
  @Environment(\.presentationMode) var presentationMode
  @State private var participantExists = false
  @State private var userCode: String = ""
  @State private var userName: String = ""
  
  init() {
    UINavigationBar.appearance().barTintColor = .clear
    UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
  }
  
  var saveButton: some View {
    Button(action: {
      print("Salvar participante press")
    }, label: {
      Text("Adicionar")
        .font(.system(size: 17))
        .foregroundColor(Color.accentColor)
    })
    .disabled(!participantExists)
  }
  
  var section: some View {
    VStack(alignment: .center, spacing: 40) {
      UserCircle(size: .regular, name: userName)
      
      TextField("Código", text: $userCode)
        .font(.system(size: 18, weight: .regular))
        .multilineTextAlignment(.center)
    }
    .frame(maxWidth: .infinity)
    .padding(.top, 35)
  }
  
  var body: some View {
    NavigationView {
      VStack(alignment: .center) {
        section
        
        Divider()
          .padding(.top, 10)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
      .padding(.horizontal, 20)
      .navigationBarTitle("Novo participante", displayMode: .inline)
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
}

struct AddParticipantView_Previews: PreviewProvider {
  static var previews: some View {
    AddParticipantView()
  }
}
