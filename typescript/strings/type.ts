// a string type can be assigned to any string value
let unit: string = "awesome"
// a string literal type can only be assigned to the value of the string literal
let miles: "MILES" = "MILES"
// or null
//let miles: "MILES" = null
type distanceMetric = "MILES" | "KILOMETERS" | "METERS" | "YARDS" | "FEET" | "INCES";

function move(distance: number, value: distanceMetric) {
    console.log(`you moved ${distance} ${value}`)
}

// the second parameter has to be one of the distanceMetric
// move(10, "abc") //error
move(10, "MILES")