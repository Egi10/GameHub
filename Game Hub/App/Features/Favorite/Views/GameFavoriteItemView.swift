//
//  GameFavoriteItemView.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 04/03/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameFavoriteItem: View {
    var image: String
    var name: String
    var releaseDate: String
    var rating: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            WebImage(url: URL(string: image))
                  .resizable()
                  .indicator(.activity)
                  .frame(height: 150)
                  .cornerRadius(8)
            
            Text(name)
                .font(.caption)
                .fontWeight(.semibold)
                .lineLimit(1)
                .foregroundColor(.black)
            
            HStack(alignment: .center) {
                Text(releaseDate)
                    .font(.caption2)
                    .fontWeight(.light)
                    .lineLimit(1)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                
                Text("\(rating, specifier: "%.2f")")
                    .font(.caption2)
                    .fontWeight(.light)
                    .lineLimit(1)
                    .foregroundColor(.gray)
            }
        }
        .padding(.top, 8)
    }
}
