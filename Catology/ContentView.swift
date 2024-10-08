//
//  ContentView.swift
//  Catology
//
//  Created by Emmanuel Albania on 10/8/24.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    GeometryReader { geometry in
      let imageSize = geometry.size.width * 0.8
      
      VStack(alignment: .center) {
        Spacer()
        HStack(alignment: .center) {
          Spacer()
          Image("catology-logo")
            .resizable()
            .frame(maxWidth: imageSize, maxHeight: imageSize)
            .aspectRatio(contentMode: .fill)
          Spacer()
        }
        Spacer()
      }
    }
  }
}

#Preview {
  ContentView()
}
