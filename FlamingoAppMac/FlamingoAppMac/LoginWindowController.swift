//
//  LoginWindowController.swift
//  FlamingoAppMac
//
//  Created by victor on 10/10/2016.
//  Copyright © 2016 vicmac. All rights reserved.
//

import Cocoa

class LoginWindowController: NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
        
        
        /*let view = NSVisualEffectView(frame: NSRect(x: 0, y: 0, width: 1500, height: 800))
        view.blendingMode = NSVisualEffectBlendingMode.behindWindow
        view.material = NSVisualEffectMaterial.ultraDark
        view.state = NSVisualEffectState.active
        self.window!.contentView!.addSubview(view)*/
        
        //window?.appearance = NSAppearance(named: "NSAppearanceNamedVibrantDark")
        
        
        self.window?.titleVisibility = NSWindowTitleVisibility.hidden;
        self.window?.titlebarAppearsTransparent = true
        self.window?.isOpaque = false
        self.window?.backgroundColor = NSColor(red: 50.0/255.0, green: 8.0/255.0, blue: 58.0/255.0, alpha: 0.95/1.0)
    
        
    }
}
