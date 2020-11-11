//
//  IconSetView.swift
//  IconGeek
//
//  Created by Brainflash on 24/10/2020.
//

import SwiftUI

struct IconSetThumb: View {
	
	var body: some View {
		let gradient = LinearGradient(gradient: Gradient(colors: [.white, .red, .black]), startPoint: .top, endPoint: .bottom)
		ZStack {
			Circle().fill(gradient)
				.frame(maxWidth: 50, maxHeight: 50)
			Text("🦄")
				.padding()
				.font(.largeTitle)
				.multilineTextAlignment(.center)
		}
	}
}

struct IconSetView: View {
	@Environment(\.colorScheme) var colorScheme
	
	@ObservedObject var iconSet: IconSet = IconSet.iconSet1
	@State var iconMode: IconView.Mode
	@Binding var viewBackground: Color
	
	var selectionMode: SelectionMode = .multiple

	enum SelectionMode {
		case single
		case multiple
	}
		
	var body: some View {
		ZStack {
			ScrollView {
				content
			}
			.clipped()
		}
		.background(viewBackground)
	}
	
	var content: some View {
		VStack(spacing: 0) {
			VStack(alignment: .leading) {
				LazyVGrid(columns: [GridItem(.adaptive(minimum: 70), spacing: 16, alignment: .top)],
						  alignment: .center,
						  spacing: 12) {
					ForEach(iconSet.icons) { icon in
						VStack(alignment: .center) {
							IconView(icon: icon, iconSet: iconSet, mode: iconMode)
								.contentShape(Rectangle())
								.aspectRatio(contentMode: .fit)
						}
					}
				}
			}
			.padding()
		}
	}
}

// MARK: - API
extension IconSetView {
	mutating func setMultiSelect(multi: Bool) {
		iconSet.multiSelect = multi
		self.selectionMode = (multi == true ? .multiple : .single)
	}
}

// MARK: - Previews
struct IconSetView_Previews: PreviewProvider {
	static var multiSelect = Binding<Bool>.constant(true)
	static var viewBackground = Binding<Color>.constant(Color.white)

    static var previews: some View {
		IconSetView(iconMode: .selecting, viewBackground: viewBackground)
    }
}
