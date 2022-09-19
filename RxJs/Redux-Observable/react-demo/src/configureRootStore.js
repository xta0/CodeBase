import { applyMiddleware, combineReducers, compose, createStore } from "redux";
import { appReducer } from "./reducers/appReducer";

import { combineEpics, createEpicMiddleware } from "redux-observable";
import { fetchBeearsEpic } from "./epics/fetchBeers";
import { beersReducer } from "./reducers/beersReducer";
import { configReducer } from "./reducers/configReducer";

export function configureRootStore() {
    const rootEpic = combineEpics(fetchBeearsEpic)
    const epicMiddleware = createEpicMiddleware()
    const rootReducer = combineReducers({
        app: appReducer,
        beers: beersReducer,
        config: configReducer
    });
    const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
    const store = createStore(rootReducer, composeEnhancers(applyMiddleware(epicMiddleware)));
    epicMiddleware.run(rootEpic);
    return store;
}