function generateId(seed: number) {
    // return seed + '5'
    return seed + 5
}

type TReturnType<T> = T extends (...args: any[]) => infer R ? R : any
type Id = TReturnType<typeof generateId>;

lookupEntity(generateId(10))

function lookupEntity(id: Id) {
    // Id is a dynamic return type
}

// check type at runtime
type UnpackPromise<T> = T extends Promise<infer K>[] ? K : any;
const arr = [Promise.resolve(true)];
type ExpectedBoolean = UnpackPromise<typeof arr>;