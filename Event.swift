
import Foundation
import Firebase

struct Event {
    
    let key: String
    let name: String
    let start: String
    let end: String
    //let length: String
    //let addedByUser: String
    let ref: FIRDatabaseReference?
    
    //TODO: Add guests/invitees variable
    
    init(name: String, start: String, end: String, key: String = "") {
        // need to add addedByUser: String above when putting in user info
        self.key = key
        self.name = name
        self.start = start
        self.end = end
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
        //length = snapshotValue["length"] as! String
        //addedByUser = snapshotValue["addedByUser"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "start": start,
            "end": end
        ]
    }
    
}
