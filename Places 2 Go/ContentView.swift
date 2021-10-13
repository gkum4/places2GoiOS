//
//  ContentView.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 15/07/21.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      if let _ = UserDefaults.standard.string(forKey: DefaultKeys.oboardingCompleted) {
          MainView()
      } else {
        WelcomeView()
      }
    }
    .foregroundColor(Color(UIColor.label))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
