import os.path
import tempfile

from skygear import static_assets


@static_assets('hello')
def hello():
    dirpath = tempfile.mkdtemp()
    with open(os.path.join(dirpath, 'index.txt'), 'w') as f:
        f.write('Hello World!')
    return dirpath

