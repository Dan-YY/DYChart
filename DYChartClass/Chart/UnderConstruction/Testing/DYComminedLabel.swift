//
//  DYComminedLabel.swift
//  DY2DBodyNodeLib
//
//  Created by macbook on 2020-01-13.
//  Copyright © 2020 Dan's Studio. All rights reserved.
//

import UIKit

class DYComminedLabel: UILabel {

	var rootText: String? { didSet { setNeedsLayout() }}
	var prefixText: String? { didSet { setNeedsLayout() }}
	var suffixText: String? { didSet { setNeedsLayout() }}
	var rootFont = UIFont.systemFont(ofSize: 20, weight: .medium) { didSet { setNeedsLayout() }}
	var prefixFont = UIFont.systemFont(ofSize: 15, weight: .regular) { didSet { setNeedsLayout() }}
	var suffixFont = UIFont.systemFont(ofSize: 15, weight: .regular) { didSet { setNeedsLayout() }}

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		updateLabel()
	}

	private func updateLabel() {
		let attributedString = NSMutableAttributedString()
		if let text = prefixText {
			let sub = createAttributedString(with: text, font: prefixFont)
			attributedString.append(sub)
		}
		if let text = rootText {
			let sub = createAttributedString(with: text, font: rootFont)
			attributedString.append(sub)
		}
		if let text = suffixText {
			let sub = createAttributedString(with: text, font: suffixFont)
			attributedString.append(sub)
		}
		attributedText = attributedString
	}

	private func createAttributedString(with string: String, font: UIFont) -> NSAttributedString {
		let attributes = [NSAttributedString.Key.font: font]
		let attributedString = NSMutableAttributedString(string: string, attributes: attributes)
		return attributedString
	}



}
