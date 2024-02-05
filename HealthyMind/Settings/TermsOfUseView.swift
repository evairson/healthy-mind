//
//  TermsOfUseView.swift
//  HealthyMind
//
//  Created by Eva Herson on 05/02/2024.
//

import SwiftUI

struct TermsOfUseView: View {
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                Group{
                    Text("Terms of Service for HealthyMind")
                        .bold()
                        
                    Text("Last Updated: 05/01/2024")
                        .italic()
                        .padding(.leading)

                    Text("Welcome to HealthyMind, a mental health application designed to support your well-being through reflective writing and self-assessment. By accessing or using our application, you agree to be bound by these Terms of Service and our Privacy Policy.")

                    Text("1. Acceptance of Terms")
                        .bold()
                    
                    Text("By downloading, accessing, or using HealthyMind, you agree to comply with and be bound by these Terms of Service. If you do not agree to these terms, please do not use our application.")

                    Text("2. Use of the Application")
                        .bold()
                    Text("HealthyMind is intended for users to record their personal mental health information through forms and reflective writing. All data entered in the application is stored locally on your device and is not accessible to others.")

                    Text("3. User Responsibilities")
                        .bold()

                    Text("You must use the application for personal, non-commercial purposes only.")
                    Text("You are responsible for safeguarding any data you enter into the application.")
                    Text("You must not use the application for any illegal or unauthorized purpose.")
                         
                    Text("4. Intellectual Property Rights")
                        .bold()
                    Text("The content and functionality of the application, including text, graphics, and user interface, are the property of Eva Herson and are protected by intellectual property laws.")

                    Text("5. Privacy")
                        .bold()
                    Text("Your privacy is important to us. As HealthyMind stores all personal data locally on your device, We do not collect, store, or have access to any of your personal data entered in the application.")

                    Text("6. Changes to Terms of Service")
                        .bold()
                    Text("Eva Herson reserves the right to modify these Terms of Service at any time. We will notify you of any changes by updating the date at the top of these terms.")

                    Text("7. Disclaimer of Warranties")
                        .bold()
                    Text("HealthyMind is provided 'as is,' without any warranties of any kind. We do not guarantee the effectiveness of the application in improving mental health.")

                    Text("8. Limitation of Liability")
                        .bold()
                    Text("We shall not be liable for any damages resulting from the use or inability to use the application.")

                    Text("9. Contact Information")
                        .bold()
                    Text("For any questions or concerns about these Terms of Service, please contact us at [Email/Contact Information].")

                    Text("By using HealthyMind, you acknowledge that you have read, understood, and agree to be bound by these Terms of Service.")
                        
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
    TermsOfUseView()
}
