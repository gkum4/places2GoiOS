//
//  MainView.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 04/08/21.
//

import SwiftUI
import RealmSwift

var updateMainViewList: () -> Void = {}

struct MainView: View {
  @State private var addGroupModalIsPresented = false
  @State var groupList: [GroupData] = []
  
  func updateGroupList() {
    let realm = try! Realm()
    
    var arr: [GroupData] = []
    
    realm.objects(GroupData.self).forEach { group in
      arr.append(copyGroupData(group: group))
    }
    
    groupList = arr
  }
  
  var body: some View {
    ScrollView {
      VStack(spacing: 20) {
        ForEach(groupList) { group in
          GroupCard(props: group)
        }
      }
      .padding(.top, 15)
    }
    .navigationBarTitle("Places 2 Go")
    .navigationBarBackButtonHidden(true)
    .navigationBarItems(
      leading: NavigationLink(destination: UserConfigView(), label: {
        Image(systemName: "person.crop.circle.fill")
          .font(.system(size: 22, weight: .regular))
          .foregroundColor(Color.accentColor)
      }),
      trailing: Button(action: {
        addGroupModalIsPresented.toggle()
      }, label: {
        Text("Adicionar Grupo")
          .font(.system(size: 17, weight: .regular))
          .foregroundColor(Color.accentColor)
      })
    )
    .onAppear {
      updateGroupList()
      
      updateMainViewList = updateGroupList
    }
    .sheet(isPresented: $addGroupModalIsPresented, content: {
      NewGroupView()
    })
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
