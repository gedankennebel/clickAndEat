$(document).ready(function () {
    getFilterDefinition();
});

var _filterDefinition;

function getFilterDefinition() {
    $.ajax({
        url:"/user_account/filter_definition",
        dataType:'json'
    }).done(function (filterDefinition) {
            _filterDefinition = filterDefinition;
        });
}

function filterOrder(order) {
    var filteredOrderItems = [];
    $.each(order.order_items, function (index, order_item) {
        if (!isFiltered(order, order_item))
            filteredOrderItems.push(order_item);
    });
    order.order_items = filteredOrderItems;
}

function isFiltered(order, orderItem) {
    if (_filterDefinition == undefined) {
        return false;
    }

    if (_filterDefinition.cooked != null) {
        if (orderItem.cooked != _filterDefinition.cooked) {
            return true;
        }
    }
    if (_filterDefinition.served != null) {
        if (orderItem.served != _filterDefinition.served) {
            return true;
        }
    }
    if (_filterDefinition.cookable != null) {
        if (orderItem.item.cookable != _filterDefinition.cookable) {
            return true;
        }
    }
    if (_filterDefinition.tables instanceof Array) {
        if (_filterDefinition.tables.length > 0) {
            if (_filterDefinition.tables.indexOf(order.table) == -1) {
                return true;
            }
        }
    } else {
        if (_filterDefinition.tables != null) {
            if (order.table != _filterDefinition.tables) {
                return true;
            }
        }
    }
    return false;
}