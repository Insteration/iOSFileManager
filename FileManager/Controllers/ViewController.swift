//
//  ViewController.swift
//  FileManager
//
//  Created by Artem Karmaz on 3/21/19.
//  Copyright © 2019 Artem Karmaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var fileManagerMenuButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var fileContentTextView: UITextView!
    @IBOutlet weak var fileOrDirectoryNameTextField: UITextField!
    @IBOutlet weak var resulLabelScrollView: UIScrollView!
    
    let fileManager = FileManagement()
    var timer = Timer()
    var isTimerRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        runTimer()
        setupGestures()
        hideKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(fileManagerControl), name: NSNotification.Name(rawValue: "FileManagerCommand"), object: nil)
        resulLabelScrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: resultLabel.bottomAnchor).isActive = true
        
        fileOrDirectoryNameTextField.delegate = self
    }
    
    @objc func fileManagerControl() {
        switch FileManagement.commandValue {
        case 0:
            resultLabel.text = fileManager.getInfo()
        case 1:
            resultLabel.text = fileManager.clear()
            fileContentTextView.text = fileManager.clear()
            fileOrDirectoryNameTextField.text = fileManager.clear()
        case 2:
            fileManager.createFile(fileOrDirectoryNameTextField.text ?? "data", fileContentTextView.text ?? "")
        case 3:
            fileManager.createDirectory(fileOrDirectoryNameTextField.text ?? "MyDir")
        case 4:
            fileManager.removeItem(fileOrDirectoryNameTextField.text ?? "")     
        case 5:
            print(fileManager.getUrl())
        default:
            ()
        }
    }
    
    // MARK: - Add UITapGestureRecognizer on Menu Button for calling UITableView

    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGesture.numberOfTapsRequired = 1
        fileManagerMenuButton.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapped() {
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "PopVC") else { return }
        popVC.modalPresentationStyle = .popover
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.fileManagerMenuButton
        popOverVC?.sourceRect = CGRect(x: self.fileManagerMenuButton.bounds.midX, y: self.fileManagerMenuButton.bounds.minY, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 250, height: 250)
        self.present(popVC, animated: true)
    }
    
    // MARK: - Add Timer for Get Info
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        resultLabel.text = fileManager.getInfo()
    }

}

extension ViewController: UIPopoverPresentationControllerDelegate {
    
    // MARK: - UI Popover Presentation Controller Delegate
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension ViewController {
    
    // MARK: - Hide keyboard in tap
    
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ViewController: UITextFieldDelegate {
    
    // MARK: - Text Field Delegates
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fileOrDirectoryNameTextField {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
}
