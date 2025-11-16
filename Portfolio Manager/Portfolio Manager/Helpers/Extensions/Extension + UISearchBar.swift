//
//  Extension + UISearchBar.swift
//  Portfolio Manager
//
//  Created by Pranay Jadhav on 16/11/25.
//
import UIKit

extension UISearchBar {
    func addKeyboardToolbar(showCancel: Bool = false, doneTitle: String = "Done") {
        // Access the search field inside the search bar
        guard let textField = self.value(forKey: "searchField") as? UITextField else { return }

        // Create toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        // Flexible space to push Done to the right
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                   target: nil,
                                   action: nil)

        // Done button
        let doneButton = UIBarButtonItem(title: doneTitle,
                                         style: .done,
                                         target: self,
                                         action: #selector(dismissKeyboard))

        // Optional cancel button
        var items = [UIBarButtonItem]()

        if showCancel {
            let cancel = UIBarButtonItem(title: "Cancel",
                                         style: .plain,
                                         target: self,
                                         action: #selector(cancelSearch))
            items.append(cancel)
        }

        items.append(contentsOf: [flex, doneButton])

        toolbar.items = items

        // Attach toolbar to keyboard
        textField.inputAccessoryView = toolbar
    }

    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }

    @objc private func cancelSearch() {
        self.text = ""
        self.endEditing(true)
    }
}
