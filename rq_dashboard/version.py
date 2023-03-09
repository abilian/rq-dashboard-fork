import importlib.metadata

def get_version() -> str:
    return importlib.metadata.version("rq-dashboard-fork")


VERSION = get_version()
