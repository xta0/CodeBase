# import asyncio

# async def crawl_page(url):
#     print('crawling {}'.format(url))
#     sleep_time = int(url.split('_')[-1])
#     await asyncio.sleep(sleep_time)
#     print('Done {}'.format(url))

# async def main(urls):
#     for url in urls:
#         task = asyncio.create_task(crawl_page(url))
#         await task


# asyncio.run(main(['url_1', 'url_2', 'url_3', 'url_4']))


import asyncio
from re import X

async def worker_1():
    print('worker_1 start')
    await asyncio.sleep(1)
    print('worker_1 done')

async def worker_2():
    print('worker_2 start')
    await asyncio.sleep(2)
    print('worker_2 done')

async def main():
    task1 = asyncio.create_task(worker_1())
    task2 = asyncio.create_task(worker_2())
    print('before await')
    await task1
    print('awaited worker_1')
    await task2
    print('awaited worker_2')

x = main()
print(x)
# asyncio.run(main())

import time
import functools
import logging

def timecoro(corofn):
    @functools.wraps(corofn)
    async def wrapper(*args, **kwargs):
        start = time.time()
        try:
            result = await corofn(*args, **kwargs)
        except Exception:
            finish = time.time() - start
            print('%s failed in %.2f', corofn, finish)
            raise
        else:
            finish = time.time() - start
            print('%s succeeded in %.2f', corofn, finish)
            return result

    return wrapper

f1 = timecoro(worker_1)
asyncio.run(f1())