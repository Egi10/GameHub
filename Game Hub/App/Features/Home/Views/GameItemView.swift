//
//  GameItemView.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 18/02/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameItem: View {
    var image: String
    var name: String
    var releaseDate: String
    var rating: Double
    
    var body: some View {
        HStack(alignment: .center) {
            WebImage(url: URL(string: image))
                  .resizable()
                  .indicator(.activity)
                  .frame(width: 100, height: 100)
                  .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 0.0) {
                Text(name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .foregroundColor(.black)
                
                Text(releaseDate)
                    .font(.caption)
                    .fontWeight(.light)
                    .lineLimit(1)
                    .foregroundColor(.gray)
                    .padding(.top, 8)
                
                HStack(alignment: .center) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text("\(rating, specifier: "%.2f")")
                        .font(.caption)
                        .fontWeight(.light)
                        .lineLimit(1)
                        .foregroundColor(.gray)
                }.padding(.top, 8)
            }
            .padding(.horizontal, 8.0)
        }
        .padding(.top, 10)
    }
}
