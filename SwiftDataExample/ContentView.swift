//
//  ContentView.swift
//  SwiftDataExample
//
//  Created by Sachin Patoliya on 13/04/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \UserModel.name, order: .forward, animation: .spring)
    var users:[UserModel]

    
    //State proeprties
    @State private var username: String = ""
    @State private var mobile: String = ""
    @State private var email: String = ""
    @State private var isUpdate: Bool = false
    @State private var selectedUser: UserModel?

    var body: some View {
        VStack {
            CustomTextField(username: $username, placeholder: "Enter name")
            CustomTextField(username: $mobile, placeholder: "Enter mobile")
            CustomTextField(username: $email, placeholder: "Enter email")
            Spacer()
            List(users){ user in
                Text(user.name)
                    .swipeActions{
                        Button("Delete", role: .destructive) {
                            modelContext.delete(user)
                        }
                        Button("Update", role: .none) {
                            isUpdate = true
                            selectedUser = user
                            username = user.name
                            mobile = user.phone
                            email = user.email
                        }

                    }
            }
            CustomButton(completion: {
                if isUpdate{
                    updateUser()
                }else{
                    addUser()
                }
            }, title: isUpdate ? "Update" : "Save")
        }
        .padding()
    }
    
    func addUser() {
        if username != "" && email != "" && mobile != ""{
            let user = UserModel(name: username, email: email, phone: mobile)
            modelContext.insert(user)
            username = ""
            mobile = ""
            email = ""
        }
    }
    
    func updateUser(){
        if username != "" && email != "" && mobile != ""{
            selectedUser?.name = username
            selectedUser?.email = email
            selectedUser?.phone = mobile
            username = ""
            mobile = ""
            email = ""
            isUpdate = false
            selectedUser = nil
        }
    }
}

#Preview {
    ContentView()
}


struct CustomTextField: View {
    
    @Binding var username: String
    var placeholder: String

    var body: some View {
        TextField(placeholder, text: $username)
            .padding(.all, 30)
            .overlay(content: {
                RoundedRectangle(cornerRadius: 20.0)
                    .stroke(.gray, lineWidth: 1.0)
            })
    }
    
    func getText() -> String{
        return username
    }
}


struct CustomButton: View {
    
    var completion: (() -> Void)
    var title: String

    var body: some View {
            Button(action: completion, label: {
                Text(title)
                    .foregroundStyle(.white)
            })
            .padding(.all, 30)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(content: {
                RoundedRectangle(cornerRadius: 20.0, style: .continuous)
                    .fill()
                    .stroke(.gray, lineWidth: 1.0)
            })
    }
}
