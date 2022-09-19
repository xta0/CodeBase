export function appReducer(state = { name: "Alice"}, action){
    switch(action.type) {
        case "SET_NAME": {
            return {
                ...state, // expands the current state
                name: action.payload
            }
        }
        default: return state;
    }
    return state;
}