# how to use py2exe to package .py files
# https://downloads.sourceforge.net/project/py2exe/py2exe/0.6.9/py2exe-0.6.9.win32-py2.7.exe?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fpy2exe%2Ffiles%2Fpy2exe%2F&ts=1504634247&use_mirror=nchc
# python setup1.py py2exe
# setup1.py

# pyinstaller -F --icon="name.ico" name.py

from distutils.core import setup
import py2exe
options = {
    "py2exe":{
        "compressed": 1,
        "optimize": 2,
        "bundle_files":1
    }
}

setup(
    console=["mainforpy2exe.py"],
    options=options,
    zipfile=None
    )