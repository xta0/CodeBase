import {taskBuilder} from '../GlobalTaskBuilder'

export const task1 = taskBuilder.step(
    {
        name: "task1",
        chronicleEvent: 'task1',
        // logToChronicle: true,
        expectsFields: ['runID'],
        assignsFields: ['buckBuildID']
    },
   async (context, _metaContext) => {
        context.buckBuildID = "build_task1"
        setTimeout(() => {
            ('task1 finished!')
            // console.log("context.id: ", context.runID)
            // console.log("context.id: ", _metaContext.reportStatus)
        }, 5.0);
   }
);

task1.on('end', ()=>{
    // console.log("task1 ended")
}).once('start', ()=>{
    // console.log("task1 start")
})

export const task2a = taskBuilder.step(
    {
        name: "task2a",
        chronicleEvent: 'task2a',
        // logToChronicle: true,
        expectsFields: ['runID'],
        assignsFields: ['buckBuildID']
    },
   async (context, _metaContext) => {
        context.buckBuildID = "build_task2a"
        throw new Error("task2a errored out!")
        setTimeout(() => {
            // console.log('task2a finished!')
            // console.log("context.id: ", context.runID)
            // console.log("context.id: ", _metaContext.reportStatus)
        }, 3.0);
   }
);

task2a.on('end', ()=>{
    // console.log("task2a ended")
}).once('start', ()=>{
    // console.log("task2a start")
})

export const task2b = taskBuilder.step(
    {
        name: "task2b",
        chronicleEvent: 'task2b',
        // logToChronicle: true,
        expectsFields: ['runID'],
        assignsFields: ['buckBuildID']
    },
   async (context, _metaContext) => {
        context.buckBuildID = "build_task2b"
        setTimeout(() => {
            // console.log('task2b finished!')
            // console.log("context.id: ", context.runID)
            // console.log("context.id: ", _metaContext.reportStatus)
        }, 1.0);
   }
);

task2b.on('end', ()=>{
    // console.log("task2b ended")
}).once('start', ()=>{
    // console.log("task2b start")
})


export const task3 = taskBuilder.step(
    {
        name: "task3",
        chronicleEvent: 'task3',
        // logToChronicle: true,
        expectsFields: ['runID'],
        assignsFields: ['buckBuildID']
    },
   async (context, _metaContext) => {
        context.buckBuildID = "build_task3"
        setTimeout(() => {
            // console.log('task3 finished!')
            // console.log("context.id: ", context.runID)
            // console.log("context.id: ", _metaContext.reportStatus)
        }, 1.0);
   }
);

task3.on('end', ()=>{
    // console.log("task3 ended")
}).once('start', ()=>{
    // console.log("task3 start")
})
