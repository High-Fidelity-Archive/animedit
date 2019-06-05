//
//  TreeItem
//
//  Created by Anthony Thibault on 6/5/2019
//  Copyright 2019 High Fidelity, Inc.
//
//  Distributed under the Apache License, Version 2.0.
//  See the accompanying file LICENSE or http://www.apache.org/licenses/LICENSE-2.0.html
//

#include "treeitem.h"
#include <QStringList>

TreeItem::TreeItem(const QList<QVariant>& data, TreeItem* parent) {
    m_parentItem = parent;
    m_itemData = data;
}

TreeItem::~TreeItem()
{
    qDeleteAll(m_childItems);
}

void TreeItem::appendChild(TreeItem *item) {
    m_childItems.append(item);
}

TreeItem* TreeItem::child(int row) {
    return m_childItems.value(row);
}

int TreeItem::childCount() const {
    return m_childItems.count();
}

int TreeItem::columnCount() const {
    return m_itemData.count();
}

QVariant TreeItem::data(int column) const {
    return m_itemData.value(column);
}

TreeItem* TreeItem::parentItem() {
    return m_parentItem;
}

int TreeItem::row() const {
    if (m_parentItem) {
        return m_parentItem->m_childItems.indexOf(const_cast<TreeItem*>(this));
    }

    return 0;
}

