//
//  CatologyView.swift
//  Catology
//
//  Created by Emmanuel Albania on 10/8/24.
//

import SwiftUI
import Combine

struct CatologyView: View {
    @State var fact: String = ""
    @StateObject var viewModel = CatologyViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            let dimension = geometry.size.width * 0.9
            
            Button(action: viewModel.performScreenClickAction) {
                Spacer()
                HStack(alignment: .center) {
                    VStack {
                        displayImage()
                            .frame(width: dimension, height: dimension)
                            .padding(.top, 20)
                            .clipped()
                            
                        
                        ScrollView {
                            Spacer()
                            Text(viewModel.nextFact ?? "Click anywhere to start")
                                .foregroundStyle(.gray)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 8)
                        .frame(width: dimension)
                        Spacer()
                    }
                }
                Spacer()
            }.disabled(viewModel.isLoading)
        }
    }
    
    private func displayImage() -> some View {
        Group {
            if let imageURLString = viewModel.nextImageURL,
               let url = URL(string: imageURLString) {
                AsyncImage(
                    url: url,
                    content: { result in
                        result.resizable()
                            .aspectRatio(contentMode: .fit)
                    },
                    placeholder: { Image("catology-logo") }
                )
            } else {
                Image("catology-logo")
            }
        }
    }
}

#Preview {
    CatologyView()
}
