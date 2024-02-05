//
//  CreditView.swift
//  HealthyMind
//
//  Created by Eva Herson on 05/02/2024.
//

import SwiftUI

struct CreditView: View {
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                Group{
                    HStack{
                        Spacer()
                        Text("CREDIT")
                            .bold()
                        Spacer()
                    }
                    
                    Text("Design")
                        .bold()

                    Text("Application Logo and Emojis: The logo of HealthyMind and the custom emojis used to help users describe their emotions were creatively designed by Anaïs Herson. We sincerely thank Anaïs for their artistic contributions, enhancing both the visual identity and user experience of our application.")
                    
                    Text("Technology and Tools")
                        .bold()

                         
                    Text("DALL-E 3: The images in this application were generated using DALL-E 3, an AI image generation model developed by OpenAI. We extend our gratitude to OpenAI for enabling us to create unique and engaging visuals.")
                    
                    Text("ChatGPT-4: Portions of this application’s code and content were developed with assistance from ChatGPT-4, a language model also provided by OpenAI. We appreciate the support provided by this innovative technology in refining our application.")
                    
                    Text("Support and Contributions")
                        .bold()


                    Text("Beta Testers: We express our sincere gratitude to Lukas Koltes, Anaïs Herson, and Isabelle Fontaine for their invaluable assistance as beta testers. Their feedback and insights have been instrumental in refining the functionality and user experience of HealthyMind.")
                    
                    Text("Legal Notices")
                        .bold()


                    Text("All product names, logos, brands, trademarks and registered trademarks are property of their respective owners. Use of these names, logos, and brands does not imply endorsement.")
                    
                    Text("The content and functionality of HealthyMind are the property of Eva Herson and are protected by copyright and intellectual property laws.")
                    
                    Text("Acknowledgements")
                        .bold()

                    Text("We extend our heartfelt thanks to everyone who has contributed to the development and improvement of HealthyMind. Your support and feedback have been invaluable.")
                    
                    Text("Contact Us")
                        .bold()


                    Text("For any inquiries, suggestions, or feedback, please contact us at [Your Contact Email/Information].")
                    
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
    CreditView()
}
