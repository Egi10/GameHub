//
//  DetailFavoritePageView.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 04/03/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailFavoritePageView: View {
    @ObservedObject var viewModel = DetailFavoriteViewModel()
    
    @State private var showNavigationBar = true
    @State private var showToast = false
    
    var idGame: Int
    var name: String
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    if case .loading = viewModel.favorite {
                        ProgressView()
                            .multilineTextAlignment(.center)
                    } else if case .success(let data) = viewModel.favorite {
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
                    } else if case .error = viewModel.favorite {
                        InformationView(image: "ImageError", message: "Ops, There is an error")
                    }
                }
            }
            .onAppear {
                self.viewModel.getFavoriteById(from: idGame)
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
            .sheet(isPresented: $showToast, content: {
                VStack(alignment: .leading) {
                    Text("Oops, failed to save")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text("Currently, the favorite details after being deleted cannot be saved anymore, you can return to home to save again")
                        .font(.body)

                }
                .padding(16)
                .presentationDetents([.fraction(0.20)])
            })
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var favoriteButton: some View {
            Button(action: {
                self.showToast = true
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
            self.viewModel.isFavorite  = false
        }, label: {
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.red)
                .padding(.trailing)
        })
    }
}

struct DetailFavoritePageView_Previews: PreviewProvider {
    static var previews: some View {
        DetailFavoritePageView(idGame: 3498, name: "Grand Theft Auto V")
    }
}
