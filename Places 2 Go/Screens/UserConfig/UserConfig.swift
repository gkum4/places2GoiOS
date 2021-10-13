//
//  UserConfig.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 24/09/21.
//

import SwiftUI
import RealmSwift

struct UserConfigView: View {
  @State private var previousName: String = ""
  @State private var userName: String = ""
  @State private var userCode: String = ""
  
  let realm = try! Realm()
  
  var firstSection: some View {
    VStack(alignment: .center, spacing: 20) {
      UserCircle(size: .regular, name: userName)
      
      TextField("Seu nome", text: $userName)
        .font(.system(size: 24, weight: .regular))
        .multilineTextAlignment(.center)
    }
    .frame(maxWidth: .infinity)
  }
  
  var secondSection: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text("Código do usuário")
        .font(.system(size: 12, weight: .regular))
      
      HStack(alignment: .center) {
        Text(userCode)
          .font(.system(size: 18, weight: .regular))
        
        Spacer()
        
        Button(action: {
          let pasteboard = UIPasteboard.general
          pasteboard.string = userCode
        }, label: {
          Image(systemName: "doc.on.doc")
            .font(.system(size: 12, weight: .regular))
            .foregroundColor(Color("baseBlackColor"))
        })
      }
    }
  }
  
  var bottomInformation: some View {
    VStack(alignment: .center) {
      Text("Créditos pelas ilustrações:")
      Link("https://storyset.com/amico", destination: URL(string: "https://storyset.com/amico")!)
  
      Text("Places 2 Go\nv1.0")
        .multilineTextAlignment(.center)
        .padding(.vertical, 15)
    }
    .frame(maxWidth: .infinity)
    .foregroundColor(Color(UIColor.systemGray2))
  }
  
  func getData() {
    let userData = realm.objects(ParticipantData.self)[0]
    
    userName = userData.name
    previousName = userData.name
    userCode = userData._id.uuidString
  }
  
  func saveChanges() {
    try! realm.write {
      realm.objects(ParticipantData.self)[0].name = userName
    }
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      firstSection
      
      Divider()
        .padding(.vertical, 10)
      
      secondSection
      
      Divider()
        .padding(.vertical, 10)
      
      Spacer()
      
      bottomInformation
    }
    .onTapGesture {
      self.hideKeyboard()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    .navigationBarItems(
      trailing: Button(
        action: {
          saveChanges()
          
          getData()
        }, label: {
          Text("Salvar")
            .font(.system(size: 17))
            .foregroundColor(Color.accentColor)
        }
      )
        .disabled(userName == previousName)
      )
    .padding(.horizontal, 20)
    .onAppear {
      getData()
    }
  }
}

struct UserConfigView_Previews: PreviewProvider {
  static var previews: some View {
    UserConfigView()
  }
}
