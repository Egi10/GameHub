//
//  DetailGamePageView.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 19/02/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailGamePageView: View {
    @ObservedObject var viewModel = DetailGameViewModel()
    
    @State private var showNavigationBar = true
    
    var idGame: Int
    var name: String
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    if case .loading = viewModel.detailGame {
                        ProgressView()
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                    } else if case .success(let data) = viewModel.detailGame {
                        WebImage(url: URL(string: data.image))
                              .resizable()
                              .indicator(.activity)
                              .frame(height: 200)
                              .cornerRadius(8)
                        
                        HStack(alignment: .center) {
                            Text(data.name)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .lineLimit(1)
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            
                            Text("\(data.rating, specifier: "%.2f")")
                                .font(.caption)
                                .fontWeight(.light)
                                .lineLimit(1)
                                .foregroundColor(.gray)
                        }
                        
                        Text(data.released)
                            .font(.caption)
                            .fontWeight(.light)
                            .lineLimit(1)
                            .foregroundColor(.gray)
                        
                        Text("Description")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .foregroundColor(.black)
                            .padding(.top, 8)
                        
                        Text(data.description)
                            .font(.subheadline)
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                            .padding(.top, 1)
                        
                        Text("Genre")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .foregroundColor(.black)
                            .padding(.top, 8)
                        
                        HStack {
                            ForEach(data.genres, id: \.self) { genre in
                                Text(genre)
                                    .font(.subheadline)
                                    .fontWeight(.light)
                                    .lineLimit(1)
                                    .foregroundColor(.gray)
                                    .padding(.top, 1)
                            }
                        }
                    } else if case .error(let error) = viewModel.detailGame {
                        InformationView(image: "ImageError", message: error.localizedDescription)
                    }
                }
            }
            .onAppear {
                self.viewModel.getDetailGame(idGame: idGame)
                // TODO: This doesn't look good!!
                self.viewModel.getGameFavoriteById(idGame: idGame)
            }
            .toolbar(showNavigationBar ? .visible : .hidden)
            .toolbar {
                if !viewModel.isFavorite {
                    favoriteButton
                } else {
                    unfavoriteButton
                }
            }
            .padding(.horizontal, 18)
            .padding(.top, 10.0)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .navigationBarTitle(name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var favoriteButton: some View {
            Button(action: {
                viewModel.addGameFavorite(
                    detailGame: viewModel.detailGame.value!
                )
            }, label: {
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.gray)
                    .padding(.trailing)
            })
        }
    
    var unfavoriteButton: some View {
        Button(action: {
            viewModel.removeGameFavorite(
                from: idGame
            )
        }, label: {
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.red)
                .padding(.trailing)
        })
    }
}

struct DetailGamePageView_Previews: PreviewProvider {
    static var previews: some View {
        DetailGamePageView(idGame: 3498, name: "Grand Theft Auto V")
    }
}
