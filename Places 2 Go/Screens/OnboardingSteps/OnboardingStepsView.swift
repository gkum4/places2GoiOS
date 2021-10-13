//
//  OnboardingSteps.swift
//  Places 2 Go
//
//  Created by Gustavo Kumasawa on 17/07/21.
//

import SwiftUI

struct StepTextData {
  var title: String
  var text: String
}

struct OnboardingStepsView: View {
  let stepsTextData = [
    StepTextData(title: "Planeje", text: "Sabendo quais lugares você já foi,\nfica mais fácil decidir qual será\no próximo!"),
    StepTextData(title: "Compartilhe", text: "Desde uma cafeteria até uma grande\nviagem, a experiência é muito melhor\nestando em boa companhia."),
    StepTextData(title: "Se encontre", text: "Com tantos lugares para ir, às vezes\nnos encontramos perdidos com\ntantas opções."),
  ]
  
  @State var step: Int = 1
  
  func getBackgroundColor() -> Color {
    switch step {
    case 1:
      return Color(.systemIndigo)
    case 2:
      return Color("brownColor")
    case 3:
      return Color(.systemOrange)
    default:
      return Color(.systemIndigo)
    }
  }
  
  var body: some View {
    getBackgroundColor()
      .animation(.linear)
      .ignoresSafeArea()
      .overlay(
        VStack(alignment: .center) {
          Steps(step: step)
          
          Spacer()
          
          Image("onboardingPlan")
            .frame(width: 320, height: 320)
            .padding(.bottom, 20)
          
          Spacer()
          
          Group {
            VStack {
              Text(stepsTextData[step-1].title)
                .font(getFontStyle("Title"))
              
              Spacer()
              
              Text(stepsTextData[step-1].text)
                .font(getFontStyle("Text"))
                .multilineTextAlignment(.center)
              
              
              Spacer()
              
              HStack(alignment: .center) {
                if step == 1 {
                  NavigationLink(
                    destination: YourNameView(),
                    label: {
                      Text("Pular")
                        .font(getFontStyle("Text"))
                    })
                } else {
                  Button(action: {
                    step -= 1
                  }, label: {
                    Text("Voltar")
                      .font(getFontStyle("Text"))
                  })
                }
                
                Spacer()
                
                if step != 3 {
                  Button(action: {
                      step += 1
                  }, label: {
                    Text("Próximo")
                      .font(.system(size: 14, weight: .bold))
                      .foregroundColor(Color(.systemPurple))
                  })
                } else {
                  NavigationLink(
                    destination: YourNameView(),
                    label: {
                      Text("Próximo")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(.systemPurple))
                    })
                }
              }
              .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 20, alignment: .trailing)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            .padding(34)
          }
          .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 278, alignment: .top)
          .background(Color(UIColor.systemBackground))
          .cornerRadius(10, corners: [.topLeft, .topRight])
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .background(getBackgroundColor().animation(.linear))
        .edgesIgnoringSafeArea(.bottom)
      )
      .navigationBarHidden(true)
      .foregroundColor(Color("baseBlackColor"))
  }
}

struct OnboardingStepsView_Previews: PreviewProvider {
  static var previews: some View {
    OnboardingStepsView()
  }
}
