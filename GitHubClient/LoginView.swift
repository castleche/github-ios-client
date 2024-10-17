//
//  LoginView.swift
//  GitHubClient
//
//  Created by Hao Che on 2024/10/17.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var userInput: String = ""
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                VStack(alignment:.center) {
                    Image("github-logo")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding(10)
                    Spacer().frame(height: 30)
                    TextField("Github access token (classic)", text:$userInput)
                        .frame(minWidth: 270, idealWidth: 270, maxWidth: 270, minHeight: 40, idealHeight: 40, maxHeight: 40, alignment: .leading)
                        .padding(10)
                        .border(Color.blue, width: 2)
                        .cornerRadius(8)
                    Spacer().frame(height: 30)
                    HStack(alignment:.center) {
                        Button(action: {
                            if userInput.count > 0 {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            Text("Login")
                                .foregroundColor(.white)
                        }
                        .frame(width: 120, height: 40, alignment: .center)
                        .background(Color.blue)
                        Spacer().frame(width: 50)
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Later")
                                .foregroundColor(.blue)
                        }
                        .frame(width: 120, height: 40, alignment: .center)
                        .background(Color.white)
                        .border(Color.blue, width: 2)
                    }
                    Spacer().frame(height: 30)
                }
            }
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
