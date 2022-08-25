import asyncio
from email.policy import default
import functools
import json
import time
import subprocess
from typing import TypeVar, Dict
from dataclasses import dataclass, field
from typing import Any, Awaitable, Callable, Dict, Generic, List, Optional
import functools
import logging

T = TypeVar("T")


def timecoro(corofn, name, durations):
    "For focus steps in async groups, we use this wrapper to calculate the step duration"
    @functools.wraps(corofn)
    async def wrapper(*args, **kwargs):
        start = time.time()        
        result = await corofn(*args, **kwargs)
        finish = time.time() - start
        durations[name] = finish
        return result
    return wrapper


@dataclass
class RunState:
    state: str = None
    durations: Dict[str, float] = field(default_factory = dict)

    
@dataclass
class FocusStep(Generic[T]):
    step: Callable[[T], Awaitable[None]]
    name: str

# a decorator factory
def focus_step( ) -> Callable[[Callable[[T], Awaitable[None]]], FocusStep[T]]:
    # first define a decorator
    def focus_step_decorator(func: Callable[[T], Awaitable[None]]) -> FocusStep[T]:
         step = FocusStep(step = func, name = func.__name__)
         return step
    return focus_step_decorator


def async_group(*original_steps: FocusStep[T]) -> FocusStep[T]:
    @focus_step()
    async def _async_group(run_state: T) -> None:
        
        coros = []
        for original_step in original_steps:
            s = original_step.step
            x = timecoro(s, original_step.name, run_state.durations)
            coros.append(x(run_state))
        # coros = [
        #     original_step.step(run_state)
        #     # asyncio.create_task(original_step.step(run_state))
        #     for original_step in original_steps
        # ]
        results = await asyncio.gather(*coros, return_exceptions=True)
        for result in results:
            print(result)
            if isinstance(result, BaseException):
                raise result
    return _async_group



@focus_step()
async def get_config(run_state: RunState) -> None:
    print("get_config is running")
    for _ in range(1, 100000):
        pass
    # await asyncio.sleep(0)
    print("get_config is done")
    
@focus_step()
async def test1(run_state: RunState) -> None:
    print("test1 is running")
    await get_config.step(run_state)
    await asyncio.sleep(1)
    print("test1 is done")
    
@focus_step()
async def test2(run_state: RunState) -> None:
    print("test2 is running")
    await asyncio.sleep(1)
    print("test2 is done")


@focus_step()
async def async_test1(run_state: RunState):
    print("async test1 is running")
    await asyncio.sleep(1)
    # proc = await asyncio.create_subprocess_shell(
    #     cmd = "ls -al",
    #     stdout=asyncio.subprocess.DEVNULL,
    #     stderr=asyncio.subprocess.DEVNULL)
    # stdout, stderr = await proc.communicate()
    print("async test1 is done")
    # return stdout, stderr
    
@focus_step()
async def async_test2(run_state: RunState):
    print("async test2 is running")
    time.sleep(2)
    
    # await asyncio.sleep(0)
    # proc = await asyncio.create_subprocess_shell(
    #     cmd = "ls -al",
    #     stdout=asyncio.subprocess.DEVNULL,
    #     stderr=asyncio.subprocess.DEVNULL)
    # stdout, stderr = await proc.communicate()
    print("async test2 is done")
    # return stdout, stderr



import time
async def perform_steps(
    steps: List[FocusStep[T]],
    run_state: T,
) -> int:
    # coros = [
    #     step.step(run_state)
#     for step in steps
    # ]
    # await asyncio.gather(*coros)
    
    duration = run_state.durations
    for step in steps:
        t1 =  time.time()
        await step.step(run_state)
        t2 = time.time()
        d = t2 - t1
        duration[step.name] = d
    print("[Duration]: ", duration)
    return 0


def focus_steps(  # noqa C901 No, you're too complex
    *steps: FocusStep[T],
) -> Callable[[T], Awaitable[int]]:
    async def inner(run_state: T, *, should_log: bool = False) -> int:
        durations: Dict[str, Any] = {}
        durations["total"] = 0
        run_state.durations = durations
        exit_code = await perform_steps(
            list(steps), run_state
        )
        return exit_code
    return inner

def steps() -> Callable[[RunState], Awaitable[int]]:
    return focus_steps (
        # test1,
        # test2,
        async_group(
            get_config,
            async_test2,
            async_test1,
        )
    )

def run(
    steps: Callable[[T], Awaitable[int]],
    run_state: T
) -> None:
     asyncio.run(steps(run_state))


def main():
    run(
        steps(), #steps() returns a coroutine
        RunState()
    )
    
if __name__ == "__main__":
    print("get_config: ", asyncio.iscoroutinefunction(get_config.step))
    print("async_test1: ", asyncio.iscoroutinefunction(async_test1.step))
    main()
    
    
