/**
 * This software contains information and intellectual property that is
 * confidential and proprietary to Facebook, Inc. and its affiliates.
 */

import {Duplex, PassThrough, Readable} from 'stream';
import {EventEmitter} from 'events';

////////////////////////////////////////////////////////////////////////////////

type SubProcess = {stdout: Readable; stderr: Readable};

////////////////////////////////////////////////////////////////////////////////

/**
 * The TerminalBase class is a base for displaying to a terminal any
 * content that's piped into it (such as multiple subsequent processes).
 * There are different implementations for different terminal environments.
 */
export abstract class TerminalBase extends EventEmitter {
  private _stream = new PassThrough();

  /**
   * This low-level `Duplex` stream represents the content that is shown on the terminal.
   * It can be used as:
   * 1. A `Readable` stream, e.g., to log all content to a file on disk.
   * 2. A `Writable` stream, to show custom content in the terminal.
   *    This content can include ANSI escape sequences (e.g., colors). If
   *    you want to use the `chalk` package for this purpose, please use
   *    the `chalk` exported from this module, because the normal package
   *    has its color output disabled for processes that appear not to be
   *    streaming to a terminal.
   */
  get stream(): Duplex {
    return this._stream;
  }

  /**
   * Pipe the stdout and stderr streams from a subprocess to this terminal.
   * The end-signals from those streams will not be propagated, allowing
   * this terminal's stream to stay open for further content.
   */
  pipeProcess({stdout, stderr}: SubProcess): void {
    stdout.pipe(this.stream, {end: false});
    stderr.pipe(this.stream, {end: false});
  }
}

////////////////////////////////////////////////////////////////////////////////
