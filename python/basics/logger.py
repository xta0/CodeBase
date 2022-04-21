from time import perf_counter
from functools import wraps
from datetime import datetime, timezone

def logged(fn):
    @wraps(fn)
    def closure(*args, **kwargs):
        run_dt = datetime.now(timezone.utc)
        
        
    
    