//
//  ViewController.swift
//  Scheduler_1
//
//  Created by Ben Baker on 10/15/16.
//  Copyright © 2016 Ben Baker. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let ref = FIRDatabaseReference!.self
    
    var usernameArray = [String]()
    var startTime = String()
    var endTime = String()
    var length = Double()
    var eventList = [Event]()
    
    // MARK: IB Outlets
    
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var startDateText: UITextField!      // TODO: put date selectors in tableView
    @IBOutlet weak var endDateText: UITextField!        // TODO: show error when the end date is before the start date
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var addUser: UIButton!
    @IBOutlet weak var createEvent: UIButton!
    @IBOutlet weak var eventDetails: UITextField!
    @IBOutlet weak var lengthTime: UITextField!
    // TODO: add length (time) of the event
    
    // MARK: IB Actions
    
    @IBAction func addUser(_ sender: UIButton) {
        let usernameValue = String(describing: usernameText.text!)
        usernameArray.append(usernameValue)
        userTableView.reloadData()
        usernameText.text = ""
    }
    
    @IBAction func createEvent(_ sender: UIButton) {
        
        let ref = FIRDatabase.database().reference(withPath: "events")
        
        let newEvent = Event(name: eventName.text!, start: startTime, end: endTime, members: usernameArray, description: eventDetails.text!)
        
        let groceryItemRef = ref.child((eventName.text?.lowercased())!)
        
        groceryItemRef.setValue(newEvent.toAnyObject())
 
        // resets all variable and clears the screen
        eventName.text = ""
        startDateText.text = ""
        endDateText.text = ""
        eventDetails.text = ""
        usernameArray = []
        userTableView.reloadData()
    }

    // MARK: TextField Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let datePicker = UIDatePicker()
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = UIDatePickerMode.countDownTimer
        startDateText.inputView = datePicker
        endDateText.inputView = datePicker
        lengthTime.inputView = timePicker
        if textField == startDateText{
            datePicker.addTarget(self, action: #selector(ViewController.startDatePickerChanged(_:)), for: .valueChanged)
        } else if textField == endDateText{
            datePicker.addTarget(self, action: #selector(ViewController.endDatePickerChanged(_:)), for: .valueChanged)
        } else{
            datePicker.addTarget(self, action: #selector(ViewController.lengthTimePickerChanged(_:)), for: .valueChanged)
        }
    }
    
    func startDatePickerChanged(_ sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        startDateText.text = formatter.string(from: sender.date)
        startTime = formatter.string(from: sender.date)
    }
    
    func endDatePickerChanged(_ sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        endDateText.text = formatter.string(from: sender.date)
        endTime = formatter.string(from: sender.date)
    }
    
    func lengthTimePickerChanged(_ sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        lengthTime.text = formatter.string(from: sender.date)
        length = Double(lengthTime.text!)!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        startDateText.resignFirstResponder()
        endDateText.resignFirstResponder()
        lengthTime.resignFirstResponder()
        return true
    }
    
    // MARK: Tableview Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usernameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "username")!
        cell.textLabel?.text = usernameArray[indexPath.row]
        return cell
    }
    
    
    // MARK: Helper Methods
    
    func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeKeyboard()
    }
    
    // MARK: UI 
    
    func buttonUI(){
        addUser.backgroundColor = UIColor.blue
        addUser.layer.cornerRadius = 5
        addUser.layer.borderWidth = 1
        addUser.layer.borderColor = UIColor.blue.cgColor
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        buttonUI()
        startDateText.delegate = self
        endDateText.delegate = self
        lengthTime.delegate = self
        
        userTableView.dataSource = self
        userTableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

