//
//  ViewController.swift
//  Scheduler_1
//
//  Created by Ben Baker on 10/15/16.
//  Copyright © 2016 Ben Baker. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var usernameArray = [String]()
    var startTime = String()
    var endTime = String()
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
    
    // MARK: IB Actions
    
    @IBAction func addUser(_ sender: UIButton) {
        let usernameValue = String(describing: usernameText.text!)
        usernameArray.append(usernameValue)
        userTableView.reloadData()
        usernameText.text = ""
    }
    
    @IBAction func createEvent(_ sender: UIButton) {
        var newEvent = Event()
        newEvent.name = eventName.text!
        newEvent.start = startTime
        newEvent.start = endTime
        newEvent.members = usernameArray
        newEvent.details = eventDetails.text!
        eventList.append(newEvent)
        
        // resets all variable and clears the screen
        eventName.text = ""
        startDateText.text = ""
        endDateText.text = ""
        eventDetails.text = ""
        usernameArray = []
        userTableView.reloadData()
        EventsViewController.eventTableView.reloadData()
    }

    // MARK: TextField Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let datePicker = UIDatePicker()
        startDateText.inputView = datePicker
        endDateText.inputView = datePicker
        if textField == startDateText{
            datePicker.addTarget(self, action: #selector(ViewController.startDatePickerChanged(_:)), for: .valueChanged)
        } else {
            datePicker.addTarget(self, action: #selector(ViewController.endDatePickerChanged(_:)), for: .valueChanged)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        startDateText.resignFirstResponder()
        endDateText.resignFirstResponder()
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
        
        userTableView.dataSource = self
        userTableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class Event {
    
    var name: String
    var start: String           // start date and time of the event
    var end: String             // end date and time of the event
    var members: [String]
    var details: String
    
    init(){
        name = ""
        start = ""
        end = ""
        members = []
        details = ""
    }
    // TODO: add getter functions for each variable of the class
}

