//
// Corona-Warn-App
//
// SAP SE and all other contributors
// copyright owners license this file to you under the Apache
// License, Version 2.0 (the "License"); you may not use this
// file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
//

import Foundation
import UIKit

class EUSettingsViewController: DynamicTableViewController {

	// MARK: - ViewDidLoad.

	override func viewDidLoad() {
		super.viewDidLoad()
		setUp()
	}

	// MARK: - View setup methods.

	private func setUp() {
		// title = "### Europaweite Risiko-Ermittlung"
		view.backgroundColor = .enaColor(for: .background)

		setupTableView()
		setupBackButton()
	}

	private func setupTableView() {
		tableView.separatorStyle = .none
		dynamicTableViewModel = euSettingsModel()
		
		tableView.register(UINib(nibName: String(describing: ExposureSubmissionStepCell.self), bundle: nil), forCellReuseIdentifier: CustomCellReuseIdentifiers.stepCell.rawValue)
		tableView.register(
			DynamicTableViewRoundedCell.self,
			forCellReuseIdentifier: CustomCellReuseIdentifiers.roundedCell.rawValue
		)
		tableView.register(
			SwitchCell.self,
			forCellReuseIdentifier: CustomCellReuseIdentifiers.switchCell.rawValue
		)
	}

	// MARK: - Helper methods.

	private func show14DaysErrorAlert() {
		let alert = setupErrorAlert(
			title: AppStrings.ExposureNotificationSetting.eu14DaysAlertTitle,
			message: AppStrings.ExposureNotificationSetting.eu14DaysAlertDescription,
			okTitle: AppStrings.ExposureNotificationSetting.eu14DaysAlertDeactivateTitle,
			secondaryActionTitle: AppStrings.ExposureNotificationSetting.eu14DaysAlertBackTitle,
			completion: nil,
			secondaryActionCompletion: nil
		)
		present(alert, animated: true, completion: nil)
	}
}

private extension EUSettingsViewController {
	enum CustomCellReuseIdentifiers: String, TableViewCellReuseIdentifiers {
		case stepCell
		case roundedCell
		case switchCell
	}
}

private extension EUSettingsViewController {
	func euSettingsModel() -> DynamicTableViewModel {
		DynamicTableViewModel([
			.section(cells: [
				.title1(
					text: AppStrings.ExposureNotificationSetting.euTitle,
					accessibilityIdentifier: ""
				),
				.headline(
					text: AppStrings.ExposureNotificationSetting.euDescription,
					accessibilityIdentifier: ""
				)
			]),
			.section(
				separators: true,
				cells: [
					.switchCell(text: AppStrings.ExposureNotificationSetting.euAllCountries)
				]
			),
			.section(cells: [
				.footnote(
					text: AppStrings.ExposureNotificationSetting.euDataTrafficDescription,
					accessibilityIdentifier: ""
				),
				.space(height: 16)
			]),
			.countrySwitchSection(),
			.section(cells: [
				.footnote(
					text: AppStrings.ExposureNotificationSetting.euRegionDescription,
					accessibilityIdentifier: ""
				),
				.stepCell(
					title: AppStrings.ExposureNotificationSetting.euGermanRiskTitle,
					description: AppStrings.ExposureNotificationSetting.euGermanRiskDescription,
					icon: UIImage(named: "Icons_Grey_1"),
					hairline: .none
				),
				.custom(withIdentifier: CustomCellReuseIdentifiers.roundedCell,
						configure: { _, cell, _ in
							guard let privacyStatementCell = cell as? DynamicTableViewRoundedCell else { return }
							privacyStatementCell.configure(
								title: NSMutableAttributedString(
									string: AppStrings.ExposureNotificationSetting.euPrivacyTitle
								),
								body: NSMutableAttributedString(
									string: AppStrings.ExposureNotificationSetting.euPrivacyDescription
								),
								textStyle: .textPrimary1,
								backgroundStyle: .separator
							)
					})
			])
		])
	}
}

private extension DynamicSection {
	static func countrySwitchSection() -> DynamicSection {
		let countries = ["Deutschland", "Italien", "Österreich"]
		return DynamicSection.section(
			separators: true,
			cells: countries.map {
				DynamicCell.switchCell(text: $0, icon: .actions) {
					print("switch state: \($0)")
				}
			}
		)
	}
}

private extension DynamicCell {

	static func switchCell(text: String, icon: UIImage? = nil, isOn: Bool = false, onToggle: SwitchCell.ToggleHandler? = nil) -> Self {
		.custom(
			withIdentifier: EUSettingsViewController.CustomCellReuseIdentifiers.switchCell,
			action: .none,
			accessoryAction: .none
		) { _, cell, _ in
			guard let cell = cell as? SwitchCell else { return }
			cell.configure(text: text, icon: icon, isOn: isOn, onToggle: onToggle)
		}
	}
}

// TODO: Move to separate file.

private class SwitchCell: UITableViewCell {

	typealias ToggleHandler = (Bool) -> Void

	// MARK: - Private attributes.

	private let uiSwitch: UISwitch
	private var onToggleAction: ToggleHandler?

	// MARK: - Initializers.

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		uiSwitch = UISwitch()
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.selectionStyle = .none
		setUpSwitch()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Helpers.

	private func setUpSwitch() {
		// Constraints.
		// - Note: We do not use the accessory view because it breaks the separators of the DynamicTableViewController.
		uiSwitch.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(uiSwitch)
		uiSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
		uiSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true

		// Properties.
		uiSwitch.onTintColor = .enaColor(for: .tint)
		uiSwitch.addTarget(self, action: #selector(onToggle), for: .touchUpInside)
	}

	@objc
	private func onToggle() {
		onToggleAction?(uiSwitch.isOn)
	}

	// MARK: - Public API.

	func configure(text: String, icon: UIImage? = nil, isOn: Bool = false, onToggle: ToggleHandler? = nil) {
		imageView?.image = icon
		textLabel?.text = text
		uiSwitch.isOn = isOn
		onToggleAction = onToggle
	}
}
