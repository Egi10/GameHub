//
//  DetailGamePageView.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 19/02/23.
//

import SwiftUI

struct DetailGamePageView: View {
    var idGame: Int
    var name: String
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                Text("Hello \(idGame) - \(name)")
            }
            .padding(.horizontal, 18)
            .padding(.top, 10.0)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .navigationBarTitle(name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DetailGamePageView_Previews: PreviewProvider {
    static var previews: some View {
        DetailGamePageView(idGame: 3498, name: "Grand Theft Auto V")
    }
}
