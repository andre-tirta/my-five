//
//  UserProfileHeaderView.swift
//  myFive
//
//  Created by Andre Tirta Wijaya on 19/12/24.
//

import Foundation
import SwiftUI

struct UserProfileHeaderView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            Image("grabber")
                .padding(.top)
            HStack {
                Button(action: {
                    
                }) {
                    Image("")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.leading, 20)
                }
                Spacer()
                Text("Profile")
                    .font(.system(size: 20, weight: .semibold))
                Spacer()
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image("clearInput")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 20)
                }
            }
            .frame(height: 80)
        }
        .background(Color.white)
    }
}
