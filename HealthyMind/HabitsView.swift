//
//  HabitsView.swift
//  HealthyMind
//
//  Created by Eva Herson on 02/01/2024.
//

import SwiftUI

struct HabitsView: View {
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("YOUR HABITS")
                    .font(.custom("Ubuntu-Medium", size: 25))
                    .foregroundColor(Color("font"))
                Spacer()
            }
            .padding()
            
            Button {
                
            } label: {
                
                Text("Drink Water")
                    .font(.custom("ChalkboardSE-Light", size: 25))
                    .foregroundColor(Color("background"))
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                Text("3")
                    .font(.custom("ChalkboardSE-Light", size: 25))
                    .foregroundColor(Color("background"))
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("font2"))
            .cornerRadius(10)
            .padding()
            
            Spacer()
        }
        .background(Color("background"))
    }
}

#Preview {
    HabitsView()
}
