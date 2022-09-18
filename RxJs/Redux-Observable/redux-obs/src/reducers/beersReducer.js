import { FETCH_DATA, FETCH_FULFILLED, SET_STATUS } from "./beersActions";

const initialState = {
    data: [],
    status: "idle"
};

export function beersReducer(state = initialState, action) {
    switch(action.type){
        case FETCH_FULFILLED: {
            return {
                ...state,
                status: "success",
                data: action.payload
            }
        }
        case SET_STATUS: {
            return {
                ...state,
                status: action.playload
            }
        }
        case FETCH_DATA: {
            console.log("[DEBUG] action: FETCH_DATA")
            return state
        }
        default: { return state }
    }
}