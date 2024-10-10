//
//  CatologyView.swift
//  Catology
//
//  Created by Emmanuel Albania on 10/8/24.
//

import SwiftUI
import Combine

struct CatologyView: View {
    @StateObject var viewModel = CatologyViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            let dimension = geometry.size.width * 0.9
            
            Button(action: viewModel.performScreenClickAction) {
                Spacer()
                HStack(alignment: .center) {
                    VStack {
                        displayImage()
                            .cornerRadius(12)
                            .frame(width: dimension, height: dimension)
                            .padding(.top, 20)
                            .shadow(radius: 2)
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
                        
                        if viewModel.isLoading {
                            ProgressViewLoader()
                        }
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
                    transaction: .init(animation: .easeInOut)
                ) { phase in
                    if let image = phase.image {
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    } else if let error = phase.error {
                        VStack {
                            Image(systemName: "questionmark.diamond")
                                .imageScale(.large)
                            Text(error.localizedDescription)
                            ProgressViewLoader()
                        }.accentColor(.red)
                    } else {
                        ProgressViewLoader()
                    }
                }
            } else {
                Image("catology-logo")
            }
        }
    }
}

#Preview {
    CatologyView()
}
