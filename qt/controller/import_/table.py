# -*- coding: utf-8 -*-
# Created By: Virgil Dupras
# Created On: 2009-11-13
# $Id$
# Copyright 2009 Hardcoded Software (http://www.hardcoded.net)
# 
# This software is licensed under the "HS" License as described in the "LICENSE" file, 
# which should be included with this package. The terms are also available at 
# http://www.hardcoded.net/licenses/hs_license

from PyQt4.QtCore import Qt, QMimeData, QByteArray
from PyQt4.QtGui import QPixmap

from moneyguru.gui.import_table import ImportTable as ImportTableModel
from ..column import Column
from ..table import Table

MIME_INDEXES = 'application/moneyguru.rowindexes'

class ImportTable(Table):
    COLUMNS = [
        Column('will_import', '', 20),
        Column('date', 'Date', 80),
        Column('description', 'Description', 90),
        Column('amount', 'Amount', 90, alignment=Qt.AlignRight),
        Column('bound', '', 22),
        Column('date_import', 'Date', 80),
        Column('description_import', 'Description', 90),
        Column('payee_import', 'Payee', 90),
        Column('checkno_import', 'Check #', 57),
        Column('transfer_import', 'Transfer', 90),
        Column('amount_import', 'Amount', 90, alignment=Qt.AlignRight),
    ]
        
    def __init__(self, importWindow, view):
        model = ImportTableModel(view=self, import_window=importWindow.model)
        Table.__init__(self, model, view)
        self.view.clicked.connect(self.cellClicked)
        self.view.spacePressed.connect(self.spacePressed)
    
    #--- Data methods override
    def _getData(self, row, column, role):
        if column.attrname == 'will_import':
            if role == Qt.CheckStateRole:
                return Qt.Checked if row.will_import else Qt.Unchecked
            else:
                return None
        elif column.attrname == 'bound':
            if role == Qt.DecorationRole:
                return QPixmap(':/lock_12') if row.bound else None
            else:
                return None
        else:
            return Table._getData(self, row, column, role)
    
    def _getFlags(self, row, column):
        flags = Table._getFlags(self, row, column)
        if column.attrname == 'will_import':
            flags |= Qt.ItemIsUserCheckable | Qt.ItemIsEditable
            if not row.can_edit_will_import:
                flags &= ~Qt.ItemIsEnabled
        if not row.bound:
            flags |= Qt.ItemIsDragEnabled | Qt.ItemIsDropEnabled
        return flags
    
    def _setData(self, row, column, value, role):
        if column.attrname == 'will_import':
            if role == Qt.CheckStateRole:
                row.will_import = value.toBool()
                return True
            else:
                return False
        else:
            return Table._setData(self, row, column, value, role)
    
    #--- Drag & Drop
    def dropMimeData(self, mimeData, action, row, column, parentIndex):
        if not mimeData.hasFormat(MIME_INDEXES):
            return False
        if not parentIndex.isValid():
            return False
        indexes = map(int, unicode(mimeData.data(MIME_INDEXES)).split(','))
        if len(indexes) != 1:
            return False
        index = indexes[0]
        if not self.model.can_bind(index, parentIndex.row()):
            return False
        self.model.bind(index, parentIndex.row())
        return True
    
    def mimeData(self, indexes):
        rows = set(unicode(index.row()) for index in indexes)
        data = ','.join(rows)
        mimeData = QMimeData()
        mimeData.setData(MIME_INDEXES, QByteArray(data))
        return mimeData
    
    def mimeTypes(self):
        return [MIME_INDEXES]
    
    def supportedDropActions(self):
        return Qt.MoveAction
    
    #--- Event Handling
    def cellClicked(self, index):
        rowattr = self.COLUMNS[index.column()].attrname
        if rowattr == 'bound':
            self.model.unbind(index.row())
    
    def spacePressed(self):
        selectedIndexes = self.view.selectionModel().selectedRows()
        for index in selectedIndexes:
            row = self.model[index.row()]
            row.will_import = not row.will_import
        self.refresh()
    