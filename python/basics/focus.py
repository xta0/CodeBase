import asyncio
import json
import time
import subprocess
from typing import TypeVar
import aiofiles
from dataclasses import dataclass, field
from typing import Any, Awaitable, Callable, Dict, Generic, List, Optional

T = TypeVar("T")

@dataclass
class RunState:
    state: str = None
    
    
@dataclass
class FocusStep(Generic[T]):
    step: Callable[[T], Awaitable[None]]

# a decorator factory
def focus_step( ) -> Callable[[Callable[[T], Awaitable[None]]], FocusStep[T]]:
    # first define a decorator
    def focus_step_decorator(func: Callable[[T], Awaitable[None]]) -> FocusStep[T]:
         step = FocusStep(
            step = func,
        )
         return step
    return focus_step_decorator


def async_group(*original_steps: FocusStep[T]) -> FocusStep[T]:
    @focus_step()
    async def _async_group(run_state: T) -> None:
        coros = [
            # original_step.step(run_state)
            asyncio.create_task(original_step.step(run_state))
            for original_step in original_steps
        ]
        results = await asyncio.gather(*coros, return_exceptions=True)
        for result in results:
            print(result)
            if isinstance(result, BaseException):
                raise result
    return _async_group



@focus_step()
async def test1(run_state: RunState) -> None:
    print("test1 is running")
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
    # await asyncio.sleep(2)
    proc = await asyncio.create_subprocess_shell(
        cmd = "ls -al",
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.PIPE)
    stdout, stderr = await proc.communicate()
    print("async test1 is done")
    return stdout, stderr
    
@focus_step()
async def async_test2(run_state: RunState):
    print("async test2 is running")
    proc = await asyncio.create_subprocess_shell(
        cmd = "ls -al",
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.PIPE)
    stdout, stderr = await proc.communicate()
    print("async test2 is done")
    return stdout, stderr
###########

async def perform_steps(
    steps: List[FocusStep[T]],
    run_state: T,
) -> int:
    # coros = [
    #     step.step(run_state)
#     for step in steps
    # ]
    # await asyncio.gather(*coros)
    
    for step in steps:
        await step.step(run_state)

    return 0


def focus_steps(  # noqa C901 No, you're too complex
    *steps: FocusStep[T],
) -> Callable[[T], Awaitable[int]]:
    async def inner(run_state: T, *, should_log: bool = False) -> int:
        exit_code = await perform_steps(
            list(steps), run_state
        )
        return exit_code
    return inner

def steps() -> Callable[[RunState], Awaitable[int]]:
    return focus_steps (
        test1,
        test2,
        async_group(
            async_test1,
            async_test2
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
    main()
