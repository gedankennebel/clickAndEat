$(document).ready(function () {

    var faye = new Faye.Client('http://localhost:9292/faye');
    faye.subscribe(getCurrentPath(), function (order) {
        updateOrdersWithNewOrder(_orders, order);
        renderOrderItemMonitor();
    });

    // init  ##################################################################
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


// AJAX   #################################################################


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
