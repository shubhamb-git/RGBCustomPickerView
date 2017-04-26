//
//  RGBPicker.swift
//  SamplePicker
//
//  Created by Shubh on 24/04/17.
//  Copyright © 2017 Shubh. All rights reserved.
//

import UIKit

enum RGBPickerColorComponant: Int {
    case RGBPickerColorComponantRed = 0, RGBPickerColorComponantGreen, RGBPickerColorComponantBlue
}

let RGBPicker_RGB_MAX : Double = 255.0;


public class RGBPicker: UIView {

    fileprivate var colorSwitchView : UIView!
    fileprivate var pickerView : UIPickerView!
    public var delegate : RGBPickerDelegate?
    
    var rCComponent:CGFloat! = 0 {
        didSet {
           
            self.updateColor()
        }
    }
    var gCComponent:CGFloat! = 0 {
        didSet {
            
            self.updateColor()
        }
    }
    
    var bCComponent:CGFloat! = 0 {
        didSet {
            
            self.updateColor()
        }
    }

    
   public static let sharedInstance = RGBPicker()
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.clear
        colorSwitchView = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height-260, width: UIScreen.main.bounds.size.width, height: 260))
        colorSwitchView.backgroundColor = UIColor.clear
        self.addSubview(colorSwitchView)
        
        let pickerFrame :CGRect = CGRect(x: 0, y: colorSwitchView.frame.size.height-216, width: UIScreen.main.bounds.size.width, height: 216)
        
        self.pickerView = UIPickerView(frame: pickerFrame)
        self.pickerView.backgroundColor = UIColor.white
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        
        colorSwitchView.addSubview(self.createToolbar()!)
        colorSwitchView.addSubview(self.pickerView)
        self.pickerView.showsSelectionIndicator = true;

    }

    
    private func createToolbar() -> UIToolbar?{
      
        let Toolbar: UIToolbar = UIToolbar(frame:CGRect(x:0,y:0,width:UIScreen.main.bounds.size.width,height:44))
        Toolbar.barStyle = .default
        Toolbar.barTintColor = UIColor.white
        Toolbar.isOpaque = true
        Toolbar.isTranslucent = false

        var barItems: [UIBarButtonItem] = [UIBarButtonItem]()
            let flexSpace: UIBarButtonItem = UIBarButtonItem(title:"  ", style: .plain, target:nil, action:nil)
            barItems.append(flexSpace)
            let cancelBtn: UIBarButtonItem = UIBarButtonItem(title:"Cancel", style: .plain, target:self, action:#selector(self.cancel_clicked(_:)))
                cancelBtn.tintColor = UIColor.black
            barItems.append(cancelBtn)
        
        let flexSpace2: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target:nil, action:nil)
        barItems.append(flexSpace2)

        let doneBtn: UIBarButtonItem = UIBarButtonItem(title:"Done", style: .plain, target:self, action:#selector(self.done_clicked(_:)))
            doneBtn.tintColor = UIColor.black
        barItems.append(doneBtn)
        let flexSpace1: UIBarButtonItem = UIBarButtonItem(title:"  ", style: .plain, target:nil, action:nil)
        barItems.append(flexSpace1)

        Toolbar.setItems(barItems, animated: false)
        
        
        return Toolbar
    }
    
    @IBAction func cancel_clicked(_ sender: AnyObject?) {
    
        self.hide()
    }
   
    @IBAction func done_clicked(_ sender: AnyObject?) {
        
        self.hide()
    }
    
    func updateColor(){
        
        let color = UIColor(red: self.rCComponent, green: self.gCComponent, blue: self.bCComponent, alpha: 1)
        
        if (self.delegate != nil) {
            
            self.delegate?.RGBPickerCallback(color)
        }
    }
    
    
    
    private func configurePicker(){
        
        self.selectRowInPickerView(13, withColorComponent: RGBPickerColorComponant.RGBPickerColorComponantRed.rawValue)
        self.selectRowInPickerView(41, withColorComponent: RGBPickerColorComponant.RGBPickerColorComponantGreen.rawValue)
        self.selectRowInPickerView(24, withColorComponent: RGBPickerColorComponant.RGBPickerColorComponantBlue.rawValue)

    }
    
    private func selectRowInPickerView(_ row:Int, withColorComponent component:Int) {
        
        self.pickerView.selectRow(row, inComponent: component, animated: true)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
   public func showcolorPicker(){
        
        UIApplication.shared.keyWindow?.addSubview(self)
        colorSwitchView.frame.origin.y = UIScreen.main.bounds.size.height
        colorSwitchView.frame.size.height = 0
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
            self.colorSwitchView.frame.origin.y = UIScreen.main.bounds.size.height-260
            self.colorSwitchView.frame.size.height = 260

            
        }) { (finished) in
        }
    }
    
    func hide() {
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
            self.colorSwitchView.frame.origin.y = UIScreen.main.bounds.size.height
            self.colorSwitchView.frame.size.height = 0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }

    
    
    
    
    
    
}


 //MARK:- UIPickerViewDataSource

extension RGBPicker: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 3;
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return  255;    //(NSInteger)ceil(AAPL_RGB_MAX / (CGFloat)[self colorValueOffset]) + 1;;
    }
    
}


extension RGBPicker: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let colorComponent:CGFloat = CGFloat(Double(row) / RGBPicker_RGB_MAX)
        var redColorComponent :CGFloat = 0;
        var greenColorComponent :CGFloat = 0;
        var blueColorComponent :CGFloat = 0;


        switch component {
        case RGBPickerColorComponant.RGBPickerColorComponantRed.rawValue:
            redColorComponent = colorComponent;
            break;
        case RGBPickerColorComponant.RGBPickerColorComponantGreen.rawValue:
            greenColorComponent = colorComponent;
            break;
        case RGBPickerColorComponant.RGBPickerColorComponantBlue.rawValue:
            blueColorComponent = colorComponent;
            break;
        default:
            NSLog("Invalid row/component combination for picker view.");
            break;
        }
        
        let foregroundColor :UIColor = UIColor(red: redColorComponent, green: greenColorComponent, blue: blueColorComponent, alpha: 1)
        let titleText = "\(row)"
        let title : NSAttributedString = NSAttributedString(string: titleText, attributes: [NSForegroundColorAttributeName : foregroundColor])
        
        return title;
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let colorComponent:CGFloat = CGFloat(Double(row) / RGBPicker_RGB_MAX)
      
        switch component {
        case RGBPickerColorComponant.RGBPickerColorComponantRed.rawValue:
            self.rCComponent = colorComponent;
            break;
        case RGBPickerColorComponant.RGBPickerColorComponantGreen.rawValue:
            self.gCComponent = colorComponent;
            break;
        case RGBPickerColorComponant.RGBPickerColorComponantBlue.rawValue:
            self.bCComponent = colorComponent;
            break;
        default:
            NSLog("Invalid row/component combination for picker view.");
            break;
        }
    }
}




public protocol RGBPickerDelegate : NSObjectProtocol {
    
     func RGBPickerCallback(_ color: UIColor);
}


