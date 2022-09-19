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
    switch (action.type) {
      case 'PING':
        return { ...state, value : state.value + 1 };

      case 'PONG':
        return { ...state, value : state.value - 1 };

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



// epics
const pingEpic = action$ => action$.pipe(
    filter(action => action.type === 'PING'),
    mapTo({ type: 'PONG' })
);

function fake_user_fetch(user) {
    console.log("fetching user: ", user)
    return new Observable( s => setTimeout(()=>s.next(user), 2000))
}

const fetchUsersEpic = (action$, state$) => action$.pipe(
    ofType('FETCH_USER'),
    concatMap( action =>
        fake_user_fetch(action.payload).pipe(
            map(res => fetchUserFullilled(res)),
            tap(() => console.log("tapping state: ", state$.value))
        )
    ),
);

const rootEpic = combineEpics( pingEpic, fetchUsersEpic)

// middleware
const epicMiddleware = createEpicMiddleware();
import { createStore, applyMiddleware } from 'redux';

const store = createStore(
  rootReducer,
  applyMiddleware(epicMiddleware)
);
epicMiddleware.run(rootEpic);


// trigger
store.dispatch(pingAction)
console.log(store.getState())
store.dispatch(fetchUsers("Alice"))
setTimeout( () => console.log(store.getState()), 3000)
