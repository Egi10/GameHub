//
//  InformationView.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 04/03/23.
//

import SwiftUI

struct InformationView: View {
    var image: String
    var message: String
    
    var body: some View {
        VStack(alignment: .center) {
            Image(image)
                .resizable()
                .frame(width: 250, height: 250)
            
            Text(message)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .padding(16)
    }
}
