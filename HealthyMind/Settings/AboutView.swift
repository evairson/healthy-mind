//
//  AboutView.swift
//  HealthyMind
//
//  Created by Eva Herson on 05/02/2024.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                Group{
                    HStack{
                        Spacer()
                        Text("About HealthyMind")
                            .bold()
                        Spacer()
                    }
                    
                         
                    Text("HealthyMind is a comprehensive mental wellness application designed to support and enhance your emotional well-being through a variety of interactive features. Our application is divided into four key sections, each focusing on different aspects of mental health management:")

                    Text("1. Reflective Journaling")
                        .bold()

                         Text("Our first section is dedicated to reflective journaling. Users can fill out pre-created or self-designed forms as often as they wish. These forms are designed to help users articulate their feelings and employ techniques to improve their mental state, such as listing three things they are grateful for. This feature aims to encourage self-expression and mindfulness.")
                           
                    Text("2. Habit Tracking")
                        .bold()

                    Text("The second section focuses on tracking and fostering healthy habits. Users can add their desired habits along with a target frequency (the number of times the habit should be performed daily). Each time a habit is completed, users can mark it, decreasing the remaining count for the day. Every day, the habits reset to their maximum count, encouraging consistent and healthy routines.")
                    
                    Text("3. Progress Review")
                        .bold()

                    Text("Our third section allows users to review their journey. It includes a calendar view where users can look back at their completed forms and tracked habits. This retrospective feature enables users to see their progress over time, offering insight into their emotional patterns and habit consistency.")
                    
                    Text("4. Cardiac Coherence Training")
                        .bold()

                    Text("The final section of our application offers cardiac coherence exercises. Users can customize the duration of their breathing cycles, choosing their preferred times for inhalation and exhalation. This tool is designed to help users achieve relaxation and reduce stress through controlled breathing techniques.")
                    
                    Text("At HealthyMind, we believe in the power of holistic self-care. Our application is a personal companion in your journey towards mental well-being, providing tools and insights to help you navigate the complexities of emotions and habits. Join us in cultivating a balanced and mindful lifestyle.")
                    }
                    .padding(.init(top: 5, leading: 10, bottom: 5, trailing:10))
                
                
                    
            }
            .lineSpacing(5)
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("background2"))
    }
}

#Preview {
    AboutView()
}
