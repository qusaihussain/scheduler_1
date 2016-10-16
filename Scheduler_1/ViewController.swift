//
//  ViewController.swift
//  Scheduler_1
//
//  Created by Ben Baker on 10/15/16.
//  Copyright © 2016 Ben Baker. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {
    
    struct myVariables {
        var textNum: Int
    }
    
    @IBOutlet weak var startDateText: UITextField!
    @IBOutlet weak var endDateText: UITextField!
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        closeKeyboard()
    }

    @IBAction func saveButtonTapped(sender: UIButton) {
        closeKeyboard()
    }
    
    @IBOutlet weak var addGroupMember: UIButton!
    
    
    // MARK : TextField Delegate
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let datePicker = UIDatePicker()
        startDateText.inputView = datePicker
        endDateText.inputView = datePicker
        if textField == startDateText{
            datePicker.addTarget(self, action: #selector(ViewController.startDatePickerChanged(_:)), forControlEvents: .ValueChanged)
        } else {
            datePicker.addTarget(self, action: #selector(ViewController.endDatePickerChanged(_:)), forControlEvents: .ValueChanged)
        }
        
    }
    
    func startDatePickerChanged(sender: UIDatePicker){
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .ShortStyle
        startDateText.text = formatter.stringFromDate(sender.date)
    }
    
    func endDatePickerChanged(sender: UIDatePicker){
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .ShortStyle
        endDateText.text = formatter.stringFromDate(sender.date)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        startDateText.resignFirstResponder()
        endDateText.resignFirstResponder()
        return true
    }
    
    //MARK: Helper Methods
    
    func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        closeKeyboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startDateText.delegate = self
        endDateText.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

