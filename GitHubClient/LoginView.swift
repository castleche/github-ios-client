//
//  LoginView.swift
//  GitHubClient
//
//  Created by Hao Che on 2024/10/17.
//

import Foundation
import SwiftUI
import Alamofire

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var userInput: String = ""
    @State private var errorHint: String = ""

    @Binding public var accessToken : String

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
                                AF.request("https://api.github.com/user",
                                           method: .get,
                                           headers: ["Accept": "application/vnd.github+json",
                                                    "Authorization": "Bearer " + userInput,
                                                     "X-GitHub-Api-Version": "2022-11-28"])
                                    .validate()
                                    .response { response in
                                        if let statusCode = response.response?.statusCode {
                                            if (statusCode == 200)
                                            {
                                                errorHint = ""
                                                accessToken = userInput
                                                presentationMode.wrappedValue.dismiss()
                                            }
                                        }
                                    }
                            } else {
                                errorHint = "Please enter valid Github access token (classic) above."
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
                    VStack()
                    {
                        Text(errorHint)
                            .multilineTextAlignment(.leading)
                            .lineLimit(10)
                            .foregroundColor(.red)
                            .font(.footnote)
                    }.frame(width: 270, height: 60, alignment: .leading)
                    Spacer().frame(height: 30)
                }
            }
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    @State static public var accessToken : String = ""
//    static var previews: some View {
//        LoginView(accessToken: $accessToken)
//    }
//}
