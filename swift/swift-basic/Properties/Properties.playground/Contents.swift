import UIKit

/*
 Two types of properties
 
 1. Store Property
    - struct
    - class
 2. Computed Property
    - struct
    - class
    - enums

 */

/*
 ====
 Store Properties
 ====
 */
struct FixedLengthRange{
    var firstValue: Int
    let length: Int //let is constant
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue - 6;




/*
 ====
 Computed Properties
 ====
 */
class T{
    
    //readonly
    var foo: Double {
        get{
            return 1.0
        }
        set ( newValue ) {
            
        }
    }
}


struct Card{
    var selected:Bool = false
//    init(selected: Bool){
//        self.selected = selected
//    }
}

let cards:[Card] = [Card(selected: true),Card(selected: true)]

for var card in cards {
    card.selected = true
}

print(cards[1].selected)


/*
 ====
 Properties Observers
 ====
 */

//lazy var does not have didset mathod
