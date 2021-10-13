//
//  YourNameView.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 17/07/21.
//

import SwiftUI
import RealmSwift

struct YourNameView: View {
  @State var userName = ""
  @State var navigationLinkIsPresented = false
  
  func onUserNameTextChange(_ value: String) {
    var arr = Array(value)
    
    for i in 0..<arr.count {
      if arr[i] == " " {
        if i != arr.count-1 && arr[i+1] == " " {
          arr.remove(at: i)
          userName = String(arr)
          return
        }
      }
    }
  }
  
  func onSubmit() {
    let realm = try! Realm()
    
    let user = ParticipantData()
    user.name = userName
    
    try! realm.write {
      realm.add(user)
    }
    
    let defaults = UserDefaults.standard
    defaults.set("true", forKey: DefaultKeys.oboardingCompleted)
    
    navigationLinkIsPresented = true
  }
  
  var body: some View {
    Group {
      VStack {
        Text("Qual seu nome?")
          .font(getFontStyle("Big Title"))
          .padding(.bottom, 5)
        
        Text("Pode escolher um apelido se preferir")
          .font(.system(size: 14))
          .foregroundColor(Color(.systemGray6))
        
        Spacer()
        
        UserCircle(size: .big, name: userName)
          .padding(.bottom, 30)
        
        TextField("Digite seu nome", text: $userName)
          .textFieldStyle(PlainTextFieldStyle())
          .font(getFontStyle("Title"))
          .foregroundColor(Color("baseBlackColor"))
          .multilineTextAlignment(.center)
          .onChange(of: userName, perform: { value in
            onUserNameTextChange(value)
          })
          .disableAutocorrection(true)
        
        Spacer()
        
        NavigationLink(
          destination: MainView(),
          isActive: $navigationLinkIsPresented,
          label: {
            Text("Pronto!")
              .foregroundColor(Color("baseWhiteColor"))
              .frame(width: 95, height: 37, alignment: .center)
              .background(userName == "" ? Color(.systemGray3) : Color(.systemPurple))
              .cornerRadius(10)
              .onTapGesture {
                onSubmit()
              }
          }
        )
        .disabled(userName == "")
      }
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
      .padding(.vertical, 30)
      .foregroundColor(Color("baseBlackColor"))
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
    .navigationBarHidden(true)
    .onTapGesture {
      self.hideKeyboard()
    }
  }
}

struct YourNameView_Previews: PreviewProvider {
  static var previews: some View {
    YourNameView()
  }
}
