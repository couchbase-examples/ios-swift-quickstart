//
//  ContentView.swift
//  Couchbase-Lite-Swift-Demo
//
//  Created by Dominik Brozio on 10/02/2025.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = ContentViewModel()
    @EnvironmentObject var errorManager: ErrorManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                hotelList
                if let error = $errorManager.errors.first {
                    CustomErrorView(title: error.title.wrappedValue, message: error.message.wrappedValue) {
                        errorManager.dismissAndShowNext()
                    }
                    .transition(.scale)
                }
            }
            .onAppear() {
                viewModel.onAppear()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Airport management")
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.white, for: .navigationBar)
        }
    }
    
    var hotelList: some View {
        VStack(spacing: 0) {
            if let hotels = viewModel.hotels {
                viewHeader
                ScrollView {
                    ForEach(hotels) { hotel in
                        itemView(hotel)
                    }
                }
            } else {
                Text("loading queried hotels")
            }
        }
    }
    
    var viewHeader: some View {
        VStack(spacing: 0){
            HStack {
                Text("Hotel name")
                    .frame(maxWidth: .infinity)
                Text("City")
                    .frame(maxWidth: .infinity)
                Text("Country")
                    .frame(maxWidth: .infinity)
            }
            .background(Color.gray.opacity(0.5))
            Color.black
                .frame(height: 1)
        }
    }
    
    private func itemView(_ item: Hotel) -> some View {
        VStack{
            HStack {
                Text(item.name ?? "")
                    .lineLimit(2)
                    .frame(maxWidth: .infinity)
                Text(item.city ?? "")
                    .lineLimit(1)
                    .frame(maxWidth: .infinity)
                Text(item.country)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity)
            }
            .padding(2)
            Color.black
                .frame(height: 1)
        }
    }
}

#Preview {
    ContentView()
}
