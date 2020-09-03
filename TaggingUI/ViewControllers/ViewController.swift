//
//  ViewController.swift
//  TaggingUI
//
//  Created by Anki on 01/09/20.
//  Copyright © 2020 ankitha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var addButton: UIButton!{
        didSet{
            Theme.Buttons.roundedButton(addButton,title: LocalizableKeys.addButton.localized)
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tagInputTextField: UITextField!{
        didSet{
            tagInputTextField.placeholder = LocalizableKeys.textFieldPlaceHolder.localized
        }
    }
    @IBOutlet weak var viewBottomConstraint: NSLayoutConstraint!
    let viewModel : MainViewModel = MainViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = viewModel
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "TagsCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "TagsCollectionViewCell")
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressedCell(gesture:)))
        collectionView.addGestureRecognizer(longGesture)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.3
            
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.viewBottomConstraint?.constant = 0.0
            } else {
                self.viewBottomConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: [],
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.tagsArray = viewModel.getFromDisk()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        self.tagInputTextField.endEditing(true)
        if let newTagText = self.tagInputTextField.text{
            self.viewModel.tagsArray.append(newTagText)
            self.viewModel.saveToDisk(tags: self.viewModel.tagsArray){ error in
                if error != nil{
                   self.showErrorAlert()
                }
            }
            self.collectionView.reloadData()
            self.tagInputTextField.text = ""
        }
    }
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? TagsCollectionViewCell {
            cell.delegate = self
        }
    }
}
extension ViewController:FileSaveProtocol{
    func saveFailed() {
        self.showErrorAlert()
    }
}
extension ViewController:TagCellActions{
    func closeTapped(cell: UICollectionViewCell) {
        guard let index = collectionView.indexPath(for: cell) else { return }
        UIView.animate(withDuration: 0.3, animations: {
            self.viewModel.tagsArray.remove(at: index.row)
            self.viewModel.saveToDisk(tags: self.viewModel.tagsArray){ error in
                if error != nil{
                    self.showErrorAlert()
                }
            }
            self.collectionView.deleteItems(at: [index])
        })
    }
    func showErrorAlert(){
        let alert = UIAlertController(title: "Sorry", message: "Save failed. Please retry", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
extension ViewController{
    @objc func longPressedCell(gesture:UILongPressGestureRecognizer){
        switch(gesture.state) {
            
        case .began:
            guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                break
            }
            self.collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            self.collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view))
        case .ended:
            self.collectionView.endInteractiveMovement()
        default:
            self.collectionView.cancelInteractiveMovement()
        }
    }
}
