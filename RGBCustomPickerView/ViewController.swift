//
//  ViewController.swift
//  SamplePicker
//
//  Created by Shubh on 24/04/17.
//  Copyright © 2017 Shubh. All rights reserved.
//

import UIKit

class ViewController: UIViewController,RGBPickerDelegate {

    @IBOutlet weak var viewReciever: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        RGBPicker.sharedInstance.delegate = self;

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openColorPicker(_ sender: Any) {
        
    
        RGBPicker.sharedInstance.showcolorPicker()

        
    }
    
    func RGBPickerCallback(_ color: UIColor) {
        
        self.viewReciever.backgroundColor = color;
    }
    

}

