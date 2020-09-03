//
//  MainViewModel.swift
//  TaggingUI
//
//  Created by Anki on 02/09/20.
//  Copyright © 2020 ankitha. All rights reserved.
//

import Foundation
import UIKit
protocol FileSaveProtocol:class {
    func saveFailed()
}
class MainViewModel: NSObject, UICollectionViewDataSource{
    var tagsArray : [String] = []
    weak var delegate : FileSaveProtocol? = nil
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagsCollectionViewCell", for: indexPath) as? TagsCollectionViewCell
        cell?.nameOfTag.text = tagsArray[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = self.tagsArray.remove(at: sourceIndexPath.item)
        self.tagsArray.insert(item, at: destinationIndexPath.item)
        saveToDisk(tags: tagsArray, completionHandler: {_ in
            self.delegate?.saveFailed()
        })
    }
}
extension MainViewModel{
    // Helper method to get a URL to the user's documents directory
      func getDocumentsURL() -> URL {
          if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
              return url
          } else {
              fatalError("Could not retrieve documents directory")
          }
      }

    func saveToDisk(tags: [String], completionHandler: @escaping (Error?) -> Void) -> Void{
          let url = getDocumentsURL().appendingPathComponent("tags.json")
          let encoder = JSONEncoder()
          do {
              let data = try encoder.encode(tags)
              try data.write(to: url, options: [])
          } catch {
            //Failed to write to file.
            completionHandler(error)
//              fatalError(error.localizedDescription)
          }
      }

      func getFromDisk() -> [String] {
          let url = getDocumentsURL().appendingPathComponent("tags.json")
          let decoder = JSONDecoder()
          do {
            let data = try Data(contentsOf: url, options: [])
              let tags = try decoder.decode([String].self, from: data)
              return tags
          } catch {
            return []
          }
      }
}
