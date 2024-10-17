//
//  ContentView.swift
//  GitHubClient
//
//  Created by Hao Che on 2024/10/16.
//

import SwiftUI
import Alamofire

struct UserResponse: Codable {
    let name : String?
    let email : String?
    let html_url : String?
    let created_at : String?
}

struct ContentView: View {
    @State private var shouldLogin = true
    @State public var accessToken : String = ""
    @State private var isPresentingLoginView = false
    @State private var userData: UserResponse?

    private var loginView : LoginView? = nil;

    var body: some View {
        HStack(alignment: .center) {
            Spacer(minLength: 30)
            VStack(alignment: .leading) {
                Text("Name: " + (userData?.name ?? "N/A"))
                    .padding(20)
                Text("Email: " + (userData?.email ?? "N/A"))
                    .padding(20)
                Text("HTML Page: " + (userData?.html_url ?? "N/A"))
                    .padding(20)
                Text("Registered On: " + (userData?.created_at ?? "N/A"))
                    .padding(20)
                if accessToken.count == 0 {
                    Button(action: {
                        if accessToken.count == 0
                        {
                            isPresentingLoginView = true;
                        }
                    }) {
                        Text("Login")
                            .foregroundColor(.blue)
                            .padding(10)
                    }
                    .background(Color.white)
                    .border(Color.blue, width: 2)
                }
            }
            Spacer(minLength: 30)
        }
        .onAppear {
            if accessToken.count == 0
            {
                isPresentingLoginView = true;
            }
        }
        .sheet(isPresented: $isPresentingLoginView, onDismiss: {
            if accessToken.count == 0 {
                return
            }
            AF.request("https://api.github.com/user",
                       method: .get,
                       headers: ["Accept": "application/json",
                                "Authorization": "Bearer " + accessToken,
                                 "X-GitHub-Api-Version": "2022-11-28"])
                .validate()
                .responseDecodable(of: UserResponse.self) { response in
                    switch response.result {
                    case .success(let data):
                        userData = data
                    case .failure:
                        userData = UserResponse(name: "N/A", email: "N/A", html_url: "N/A", created_at: "N/A")
                    }
                }
//                .responseString { response in
//                                 switch response.result {
//                                 case .success(let responseString):
//                                     print("响应字符串: \(responseString)")
//                                 case .failure(let error):
//                                     print( "请求失败：\(error.localizedDescription)")
//                                 }
//                             }
        }, content: { LoginView(accessToken: $accessToken) })
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
