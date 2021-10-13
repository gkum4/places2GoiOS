//
//  WelcomeView.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 17/07/21.
//

import SwiftUI

struct WelcomeView: View {
  var body: some View {
    VStack(alignment: .center) {
      Image("logo")
      
      Spacer()
      
      Text("Bem vindo ao\nPlaces 2 Go")
        .font(.largeTitle)
        .multilineTextAlignment(.center)
      
      Spacer()
      
      NavigationLink(
        destination: OnboardingStepsView(),
        label: {
          Text("Começar")
            .foregroundColor(Color("baseWhiteColor"))
            .frame(width: 95, height: 37, alignment: .center)
            .background(Color(.systemPurple))
            .cornerRadius(10)
        }
      )
    }
    .padding(.vertical, 30)
    .navigationBarHidden(true)
  }
}

struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      WelcomeView()
    }
  }
}
