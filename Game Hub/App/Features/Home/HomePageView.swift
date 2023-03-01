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
                if case .loading = viewModel.games {
                    ProgressView()
                } else if case .success(let data) = viewModel.games {
                    Text("Games List")
                        .font(.title)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .foregroundColor(.black)
                        .padding(.horizontal, 20)
                        .padding(.top, 8)
                    
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(data, id: \.self) { game in
                                NavigationLink {
                                    DetailGamePageView(idGame: game.id ?? 0, name: game.name ?? "")
                                        .toolbar(.hidden, for: .tabBar)
                                } label: {
                                    GameItem(
                                        image: game.image ?? "",
                                        name: game.name ?? "",
                                        releaseDate: game.released ?? "",
                                        rating: game.rating ?? 0.0
                                    )
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                } else if case .empty = viewModel.games {
                    Text("There is no game list at this time")
                } else if case .error(let error) = viewModel.games {
                    Text(error.localizedDescription)
                }
            }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
