//
//  GameCard.swift
//  GameApp
//
//  Created by Luka Mavrin on 02.12.2022..
//

import SwiftUI
import SDWebImageSwiftUI

struct GameCard: View {
	@EnvironmentObject var favorites: Favorites
	let game: Result
	let cardAndImageWidth: CGFloat = 180
	let cardHeight: CGFloat = 210
	let imageHeight: CGFloat = 140
	let cornerRadius: CGFloat = 20
	var body: some View{
		ZStack(alignment: .top){
				//TODO: Make a card for the gamesListView so that they are shown there
				RoundedRectangle(cornerRadius: cornerRadius)
				.strokeBorder(SwiftUI.Color.gray, lineWidth: 1)
					.frame(width: cardAndImageWidth, height: cardHeight)
					.background(RoundedRectangle(cornerRadius: cornerRadius).fill(SwiftUI.Color.white)).opacity(0.3)

			
			VStack(alignment: .leading, spacing: 10) {
				WebImage(url: URL(string: game.backgroundImage ?? ""))
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: cardAndImageWidth, height: imageHeight)
					.clipped()

				VStack(alignment: .leading, spacing: 2) {
					Text(game.name ?? "Unknown")
						.font(.custom("Avenir", size: 14))
						.fontWeight(.bold)
						.foregroundColor(Color.white)
					HStack{
						Text(game.released ?? "Unknown")
							.font(.custom("Avenir", size: 12))
							.foregroundColor(Color.white)
						Spacer()
						Button {
							if !(favorites.contains(game)){
								favorites.remove(game)
							}else{
								favorites.add(game)
							}
						} label: {
							Image(systemName: favorites.contains(game) ? "heart.fill" : "heart.slash.fill").foregroundColor(.red)
						}

					}

				}
				.padding(.horizontal,12)
				.padding(.bottom,11)
			}
			.frame(width: cardAndImageWidth, height: cardHeight)
			.cornerRadius(cornerRadius)
		}
	}
}
