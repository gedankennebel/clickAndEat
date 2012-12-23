$(document).ready(function () {

    var faye = new Faye.Client('http://localhost:9292/faye');
    faye.subscribe(getCurrentPath(), function (order) {
        updateOrdersWithNewOrder(_orders, order);
        renderOrderItemMonitor();
    });

    // init  ##################################################################
    getFilterDefinition();
    getCurrentOrders();

    // Event Handler  #########################################################
    $("#monitor").on('click', '.cooked', function () {
        var orderItem = getObjectById(getOrderItems(_orders), this.parentNode.parentNode.id);
        orderItem.cooked = true;
        updateOrderItem(orderItem);
    });

    $("#monitor").on('click', '.served', function () {
        var orderItem = getObjectById(getOrderItems(_orders), this.parentNode.parentNode.id);
        orderItem.served = true;
        updateOrderItem(orderItem);
    });

    $("#apply").on('click', function () {
        _filterDefinition = $(this.form).serializeObject();
        renderOrderItemMonitor();
        saveFilterDefinition();
    });

    //Periodic refresh (countdown)
    window.setInterval(function () {
        renderOrderItemMonitor();
    }, 10000);
});
// variables  #############################################################
var _orders;
var _filterDefinition;

// AJAX   #################################################################

function getFilterDefinition() {
    $.ajax({
        url:"/user_account/filter_definition",
        dataType:'json'
    }).done(function (filterDefinition) {
            _filterDefinition = filterDefinition;
        });
}
function saveFilterDefinition() {
    $.ajax({
        type:'put',
        url:"/user_account/filter_definition",
        contentType:'application/json; charset=utf-8',
        data:JSON.stringify(_filterDefinition)
    });
}

function getCurrentOrders() {
    $.ajax({
        url:document.URL,
        dataType:'json'
    }).done(function (orders) {
            _orders = orders;
            renderOrderItemMonitor();
        });
}

function updateOrderItem(orderItem) {
    $.ajax({
        type:'put',
        url:getSelfLink(orderItem),
        contentType:'application/json; charset=utf-8',
        dataType:"json",
        data:JSON.stringify(orderItem)
    }).always(function () {
            getCurrentOrders();
        });
}

// Utils
function renderOrderItemMonitor() {
    var filteredOrders = filterOrders(_orders);
    var html = "";
    $.each(filteredOrders, function (index, order) {
        html += createOrderItemMonitorHtml(order);
    });
    $('#monitor').html(html);
}

function filterOrders(orders) {
    var filteredOrders = JSON.parse(JSON.stringify(orders)); // clone
    $.each(filteredOrders, function (index, order) {
        filterOrder(order);
    });
    return filteredOrders;
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

function updateOrdersWithNewOrder(orders, newOrder) {
    var updated = false;
    $.each(orders, function (index, oldOrder) {
        if (oldOrder.id == newOrder.id) {
            orders[index] = newOrder;
            updated = true;
            return false;
        }
    });
    if (!updated) {
        orders.unshift(newOrder); // add at beginning
    }
}

function getOrderItems(orders) {
    var orderItems = [];
    $.each(orders, function (index, order) {
        orderItems.push.apply(orderItems, order.order_items);
    });
    return orderItems;
}
