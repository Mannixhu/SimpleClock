//
//  ViewController.swift
//  SimpleClock
//
//  Created by 曾天宇 on 25/01/2018.
//  Copyright © 2018 曾天宇. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    
    @IBOutlet weak var NightModeChange: NSButton!
    
    @IBOutlet weak var ClockLabel: NSTextField!
    @IBOutlet weak var CalendarLabel: NSTextField!
    @IBOutlet weak var BackgroundView: NSVisualEffectView!
    @IBOutlet weak var SecondChanger: NSButton!
    var timer = Timer()
    let timeFormat = DateFormatter()
    let timeFormat2 = DateFormatter()
    var isNightMode = Bool(true)
    var isSecond = Bool(false)
    var is24H = Bool(true)
    
    @IBOutlet weak var ThemeChanger: NSClickGestureRecognizer!
    @IBOutlet weak var Background: NSVisualEffectView!
    
    
    @IBAction func ChangeSecond(_ sender: Any) {
        if isSecond {
            isSecond = false
        }else{
            isSecond = true
        }
    }
    
    func Change24H() -> Void {
        if is24H {
            is24H = false
        }else{
            is24H = true
        }
    }
    @IBAction func ClickToChangeBackgroundInWindow(_ sender: Any) {
        ClickToChangeBackground(Any.self)
    }
    
    @IBAction func ClickToChangeBackground(_ sender: Any) {
        if isNightMode {
            BackgroundView.material =  NSVisualEffectView.Material.mediumLight
            ClockLabel.textColor = NSColor.black
            CalendarLabel.textColor = NSColor.black
            isNightMode = false
        }else{
            BackgroundView.material =  NSVisualEffectView.Material.dark
            ClockLabel.textColor = NSColor.white
            CalendarLabel.textColor = NSColor.white
            isNightMode = true
        }
    }
    
    let codeTimer = DispatchSource.makeTimerSource(queue:      DispatchQueue.global())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeFormat.dateFormat = "HH:mm  aa"
        timeFormat2.dateFormat = "yyyy/MM/dd EEEE  zzzz ZZZZ"
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { (timer) in
            self.timerMain()
        })
        
        timer.fire();
    }
    
    func timerMain() -> Void {
        let time = Date()
        self.setFormatClock(mode: self.isSecond, is24: self.is24H)
        self.ClockLabel.stringValue = self.timeFormat.string(from: time as Date) as String
        self.CalendarLabel.stringValue = self.timeFormat2.string(from: time as Date ) as String
    }
    
    override func viewDidDisappear() {
        self.timer.invalidate();
    }

    func setFormatClock(mode: Bool, is24: Bool) -> Void {
        if mode {
            if is24{
                timeFormat.dateFormat = "HH:mm:ss  aa"
            }else{
                timeFormat.dateFormat = "h:mm:ss  aa"                
            }
        }else{
            if is24{
                timeFormat.dateFormat = "HH:mm  aa"
            }else{
                timeFormat.dateFormat = "h:mm  aa"
            }
        }
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
}
