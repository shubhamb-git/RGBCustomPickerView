# RGBCustomPickerView

Swift implementation of RGB PickerView

```
## Usage


     override func viewDidLoad() {
           super.viewDidLoad()
           RGBPicker.sharedInstance.delegate = self;
           // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func openColorPicker(_ sender: Any) {
        RGBPicker.sharedInstance.showcolorPicker()
    }
    //will call when you select color value from picker 
    func RGBPickerCallback(_ color: UIColor) {

        self.viewReciever.backgroundColor = color;
    }


```

## Author

Shubham , s.bairagi@outlook.com

## License

RGBPicker is available under the MIT license. See the LICENSE file for more info.
