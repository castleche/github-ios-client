//
//  ContentView.swift
//  GitHubClient
//
//  Created by Hao Che on 2024/10/16.
//

import SwiftUI

struct ContentView: View {
    @State private var shouldLogin = true
    @State private var isPresentingLoginView = false

    var body: some View {
        Text("Hello, world!")
            .font(.largeTitle)
            .foregroundColor(.blue)
            .padding()
            .background(.green)
            .onAppear {
                if (shouldLogin)
                {
                    isPresentingLoginView = true;
                }
            }
            .sheet(isPresented: $isPresentingLoginView)
        {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
