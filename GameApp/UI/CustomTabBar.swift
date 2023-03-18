//
//  customTabBar.swift
//  GameApp
//
//  Created by Luka Mavrin on 04.12.2022..
//

import SwiftUI

struct CustomTabBar: View {
	@Binding var currentTab: Tab

	var backgroundColors = [Color("backgroundColor1"),Color.blue,Color("backgroundColor2")]
	var gradientCircleColors = [Color.cyan.opacity(0.8),Color.pink.opacity(0.2),Color.cyan.opacity(0.8)]
	var screenWidth = UIScreen.main.bounds.size.width
	var circleColors = [Color.cyan,Color.pink.opacity(0.45),Color("circleColor")]
	var height = {
		if UIDevice.current.userInterfaceIdiom == .pad{
			return CGFloat(50)
		}
		return CGFloat(24)
	}

    var body: some View {
			GeometryReader {geometry in
				let width = geometry.size.width
				HStack(spacing: 0.0){
					ForEach(Tab.allCases, id: \.rawValue){ tab in
						Button {
							withAnimation(.easeInOut){
								currentTab = tab
							}
							} label: {
								Image(systemName: tab.rawValue).renderingMode(.template).frame(maxWidth: .infinity).foregroundColor(.white).offset(y: currentTab == tab ? -15 : 0)
						}

					}
				}.frame(maxWidth: .infinity)
					.background(alignment: .leading){
						Circle()
							.fill(LinearGradient(colors: circleColors, startPoint: .topLeading, endPoint: .bottomTrailing))
							.frame(width: 50, height: 50)
							.shadow(color: .black.opacity(0.25), radius: 20, x: 0, y: 10)
							.offset(x: indicatorOffset(width: width), y: -15)
							.overlay(
								Circle().trim(from: 0, to: CGFloat(0.5))
									.stroke(LinearGradient(colors: gradientCircleColors, startPoint: .top, endPoint: .bottom),style: StrokeStyle(lineWidth: 2))
									.rotationEffect(.degrees(135))
									.frame(width: 47,height: 47)
									.offset(x: indicatorOffset(width: width), y: -15)
							)
					}
			}.frame(height: height()).padding(.top, 40)
				.background(.ultraThinMaterial)
				.background(LinearGradient(colors: backgroundColors, startPoint: .leading, endPoint: .trailing))
		}

	func indicatorOffset(width: CGFloat) -> CGFloat {
		if UIDevice.current.userInterfaceIdiom == .pad {
			let index = CGFloat(getIndex())
			let padding = width * 0.134

			if index == 0 {return padding}
			let buttonWidth = width / CGFloat(Tab.allCases.count)

			return (index * buttonWidth + padding)
		}
		let index = CGFloat(getIndex())
		let padding = width * 0.108

		if index == 0 {return padding}
		let buttonWidth = width / CGFloat(Tab.allCases.count)

		return (index * buttonWidth + padding)
	}


	func getIndex() -> Int {
		switch currentTab{
			case .games:
				return 0
			case .search:
				return 2
//			case .personalGames:
//				return 3
			case .favorites:
				return 1
		}
	}
}

struct customTabBar_Previews: PreviewProvider {
    static var previews: some View {
			CustomTabBar(currentTab: .constant(.games))
    }
}
