import Foundation

//: Problem: How to mutate part of a nested untyped dictionary (e.g. [String:Any])
//: Source: http://stackoverflow.com/questions/40261857/remove-nested-key-from-dictionary
var dict: [String:Any] = [
    "countries": [
        "japan": [
            "capital": "tokyo"
        ]
    ]
]

// normally in other languages like javascript,python, or obj-c, you could do something like:
// `dict["countries"]["japan"]["capital"] = "abc"`
// However, in swift, `dict["countries"]` returns an optional type of `Any?` so we can't
// use subscript to get "japan". Instead we need to cast the type like this:

((dict["countries"] as? [String:Any])?["japan"] as? [String: Any])?["capital"]

// to change the capital, we need to use if-let to unwrap the optionals
if var countries = dict["countries"] as? [String:Any],
    var japan = countries["japan"] as? [String: Any] {
    japan["capital"] = "Beijing"
    countries["japan"] = japan
    dict["countries"] = countries
}

((dict["countries"] as? [String:Any])?["japan"] as? [String: Any])?["capital"] //Beijing


// we can try to use nsdictionary to get access to the value
let capital = (dict as NSDictionary).value(forKeyPath: "countries.japan.capital") //Beijing
// however, since the dict's type is NSDictionary, we can change its internal value
// even in the objc world

// Let's take a step back, see why the type casting fails
var x: Any = 1

// but as soon as `x` has been casted to other type, it becomes an r-value
// (x as? Int) = 2 // error
extension Dictionary {
    subscript(jsonDict key: Key) -> [String:Any]? {
        get {
            return self[key] as? [String:Any]
        }
        set {
            self[key] = newValue as? Value
        }
    }
}

extension Dictionary {
    subscript (string key: Key) -> String? {
        get {
            return self[key] as? String
        }
        set {
            self[key] = newValue as? Value
        }
    }
}

dict[jsonDict: "countries"]?[jsonDict: "japan"]?["capital"] = "Berlin"
dict[jsonDict: "countries"]?[jsonDict: "japan"]?[string: "capital"]?.append("!")
dump(dict)

