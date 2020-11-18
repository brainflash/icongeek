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
	@Binding var hasShadow: Bool
	@Binding var hasGlow: Bool
	@Binding var viewBackground: Color
	@Binding var iconsBackground: Color
	@Binding var iconsTint: Color
	@Binding var iconsSize: Double

	@State private var multiSelect = false
	@State private var showingColorPicker = false
	
	var body: some View {
		VStack {
			Group {
				HStack {
					// View background
					ColorPicker(selection: $iconSet.viewBackground, supportsOpacity: false, label: {
						Label {
						} icon: {
							HStack {
								Text("Background")
									.bold()
									.foregroundColor(.black)
							}
							.contentShape(Rectangle())
						}
						.labelStyle(IconOnlyLabelStyle())
					})
					.padding()
					.frame(height: 50)
					.background(Color.lightGrey)
					.cornerRadius(10)
					
					HStack {
						// Icon shadow
						Button(action: { iconSet.toggleShadow() }) {
							HStack {
								VStack(alignment: .leading) {
									Text("Icon shadow")
										.bold()
										.foregroundColor(.black)
										.padding()
								}
								
								Spacer()
								
								Toggle("Icon shadow", isOn: $hasShadow)
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
						
						// Icon labels
						Button(action: { iconSet.toggleLabels() }) {
							HStack {
								VStack(alignment: .leading) {
									Text("Icon labels")
										.bold()
										.foregroundColor(.black)
										.padding()
								}
								
								Spacer()
								
								Toggle("Icon Labels", isOn: $showLabels)
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
					}
					
				}
				HStack {
					// Icons background
					ColorPicker(selection: $iconsBackground, supportsOpacity: false, label: {
						Label {
						} icon: {
							HStack {
								Text("Icon Background")
									.bold()
									.foregroundColor(.black)
							}
							.contentShape(Rectangle())
						}
						.labelStyle(IconOnlyLabelStyle())
					})
					.padding()
					.frame(height: 50)
					.background(Color.lightGrey)
					.cornerRadius(10)

					
					HStack {
						// Icon tint
						if iconSet.display.supportsTint {
							ColorPicker(selection: $iconsTint, supportsOpacity: false, label: {
								Label {
								} icon: {
									HStack {
										Text("Tint color")
											.bold()
											.foregroundColor(.black)
										
										Spacer()
										Spacer()

										// Undo/reset button
	//									Button(action: {
	//										// TODO: undo action
	//										print("Undo button pressed")
	//									}) {
	//										Image(systemName: "arrow.counterclockwise")
	//											.font(.title3)
	//											.foregroundColor(.black)
	//									}
										
										Spacer()

	//								Circle()
	//									.fill(iconsBackground)
									}
									.contentShape(Rectangle())
								}
								.labelStyle(IconOnlyLabelStyle())
							})
							.padding()
							.frame(height: 50)
							.background(Color.lightGrey)
							.cornerRadius(10)
						}
						
						// Icon glow
						Button(action: { iconSet.toggleGlow() }) {
							HStack {
								VStack(alignment: .leading) {
									Text("Icon glow")
										.bold()
										.foregroundColor(.black)
										.padding()
								}
								
								Spacer()
								
								Toggle("Icon glow", isOn: $hasGlow)
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
					}
				}
				
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
	static var hasShadow = Binding<Bool>.constant(true)
	static var hasGlow = Binding<Bool>.constant(false)
	static var viewBackground = Binding<Color>.constant(.lightGrey)
	static var iconsBackground = Binding<Color>.constant(.white)
	static var iconsTint = Binding<Color>.constant(.pink)
	static var iconsSize = Binding<Double>.constant(1.0)

    static var previews: some View {
		OptionsView(iconSet: iconSet,
					showLabels: showLabels,
					hasShadow: hasShadow,
					hasGlow: hasGlow,
					viewBackground: viewBackground,
					iconsBackground: iconsBackground,
					iconsTint: iconsTint,
					iconsSize: iconsSize)
    }
}
