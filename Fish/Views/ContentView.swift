//
//  ContentView.swift
//  Fish
//
//  Created by Aaron Zheng (student LM) on 1/18/23.
//

import SwiftUI
import struct Kingfisher.KFImage

struct ContentView: View {
    
    @StateObject var data = FetchData()
    
    var body: some View {
        ZStack {
            Color.purple
                .ignoresSafeArea()
            
            ScrollView {
                ForEach(data.response) { i in
                    
                    Text(i.name)
                        .padding()
                        .foregroundColor(Color.white)
                        .font(Font.largeTitle.bold())
                    
                    KFImage(URL(string: i.photo.src))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                }
            }
            .task {
                await data.getData()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
