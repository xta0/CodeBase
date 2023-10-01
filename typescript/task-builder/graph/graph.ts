import { taskBuilder } from "../GlobalTaskBuilder";
import { task1, task2a, task2b, task3 } from "../tasks/task";

export const graph1 = taskBuilder.graph(
    {
        name: "graph1",
        chronicleEvent: "graph1",
        expectsFields: ['runID', 'buckBuildID'],
        assignsFields: []
    },[
        task1, // <-- existing task (step, graph or decider)
        task2a.runAfter(task1), // <-- task dependencies
        task2b.runAfter(task1),
        task3.runAfter(task2a, task2b),
    ]
)