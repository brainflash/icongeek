//
//  OptionsView.swift
//  IconGeek
//
//  Created by Brainflash on 30/10/2020.
//

import SwiftUI
import PartialSheet

struct OptionsView: View {
	@Environment(\.colorScheme) var colorScheme
	@ObservedObject var iconSet: IconSet

	@Binding var showLabels: Bool
	@Binding var iconsBackground: Color
	@Binding var onlySelected: Bool
	
	@State private var showingColorPicker = false
	
	var body: some View {
		VStack {
			Group {
				Text("Icon Options")
					.font(.title)

				Button(action: { iconSet.toggleLabels() }) {
					HStack {
						VStack(alignment: .leading) {
							Text("Show icon labels")
								.bold()
								.foregroundColor(.black)
								.padding()
						}
						
						Spacer()
						
						Toggle("Show Icon Labels", isOn: $showLabels)
							.frame(width: 50)
							.padding(2)
							.aspectRatio(contentMode: .fit)
							.background(Color.lightGrey)
					}
					.frame(height: 50)
				}
				.buttonStyle(PlainButtonStyle())
				.toggleStyle(OptionsToggleStyle())
				.background(Color.lightGrey)
				.cornerRadius(10)

				HStack {
					ColorPicker(selection: $iconsBackground, supportsOpacity: false, label: {
						Label {
						} icon: {
							HStack {
								Text("Background color")
									.bold()
									.foregroundColor(.black)
								
								Spacer()
								Spacer()

								Button(action: {
									// TODO: undo action
									print("Undo button pressed")
								}) {
									Image(systemName: "arrow.counterclockwise")
										.font(.title3)
										.foregroundColor(.black)
								}
								
								Spacer()

//							Circle()
//								.fill(iconsBackground)
							}
							.contentShape(Rectangle())
						}
						.labelStyle(IconOnlyLabelStyle())
					})
					.padding()
				}
				.frame(height: 50)
				.background(Color.lightGrey)
				.cornerRadius(10)

				// Apply only to selected
				Button(action: { onlySelected.toggle() }) {
					HStack {
						VStack(alignment: .leading) {
							Text("Apply only to selected icons")
								.bold()
								.foregroundColor(.black)
								.padding()
						}
						
						Spacer()
						
						Toggle("Apply only to selected", isOn: $onlySelected)
							.frame(width: 50)
							.padding(2)
							.aspectRatio(contentMode: .fit)
							.background(Color.lightGrey)
					}
					.frame(height: 50)
				}
				.buttonStyle(PlainButtonStyle())
				.toggleStyle(OptionsToggleStyle())
				.background(Color.lightGrey)
				.cornerRadius(10)

				
				// Scale slider - TODO
				
			}
			.padding()
			.frame(height: 50)
		}
	}
}

extension PartialSheetStyle {

	static func optionsViewStyle(_ colorScheme: ColorScheme) -> PartialSheetStyle {
		return PartialSheetStyle(background: .blur(colorScheme == ColorScheme.dark ? .systemMaterialDark : .systemThickMaterialLight),
								 handlerBarColor: Color(UIColor.systemGray2),
								 enableCover: true,
								 coverColor: Color.black.opacity(0.001),	// opacity value makes the cover invisible so icons can be seen in full colour
								 blurEffectStyle: nil,
								 cornerRadius: 10,
								 minTopDistance: 110)
		}
}

struct OptionsToggleStyle: ToggleStyle {

	func makeBody(configuration: Configuration) -> some View {
		ZStack {
			configuration.label.hidden()
				Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
					.font(.system(size: 22, weight: .bold))
					.foregroundColor(Color.black)
					.background(Color.white)
					.accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
					.imageScale(.large)
					.clipShape(Circle())
					.overlay(Circle().stroke(Color.white, lineWidth: 3))
					.frame(width: 80, height: 80)
		}
	}
}

// MARK: - Previews
struct OptionsView_Previews: PreviewProvider {
	static var iconSet = IconSet.iconSet1
	static var showLabels = Binding<Bool>.constant(true)
	static var iconsBackground = Binding<Color>.constant(.white)
	static var onlySelected = Binding<Bool>.constant(true)

    static var previews: some View {
		OptionsView(iconSet: iconSet,
					showLabels: showLabels,
					iconsBackground: iconsBackground,
					onlySelected: onlySelected)
    }
}
