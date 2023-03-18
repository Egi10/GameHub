//
//  FavoritePageView.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 04/03/23.
//

import SwiftUI

struct FavoritePageView: View {
    @ObservedObject var viewModel = FavoriteViewModel()
    
    private var gridItemLayout = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Favorite List")
                    .font(.title)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                
                if case .loading = viewModel.favorite {
                    ProgressView()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                } else if case .success(let data) = viewModel.favorite {
                    ScrollView {
                        LazyVGrid(columns: gridItemLayout) {
                            ForEach(data, id: \.self) { game in
                                NavigationLink {
                                    DetailFavoritePageView(idGame: game.id, name: game.name)
                                } label: {
                                    GameFavoriteItem(
                                        image: game.image,
                                        name: game.name,
                                        releaseDate: game.released,
                                        rating: game.rating
                                    )
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                } else if case .empty = viewModel.favorite {
                    InformationView(image: "ImageEmpty", message: "There is no game list at this time")
                } else if case .error = viewModel.favorite {
                    InformationView(image: "ImageError", message: "Ops, There is an error")
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .onAppear {
                self.viewModel.getFavorite()
            }
        }
    }
}

struct FavoritePageView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePageView()
    }
}
