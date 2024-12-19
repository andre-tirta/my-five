//
//  BottomSheetView.swift
//  myFive
//
//  Created by Andre Tirta Wijaya on 19/12/24.
//

import Foundation
import SwiftUI

struct BottomSheetView: View {
    let user: User
    @Environment(\.presentationMode) var presentationMode
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            UserProfileHeaderView()
                
            if let url = URL(string: "https://i.pravatar.cc/1000") {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 250)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .padding(.top, 30)
                } placeholder: {
                    ProgressView()
                }
                .shadow(color: Color(hex: "#F7D6B4"), radius: 5, x: 2, y: 3)
            } else {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 40, height: 40)
            }
            
            Text(user.name ?? "Unknown")
                .font(.system(size: 32, weight: .semibold))
                .padding()
            
            VStack {
                LazyVGrid(columns: columns, spacing: 10) {
                    Text("USERNAME")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(user.username ?? "-")
                        .font(.system(size: 16, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("EMAIL")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(user.email ?? "-")
                        .font(.system(size: 16, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("ADDRESS")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(maxHeight: .infinity, alignment: .top)
                    VStack(alignment: .leading, spacing: 10) {
                        Text(user.address?.street ?? "-")
                            .font(.system(size: 16, weight: .regular))
                        Text(user.address?.suite ?? "-")
                            .font(.system(size: 16, weight: .regular))
                        Text(user.address?.zipcode ?? "-")
                            .font(.system(size: 16, weight: .regular))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    Text("PHONE")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(user.phone ?? "-")
                        .font(.system(size: 16, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("WEBSITE")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(user.website ?? "-")
                        .font(.system(size: 16, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()

            }
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
            )
            .cornerRadius(10)
            .padding()
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color(hex: "#F9F5F2"))
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(.top, 30)
    }
}

#Preview {
    BottomSheetView(
        user: User(
            id: 1,
            name: "Tom Riordan",
            username: "worm",
            email: "tom@gmail.com",
            phone: "(123) 456-7890",
            website: "tomriordan.com",
            address: Address(
                street: "123 Main St",
                suite: "Apt 1",
                city: "Town",
                zipcode: "12345-1234",
                geo: nil
            ),
            company: nil
        )
    )
}
