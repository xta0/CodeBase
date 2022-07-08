import logging

logger = logging.getLogger()
id(logger)
logger.setLevel(logging.INFO)

def setup_logger():
    logger.propagate = False # don't propagate messages to the main logger

    stream_h = logging.StreamHandler()
    file_h = logging.FileHandler('file.log')
    stream_h.setLevel(logging.DEBUG)
    file_h.setLevel(logging.DEBUG)

    fmt = logging.Formatter('%(name)s - %(levelname)s - %(message)s')
    stream_h.setFormatter(fmt)
    file_h.setFormatter(fmt)

    logger.addHandler(stream_h)
    logger.addHandler(file_h)

