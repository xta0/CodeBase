import {ajax} from "rxjs/ajax"
import { concat, map, switchMap, of, withLatestFrom, pluck } from "rxjs";
import { fetchFulfilled, FETCH_DATA, setStatus } from "../reducers/beersActions";
import { ofType } from "redux-observable";


export function fetchBeearsEpic(action$, state$) {
    return action$.pipe(
        ofType(FETCH_DATA),
        withLatestFrom(state$.pipe(pluck("config", "url"))),
        switchMap(([{payload}, url]) => {
            return concat(
                of(setStatus("pending")),
                ajax.getJSON(url).pipe( //or state$.value.config.url
                    // maps a response to an action
                    map( res => fetchFulfilled(res))
                )
            )
        })
    )
}