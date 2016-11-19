
import Foundation
import Firebase

struct Event {
    
    let key: String
    let name: String
    let start: String
    let end: String
    let members: [String]
    let description: String
    let ref: FIRDatabaseReference?
    
    //let length: String
    //let addedByUser: String
    
    //TODO: Add guests/invitees variable
    
    init(name: String, start: String, end: String, members: [String], description: String, key: String = "") {
        // need to add addedByUser: String above when putting in user info
        self.key = key
        self.name = name
        self.start = start
        self.end = end
        self.members = members
        self.description = description
        //self.length = length
        //self.addedByUser = addedByUser
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        start = snapshotValue["start"] as! String
        end = snapshotValue["end"] as! String
        members = snapshotValue["members"] as! [String]
        description = snapshotValue["description"] as! String
        ref = snapshot.ref
        
        //length = snapshotValue["length"] as! String
        //addedByUser = snapshotValue["addedByUser"] as! String
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "start": start,
            "end": end,
            "members": members,
            "description": description
        ]
    }
    
}
