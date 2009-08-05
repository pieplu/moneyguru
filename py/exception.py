# Created By: Virgil Dupras
# Created On: 2008-02-15
# $Id$
# Copyright 2009 Hardcoded Software (http://www.hardcoded.net)
# 
# This software is licensed under the "HS" License as described in the "LICENSE" file, 
# which should be included with this package. The terms are also available at 
# http://www.hardcoded.net/licenses/hs_license

class FileFormatError(Exception):
    pass

class FileLoadError(Exception):
    pass

class DuplicateAccountNameError(Exception):
    pass

class OperationAborted(Exception):
    pass