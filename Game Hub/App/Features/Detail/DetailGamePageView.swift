//
//  DetailGamePageView.swift
//  Game Hub
//
//  Created by Julsapargi Nursam on 19/02/23.
//

import SwiftUI
import SDWebImageSwiftUI
import WebKit

struct DetailGamePageView: View {
    @ObservedObject var viewModel = DetailGameViewModel()
    
    var idGame: Int
    var name: String
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    if case .loading = viewModel.detailGame {
                        ProgressView()
                            .multilineTextAlignment(.center)
                    } else if case .success(let data) = viewModel.detailGame {
                        WebImage(url: URL(string: data.backgroundImage))
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
                        
                        Text(html: data.description)
                            .padding(.top, 1)
                        
                        Text("Genre")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .foregroundColor(.black)
                            .padding(.top, 8)
                        
                        HStack {
                            ForEach(data.genres, id: \.id) { genre in
                                Text(genre.name)
                                    .font(.subheadline)
                                    .fontWeight(.light)
                                    .lineLimit(1)
                                    .foregroundColor(.gray)
                                    .padding(.top, 1)
                            }
                        }
                    } else if case .error(let error) = viewModel.detailGame {
                        Text(error.localizedDescription)
                    }
                }
            }
            .onAppear {
                self.viewModel.getDetailGame(idGame: idGame)
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
