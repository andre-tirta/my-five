//
//  UserCell.swift
//  myFive
//
//  Created by Andre Tirta Wijaya on 19/12/24.
//

import Foundation
import SwiftUI

// MARK: - UserCell
struct UserCell: View {
    let user: User
    @Binding var searchText: String
    @State private var isBottomSheetPresented = false
    
    var body: some View {
        HStack(alignment: .top) {
            if let url = URL(string: "https://i.pravatar.cc/150") {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.black, lineWidth: 1)
                        )
                } placeholder: {
                    ProgressView()
                }
                .shadow(color: Color(hex: "#F7D6B4"), radius: 5, x: 2, y: 3)
            } else {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 40, height: 40)
            }
            
            VStack(alignment: .leading) {
                if let name = user.name {
                    Text(name)
                        .font(.headline)
                }
                if let username = user.username {
                    Text("@\(username)")
                        .font(.subheadline)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if !searchText.isEmpty {
                Image("addUser")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
            }
        }
        .padding()
        .background(Color.white)
        .onTapGesture {
            isBottomSheetPresented.toggle()
        }
        .sheet(isPresented: $isBottomSheetPresented) {
            BottomSheetView(user: user)
        }
    }
}
