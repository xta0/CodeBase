import { applyMiddleware, combineReducers, compose, createStore } from "redux";
import { appReducer } from "./reducers/appReducer";

import { combineEpics, createEpicMiddleware } from "redux-observable";
import { of } from "rxjs";

const epic1 = () => of({type: "SET_NAME", payload:"Bob"});

export function configureRootStore() {
    const rootEpic = combineEpics(epic1)
    const epicMiddleware = createEpicMiddleware()
    const rootReducer = combineReducers({
        app: appReducer
    });
    const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
    const store = createStore(rootReducer, composeEnhancers(applyMiddleware(epicMiddleware)));
    epicMiddleware.run(rootEpic);
    return store;
}