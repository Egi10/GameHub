//
//  HomePageView.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 18/02/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomePageView: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Games List")
                    .font(.title)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                
                if case .loading = viewModel.games {
                    ProgressView()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                } else if case .success(let data) = viewModel.games {
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(data, id: \.self) { game in
                                NavigationLink {
                                    DetailGamePageView(idGame: game.id, name: game.name)
                                        .toolbar(.hidden, for: .tabBar)
                                } label: {
                                    GameItem(
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
                } else if case .empty = viewModel.games {
                    InformationView(image: "ImageEmpty", message: "There is no game list at this time")
                } else if case .error(let error) = viewModel.games {
                    InformationView(image: "ImageError", message: error.localizedDescription)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        }
        .onAppear {
            self.viewModel.getGame()
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
