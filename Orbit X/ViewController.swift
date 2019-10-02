//
//  ViewController.swift
//  Orbit X
//
//  Created by Kyle Prince on 9/27/19.
//  Copyright © 2019 galaxxy. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var fileField: NSTextField!
    @IBOutlet weak var pubKey: NSSecureTextField!
    @IBOutlet weak var messageField: NSTextField!
    @IBOutlet weak var largeField: NSTextField!
    @IBOutlet weak var privKey: NSTextField!
    @IBOutlet weak var decryptWarningText: NSTextField!
    @IBOutlet weak var progressBar: NSProgressIndicator!
    
    @IBAction func browseBtn(_ sender: NSButton) {
        let dialog = NSOpenPanel();
        
        dialog.title                   = "Choose a .txt file";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = true;
        dialog.canCreateDirectories    = true;
        dialog.allowsMultipleSelection = false;
        dialog.allowedFileTypes        = ["txt", "gxm"];

        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url
            
            if (result != nil) {
                let path = result!.path
                fileField.stringValue = path
            }
        }
        else {
            return
        }
    }
    
    
    @IBAction func encryptBtn(_ sender: NSButton) {
        let orbit = Orbit()
        progressBar.startAnimation(orbit)
        let encMessage = orbit.encryptMessage(message: messageField.stringValue)
        largeField.stringValue = encMessage
        privKey.stringValue = String(orbit.privKey)
        //progressBar.stopAnimation(orbit)
        
    }
    
    
    @IBAction func decryptBtn(_ sender: NSButton) {
        let orbit = Orbit()
        progressBar.startAnimation(orbit)
        if (pubKey.stringValue.count == 1) {
            let prKey = Character(pubKey.stringValue)
            let decMessage = orbit.decryptMessage(encmessage: messageField.stringValue, fKey: prKey)
            largeField.stringValue = decMessage
        }
        else {
            decryptWarningText.stringValue = "1 key only!"
        }
        progressBar.stopAnimation(orbit)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

