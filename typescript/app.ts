import fs from 'fs';
import path from 'path';
import {
    Stats,
} from 'node:fs';

// import Stats

// const d1 = fs.statSync('tests/x.json').mtime.getTime();
// console.log(typeof d1)
// const d2 = fs.statSync('app.js').mtime.getTime();
// console.log(d2)
// console.log(d2>d1)

async function process() {
    const stats: Promise<Stats>[] = [];
    for (const dSYMPath of ['x.js', 'app.ts']) {
        stats.push(fs.promises.stat(dSYMPath));
    }
    return (await Promise.all(stats)).map( (stat: Stats) => stat.mtime.getTime())
}
const account = async () => {
    try{
        const mtimes = await process()
        console.log(mtimes)
    } catch(error){
        if(error instanceof Error){
            console.log(error.message)
        }
        
    }
    
    
};
account()

