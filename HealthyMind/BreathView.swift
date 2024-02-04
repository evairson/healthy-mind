//
//  BreathView.swift
//  HealthyMind
//
//  Created by Eva Herson on 30/01/2024.
//

import SwiftUI

struct BreathView: View {
    @State var pos : CGFloat = 1/4
    @State var duration : TimeInterval = 5
    @State var durationText : String = "5"
    @State var start = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        
                        TextField("", text: ($durationText))
                            .font(.custom("ChalkboardSE-Light", size: 35))
                            .foregroundColor(Color("font2"))
                            .disabled(true)
                            .frame(maxWidth: geo.size.width/8)
                            .offset( x : (duration >= 10) ? 10 : 20)
                            
                        Text("sec")
                            .font(.custom("ChalkboardSE-Light", size: 35))
                            .foregroundColor(Color("font2"))
                            .padding(.trailing)
                        
                        VStack{
                            Spacer()
                            Button{
                                addDuration(i: 1)
                            } label:{
                                
                                Image(systemName: "arrowtriangle.up.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color("font2"))
                            }
                            
                            Button{
                                addDuration(i: -1)
                            } label: {
                                Image(systemName: "arrowtriangle.down.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color("font2"))
                            }
                        }
                        .frame(maxHeight: geo.size.height/20)
                        
                        Spacer()
                    }
                    .padding(.bottom, start ? geo.size.height/10 : 0)
                    
                    if(!start){
                        Button{
                            start = true
                            pos = -1/4
                        } label: {
                            Text("START")
                                .font(.custom("ChalkboardSE-Light", size: 30))
                                .foregroundColor(Color("background"))
                                .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                                .background(Color("font2"))
                                .cornerRadius(10)
                                
                        }
                        .shadow(radius: 2)
                        .padding(.bottom)
                    }

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("background"))
                HStack{
                    Rectangle()
                        .fill(Color("font2")).opacity(0.6)
                        .frame(width: 10, height: 3*geo.size.height/5)
                        .padding(.bottom, geo.size.height/7)
                }
                HStack{
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(Color("font2"))
                            
                        Image("taskImage1")
                            .resizable()
                            .scaledToFit()
                            .padding()
                    }
                        .frame(width: 2*geo.size.width/7)
                        .offset(x: 0, y: pos*geo.size.height)
                        .animation(start ? .easeInOut(duration: duration).repeatForever() : .easeInOut(duration: 0), value: pos)
                        .onAppear(){
                            start = true
                            pos = -1/4
                        }
                       /* .onChange(of: start){
                            
                        } */
                    Spacer()
                }
                .padding(.bottom, geo.size.height/7)
                
            }
            
        }
    }
    
    func addDuration(i : TimeInterval){
        if(duration + i > 0 && duration + i < 100){
            duration += i
            durationText = String(Int(duration))
            start = false
            pos = 1/4
        }
    }
    
}

#Preview {
    BreathView()
}
