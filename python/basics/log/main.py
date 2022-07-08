import logging
from setup import setup_logger

# logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s', datefmt='%m/%d/%Y %H:%M:%S')
# logging.info('Hello World')
logger = logging.getLogger(__name__)
setup_logger()
logger.info("info")
logger.debug("debug")
logger.warning("warning")
logger.error("error")

# import traceback
# try:
#     a = [1, 2, 3]
#     val = a[4]
# except IndexError as e:
#     logging.error("error is %s", traceback.format_exc())
    
    
## rotating logs
