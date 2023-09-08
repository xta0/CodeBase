import { RunContext } from "./RunContext";
import { graph1 } from "./graph/graph";
import { TaskGraph } from "./TaskGraph";
import * as log4js from "log4js";


const ctx: RunContext = {
    runID: "build",
    shouldDebug: true,
    buckBuildID: "123"
}
function setupLoging(graph: TaskGraph<RunContext, keyof RunContext, keyof RunContext>) {
  graph.once('start', ({context}) => {
    console.log(context)
    logger1.info(`task: ${graph.name} started`)
  })
  graph.once('end', ({context, error, duration}) => {
    console.log(context)
    console.log(error)
    console.log(duration)
    logger2.info(`task: ${graph.name} eneded`)
  })
}
async function run(context: RunContext) {
    setupLoging(graph1)
    await graph1.run(context)
}

log4js.configure({
    appenders: {
      file: {
        type: 'file',
        filename: './logs/logger1.txt',
      },
    },
    categories: {default: {appenders: ['file'], level: 'debug'}},
  })
const logger1 = log4js.getLogger('logger1')
const logger2 = log4js.getLogger('logger2')

run(ctx)
