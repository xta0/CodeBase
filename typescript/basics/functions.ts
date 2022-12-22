/////////////////////////////////////////////////
// function overload

type Combinable = string | number
type Numeric = number | boolean;

type Universal = Combinable | Numeric;

function add1(a: number, b: number): number;
function add1(a: Combinable, b: Combinable) {
    if( typeof a === 'string' || typeof b === 'string'){
        return a.toString() + b.toString();
    }
    return a + b;
}