//
//  CircleBackground.swift
//  GameApp
//
//  Created by Luka Mavrin on 05.12.2022..
//

import SwiftUI

struct CircleBackground: View {
	var color: Color
    var body: some View {
			Circle()
				.fill(color)
				
				.frame(width: 300, height: 300)
				.shadow(color: .black.opacity(0.25), radius: 20, x: 0, y: 10)

    }
}

struct CircleBackground_Previews: PreviewProvider {
    static var previews: some View {
			CircleBackground(color: Color.pink)
    }
}
