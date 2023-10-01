// node -r esm "epics.js"
import {filter, mapTo, pipe, tap, Observable,withLatestFrom, map, concatMap} from 'rxjs'
import { combineReducers } from 'redux';
import { combineEpics, createEpicMiddleware, ofType } from 'redux-observable';

const initial_pint_state = {
    value: 0
}
const initial_user_state = {
    names: []
}

//actions
const pingAction = {
    type: "PING",
}
const fetchUsers = user => ({ type: "FETCH_USER", payload: user } )

const fetchUserFullilled = payload => ({ type: "FETCH_USER_FULFILLED", payload });

// reducers
const ping = (state = initial_pint_state, action) => {
  console.log("Entering Reducer: Action: ", action)
    switch (action.type) {
      case 'PING':
        return { ...state, value : state.value + 1 };

      case 'PONG':
        return { ...state, value : state.value - 1 };

      case 'YOLO':
        return { ...state, value : state.value + 100 };

      default:
        return state;
    }
  };

const users = (state = initial_user_state, action) => {
    switch (action.type) {
      case "FETCH_USER_FULFILLED":
        state.names.push(action.payload)
        return state
      default:
        return state;
    }
};

const rootReducer = combineReducers({
    ping,
    users
});


function fake_user_fetch(user) {
  console.log("fetching user: ", user)
  return new Observable( s => setTimeout(()=>s.next(user), 2000))
}

// epics
const pongEpic = action$ => action$.pipe(
    tap( data => console.log('entering pongEpic: ', data)),
    filter(action => action.type === 'PING'),
    tap( data => console.log('leaving pongEpic: ', data)),
    mapTo({ type: 'PONG' })
);

const yoloEpic = action$ => action$.pipe(
  tap( data => console.log('entering yoloEpic: ', data)),
  filter(action => action.type === 'PING'),
  tap( data => console.log('leaving yoloEpic: ', data)),
  mapTo({ type: 'YOLO' })
);



const fetchUsersEpic = (action$, state$) => action$.pipe(
    tap( data => console.log('entering fetchUsersEpic: ', state$.value)),
    ofType('FETCH_USER'),
    concatMap( action =>
        fake_user_fetch(action.payload).pipe(
            map(res => fetchUserFullilled(res)),
            tap(() => console.log("leaving fetchUsersEpic: ", state$.value))
        )
    ),
);

const rootEpic = combineEpics( pongEpic, yoloEpic)

// middleware
const epicMiddleware = createEpicMiddleware();
import { createStore, applyMiddleware } from 'redux';
const store = createStore(
  rootReducer,
  applyMiddleware(epicMiddleware)
);

console.log("store's initial sate: ", store.getState())
epicMiddleware.run(rootEpic);
store.dispatch(pingAction)
console.log("store's end sate: ", store.getState())

// console.log("store's initial sate: ", store.getState())
// store.dispatch(fetchUsers("Alice"))
// setTimeout( () => console.log(store.getState()), 3000)
// console.log("store's end sate: ", store.getState())
