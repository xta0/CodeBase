import { createStore } from 'redux'

// Define an initial state value for the app
const initialState = {
    value: 0
}

function rootReducer(state = initialState, action) {
    switch(action.type) {
        case 'increase':
            return { ...state, value: state.value + 1}
        case 'decrease':
            return { ...state, value: state.value - 1}
        default:
            return state
    }
}

const store = createStore(rootReducer)
console.log(store.getState())

store.dispatch({type: 'increase'})
console.log(store.getState())

setTimeout( ()=>{
    store.dispatch({type: 'decrease'})
    console.log(store.getState())
},1000)
