//
//  FileManagerModel.swift
//  FileManager
//
//  Created by Artem Karmaz on 3/22/19.
//  Copyright © 2019 Artem Karmaz. All rights reserved.
//

import UIKit

class FileManagement: Helper {
    
    var fileManager = FileManager.default
    static var commandValue = 0

    // MARK:- Get URL
    
    func getUrl(path: String = "") -> URL {
        var url = URL(fileURLWithPath: path)
        do {
            url = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(path)
        } catch {
            print(error)
        }
        
        return url
    }
    
    // MARK:- Get Info
    
    func getInfo() -> String {
        let url = getUrl()
        var filesList = [String]()
        
        do {
            filesList = try fileManager.contentsOfDirectory(atPath: url.path)
        } catch {
            print(error)
        }
        
        var getStringFormArrayStrings = String()
        filesList.forEach() {
            getStringFormArrayStrings += $0 + "\n"
        }
        
        return "\n=============" + "\nDate: " + getCurrentTime() + "\n=============" + "\nContents:" + "\n=============" + "\n\(getStringFormArrayStrings)" + "\n============="
    }
    
    // MARK:- Create Direcotry
    
    func createDirectory(_ nameOfDirectory: String) {
        
        let nameDir = nameOfDirectory
        var nameForLabel = ""
        
        let url = getUrl(path: nameDir)
        do {
            try fileManager.createDirectory(at: url, withIntermediateDirectories: true)
            nameForLabel = getInfo() + nameForLabel
        } catch {
            print(error)
        }
    }
    
    // MARK:- Clear Logs
    
    func clear() -> (String) {
        return ""
    }
    
    // MARK:- Remove Item
    
    func removeItem(_ nameOfRemoveItem: String) {
        let nameItem = nameOfRemoveItem
        
        let url = getUrl(path: nameItem)
        
        do {
            try fileManager.removeItem(at: url)
            print("Delete success!")
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    // MARK:- Create File
    
    func createFile(_ nameOfCreateFile: String, _ dataIndiseOfFile: String...) {
        let nameFile = nameOfCreateFile
        let url = getUrl(path: nameFile)
        let data = Data(dataIndiseOfFile[0].utf8)
        fileManager.createFile(atPath: url.path, contents: data)
    }
}
