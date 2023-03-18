//
//  GameDetailsView.swift
//  GameApp
//
//  Created by Luka Mavrin on 04.12.2022..
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI


struct GameDetailsView: View {
	@EnvironmentObject var games: GamesApi
	@EnvironmentObject var favorites: Favorites
	var game: Result
	@Binding var selectedTab: Tab
	@State private var showNameInfo = false
	@State private var showStateInfo = false
	@State var animate = false
	@State var animate2 = false
	var backgroundColor = [Color("backgroundColor1"),Color("backgroundColor2")]
	
	
	var body: some View {
		//TODO: Do the details view for each of the game here
		NavigationStack{
			ZStack{
				CircleBackground(color: Color("blueCircle")).blur(radius: animate ? 30 : 100).offset(x: animate ? -50 : -130, y: animate ? -30 : -100).task{
					withAnimation(.easeInOut(duration: 7).repeatForever()){
						animate.toggle()
					}
				}
				CircleBackground(color: Color("pinkCircle")).blur(radius: animate2 ? 30 : 100).offset(x: animate2 ? 100 : 130, y: animate2 ? 150 : 100)
					.task{
						withAnimation(.easeInOut(duration: 7).repeatForever()){
							animate2.toggle()
						}
					}

				VStack{
					List{
						GeometryReader{ proxy in
							TabView{
								ForEach(game.shortScreenshots ?? [], id: \.id){image in

									WebImage(url: URL(string: image.image))
										.resizable().clipped().aspectRatio(contentMode: .fill).tag(image.id)
									//End of image
								}
							}.tabViewStyle(PageTabViewStyle()).clipShape(RoundedRectangle(cornerRadius: 20))

						}.listRowBackground(Color.clear).listRowSeparatorTint(.clear).frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.3)
//						WebImage(url: URL(string: game.backgroundImage))
//							.resizable()
//							.aspectRatio(contentMode: .fill)
//						//						.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.3)
//							.clipped().listRowBackground(Color.clear).cornerRadius(20)//End of image
						HStack{
							Text("Genres:").bold()
							ScrollView(.horizontal, showsIndicators: false){
								HStack{
									ForEach(game.genres ?? [], id: \.name) { genre in
										Text(genre.name ?? "Unknown").bold()
										if !(genre.id == game.genres?.last?.id){
											Text("|")
										}
									}
								}
							}
						}.listRowBackground(Color.black.opacity(0.2)).listRowSeparatorTint(.white)//end of HStack
						Text("Released: \(game.released ?? "Unknown")").listRowBackground(Color.black.opacity(0.2)).listRowSeparatorTint(.white)
//						HStack{
//							Text("Stores:").bold()
//							ScrollView(.horizontal, showsIndicators: false){
//								HStack{
//									ForEach(game.stores ?? [], id: \.id) { genre in
//										Text(genre.store.name ?? "Unknown").bold()
//										if !(genre.store.id == game.stores?.last?.store.id){
//											Text("|")
//										}
//									}
//								}
//							}
//						}.listRowBackground(Color.black.opacity(0.2)).listRowSeparatorTint(.white)//end of HStack
						HStack(alignment: .top){
							Text("Game status:").bold()
							ScrollView(.horizontal, showsIndicators: false){
								VStack(alignment: .leading){
									Text("Game is owned = \(game.addedByStatus?.owned ?? 0)").bold()
									Text("Planned to be played = \(game.addedByStatus?.toplay ?? 0)").bold()
									Text("Game was beaten = \(game.addedByStatus?.beaten ?? 0)").bold()
									Text("Game was dropped = \(game.addedByStatus?.dropped ?? 0)").bold()
									Text("Game is yet = \(game.addedByStatus?.yet ?? 0)").bold()

								}
							}
						}.listRowBackground(Color.black.opacity(0.2)).listRowSeparatorTint(.white)//end of VStack
						VStack(alignment: .leading){
							Text("Metacritic: \(game.metacritic ?? 0)/100 ").bold()
							Text("Number of Reviews: \(game.reviewsCount ?? 0)").bold()
							Text("ESRB Rating: \((game.esrbRating?.name ?? ""))").bold()
						}.listRowBackground(Color.black.opacity(0.2)).listRowSeparatorTint(.white)// End of Hstack
						HStack{
							Text("Tags:").bold()
							ScrollView(.horizontal, showsIndicators: false){
								HStack{
									ForEach(game.tags ?? [], id: \.id) { tags in
										Text(tags.name ?? "Unknown").bold()
										if !(tags.id == game.tags?.last?.id){
											Text("|")
										}
									}
								}
							}
						}.listRowBackground(Color.black.opacity(0.2)).listRowSeparatorTint(.white)//end of HStack
						VStack(alignment: .center){
							Button {
								if !(favorites.contains(game)){
									favorites.remove(game)
								}else{
									favorites.add(game)
								}
							} label: {
								Image(systemName: favorites.contains(game) ? "heart.fill" : "heart.slash.fill").resizable().foregroundColor(.red).frame(width: 50,height: 50)
							}

						}.listRowBackground(Color.black.opacity(0.2)).listRowSeparatorTint(.white).frame(width: UIScreen.main.bounds.width)

					}.scrollContentBackground(.hidden).foregroundColor(.white)// End of list
					
				}// End of VSTACK
			}.background(
			LinearGradient(colors: backgroundColor, startPoint: .bottom, endPoint: .top)
		).ignoresSafeArea(.keyboard)// End of zstack
		}.navigationBarTitle(game.name ?? "Unknown").tint(.white) // end of navigationStack
	} //body
}



