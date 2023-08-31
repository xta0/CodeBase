import {taskBuilder} from '../GlobalTaskBuilder'
export const build = taskBuilder.step(
    {
        name: "build",
        chronicleEvent: 'buck build',
        logToChronicle: true,
        expectsFields: ['runID'],
        assignsFields: ['buckBuildID']
    },
   async (context, metaContext) => {
        setTimeout(() => {
            console.log("context.id: ", context.runID)
            console.log("context.id: ", metaContext.reportStatus)
        }, 2.0);
   }
);