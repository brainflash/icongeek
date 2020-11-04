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
	@Binding var iconsSize: Double

	@State private var showingColorPicker = false
	
	var body: some View {
		VStack {
			Group {
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

								// Undo/reset button
//								Button(action: {
//									// TODO: undo action
//									print("Undo button pressed")
//								}) {
//									Image(systemName: "arrow.counterclockwise")
//										.font(.title3)
//										.foregroundColor(.black)
//								}
								
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
				
				// Scale slider - TODO
				HStack {
					Text("Icon size")
						.bold()
						.foregroundColor(.black)
						.padding()
					Slider(value: $iconsSize, in: 0.5...1.5)
						.padding()
					Text(String(format: "%.1f", iconsSize))
						.bold()
						.foregroundColor(.black)
						.padding(20)
				}
				.frame(height: 50)
				.background(Color.lightGrey)
				.cornerRadius(10)
			}
			.padding()
			.frame(height: 50)
		}
		.background(VisualEffectBlur())
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
	static var iconsSize = Binding<Double>.constant(1.0)

    static var previews: some View {
		OptionsView(iconSet: iconSet,
					showLabels: showLabels,
					iconsBackground: iconsBackground,
					iconsSize: iconsSize)
    }
}
