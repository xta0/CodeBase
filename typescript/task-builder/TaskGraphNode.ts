/**
 * This software contains information and intellectual property that is
 * confidential and proprietary to Facebook, Inc. and its affiliates.
 */

import {EventEmitter} from 'events';
import {Task} from './Task';
import {TaskBase} from './TaskBase';

////////////////////////////////////////////////////////////////////////////////

export type TaskGraphNodeOptions<Context> = {
  dependencies: TaskBase<Context>[];
  progressWeight: number;
  logStreamMode: 'discard' | 'buffer' | 'live';
};

////////////////////////////////////////////////////////////////////////////////

/**
 * Represents a node in a TaskGraph instance, wrapping a Task.
 */
export class TaskGraphNode<
  // eslint-disable-next-line @typescript-eslint/ban-types -- Please fix as you edit this code
  Context extends object,
  ExpectedFields extends keyof Context,
  AssignedFields extends keyof Context,
> extends EventEmitter {
  public options: TaskGraphNodeOptions<Context>;
  public weightedProgress: number;

  constructor(
    public task: Task<Context, ExpectedFields, AssignedFields>,
    options: Partial<TaskGraphNodeOptions<Context>> = {},
  ) {
    super();
    this.options = {dependencies: [], progressWeight: 1, logStreamMode: 'live', ...options};
    this.weightedProgress = 0.0;
    task.on('progress', (progress: number) => {
      this.weightedProgress = this.options.progressWeight * progress;
      this.emit('progressUpdate');
    });
  }
}
