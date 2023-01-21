export type Even = 
    | {
        type: "LOG_IN";
        payload: {
            userId: string;  
        };
      } 
    | {
        type: "SIGN_OUT";  
      };

const sendEvent = (evenType: Event["type"], payload?: any) => {};