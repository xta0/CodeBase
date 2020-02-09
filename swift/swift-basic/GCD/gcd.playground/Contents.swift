import UIKit
import Foundation
DispatchQueue.main.async {
    print("main Queue");
}

func call(){
    let q1 = DispatchQueue(label: "q1");
    let q2 = DispatchQueue(label: "q2");
    q1.async {
        for n in 1...3 {
            print("q1:\(n)");
        }
    }
    q2.async {
        for n in 1...3 {
            print("q2:\(n)");
        }
    }
}




func someTask(_ task:@escaping ()->()){
    task();
}

let deadlineTime = DispatchTime.now() + .seconds(1);
    DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
    //perform some code
}


let dispatchGroup = DispatchGroup()

dispatchGroup.enter()
someTask {
    print("Task 1 has been done");
    dispatchGroup.leave();
}
dispatchGroup.notify(queue: DispatchQueue.main, execute: {
    print("group finished!");
})



