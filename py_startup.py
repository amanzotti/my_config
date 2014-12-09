
# from __future__ import print_function
from __future__ import division
print "\n Python start up script from /home/manzotti/.py_startup.py.\n"
import scipy as sp
import numpy as np
import matplotlib.pyplot as plt
import numexpr as ne
import ast
import cProfile
import pstats
import pyfits
import pdb
import os
import cPickle
import pickle
import gc
import IPython
import os
import sys
import time
import subprocess
import glob


from pprint import pprint
import __builtin__


def myhook(value, show=pprint, bltin=__builtin__):
    if value is not None:
        bltin._ = value
        show(value)
sys.displayhook = myhook
del __builtin__


def _ls(options, *files):
    """
    _ls(options, ['fname', ...'])

    Lists the given filenames, or the current directory if none are
    given, with the given options, which should be a string like '-lF'.
    """
    if len(files) == 0:
        args = os.curdir
    else:
        args = ' '.join(files)
    subprocess.Popen('ls %s %s' % (options, args), shell=True)


def ls(*files):
    """Same as 'ls -aF'
    Usage:  >>> ls(['dirname', ...])   (brackets mean [optional]
argument)
    """
    _ls('-aF', *files)


def ll(*files):
    """Same as 'ls -alF'
    Usage:  >>> ll(['dirname', ...])   (brackets mean [optional]
argument)
    """
    _ls('-alF', *files)


def lr(*files):
    """Recursive listing. same as 'ls -aRF'
    Usage:  >>> lr(['dirname', ...])   (brackets mean [optional]
argument)
    """
    _ls('-aRF', *files)

mkdir = os.mkdir


# def rm(*args):
#     """Delete a file or files.
#     Usage:  >>> rm('file.c' [, 'file.h'])  (brackets mean [optional] argument)
#     Alias: delete
#     """
#     filenames = _glob(args)
#     for item in filenames:
#         try:
#             os.remove(item)
#         except os.error, detail:
#             print "%s: %s" % (detail[1], item)


# delete = rm


# def rmdir(directory):
#     """Remove a directory.
#     Usage:  >>> rmdir('dirname')
#     If the directory isn't empty, can recursively delete all sub-files.
#     """
#     try:
#         os.rmdir(directory)
#     except os.error:
#         # directory wasn't empty
#         answer = raw_input(directory + " isn't empty. Delete anyway?[n] ")
#         if answer and answer[0] in 'Yy':
#             subprocess.Popen('rm -rf %s' % directory, shell=True)
#             print directory + ' Deleted.'
#         else:
#             print directory + ' Unharmed.'


def mv(*args):
    """Move files within a filesystem.
    Usage:  >>> mv('file1', ['fileN',] 'fileordir')
    If two arguments - both must be files
    If more arguments - last argument must be a directory
    """
    filenames = _glob(args)
    nfilenames = len(filenames)
    if nfilenames < 2:
        print 'Need at least two arguments'
    elif nfilenames == 2:
        try:
            os.rename(filenames[0], filenames[1])
        except os.error, detail:
            print "%s: %s" % (detail[1], filenames[1])
    else:
        for filename in filenames[:-1]:
            try:
                dest = filenames[-1] + '/' + filename
                if not os.path.isdir(filenames[-1]):
                    print 'Last argument needs to be a directory'
                    return
                os.rename(filename, dest)
            except os.error, detail:
                print "%s: %s" % (detail[1], filename)


def cp(*args):
    """Copy files along with their mode bits.
    Usage:  >>> cp('file1', ['fileN',] 'fileordir')
    If two arguments - both must be files
    If more arguments - last argument must be a directory
    """
    filenames = _glob(args)
    nfilenames = len(filenames)
    if nfilenames < 2:
        print 'Need at least two arguments'
    elif nfilenames == 2:
        try:
            shutil.copy(filenames[0], filenames[1])
        except os.error, detail:
            print "%s: %s" % (detail[1], filenames[1])
    else:
        for filename in filenames[:-1]:
            try:
                dest = filenames[-1] + '/' + filename
                if not os.path.isdir(filenames[-1]):
                    print 'Last argument needs to be a directory'
                    return
                shutil.copy(filename, dest)
            except os.error, detail:
                print "%s: %s" % (detail[1], filename)


def cpr(src, dst):
    """Recursively copy a directory tree to a new location
    Usage:  >>> cpr('directory0', 'newdirectory')
    Symbolic links are copied as links not source files.
    """
    shutil.copytree(src, dst)


def ln(src, dst):
    """Create a symbolic link.
    Usage:  >>> ln('existingfile', 'newlink')
    """
    os.symlink(src, dst)


def lnh(src, dst):
    """Create a hard file system link.
    Usage:  >>> ln('existingfile', 'newlink')
    """
    os.link(src, dst)


def pwd():
    """Print current working directory path.
    Usage:  >>> pwd()
    """
    print os.getcwd()


def env():
    """List environment variables.
    Usage:  >>> env()
    """
    # unfortunately environ is an instance not a dictionary
    envdict = {}
    for key, value in os.environ.items():
        envdict[key] = value
    pprint(envdict)


def syspath():
    """Print the Python path.
    Usage:  >>> syspath()
    """
    import sys
    pprint(sys.path)


def which(object):
    """Print the source file from which a module, class, function, or method
    was imported.

    Usage:    >>> which(mysteryObject)
    Returns:  Tuple with (file_name, line_number) of source file, or None if
              no source file exists
    Alias:    whence
    """
    object_type = type(object)
    if object_type is types.ModuleType:
        if hasattr(object, '__file__'):
            print 'Module from', object.__file__
            return (object.__file__, 1)
        else:
            print 'Built-in module.'
    elif object_type is types.ClassType:
        if object.__module__ == '__main__':
            print 'Built-in class or class loaded from $PYTHONSTARTUP'
        else:
            print 'Class', object.__name__, 'from', \
                sys.modules[object.__module__].__file__
            # Send you to the first line of the __init__ method
            return (sys.modules[object.__module__].__file__,
                    object.__init__.im_func.func_code.co_firstlineno)
    elif object_type in (types.BuiltinFunctionType, types.BuiltinMethodType):
        print "Built-in or extension function/method."
    elif object_type is types.FunctionType:
        print 'Function from', object.func_code.co_filename
        return (object.func_code.co_filename, object.func_code.co_firstlineno)
    elif object_type is types.MethodType:
        print 'Method of class', object.im_class.__name__, 'from',
        fname = sys.modules[object.im_class.__module__].__file__
        print fname
        return (fname, object.im_func.func_code.co_firstlineno)
    else:
        print "argument is not a module or function."
    return None
whence = which
