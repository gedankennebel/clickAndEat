$(document).ready(function () {

    var faye = new Faye.Client('http://localhost:9292/faye');
    faye.subscribe(getCurrentPath(), function (order) {
        getCurrentOrders();
//        alert(data);
    });

    // init  ##################################################################
    getCurrentOrders();

    // Event Handler  #########################################################
    $("#monitor").on('click', '.cooked', function () {
        var orderItem = getObjectById(getOrderItems(), this.parentNode.parentNode.id);
        orderItem.cooked = true;
        updateOrderItem(orderItem);
    });

    $("#monitor").on('click', '.served', function () {
        var orderItem = getObjectById(getOrderItems(), this.parentNode.parentNode.id);
        orderItem.served = true;
        updateOrderItem(orderItem);
    });

});
// variables  #############################################################
var _orders;

// AJAX   #################################################################

function getCurrentOrders() {
    $.ajax({
        url:document.URL,
        dataType:'json'
    }).done(function (orders) {
            _orders = orders;
            var html = "";
            $.each(orders, function (index, order) {
                html += createOrderItemMonitorHtml(order);
            });
            $('#monitor').html(html);
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

function getOrderItems() {
    var orderItems = [];
    $.each(_orders, function (index, order) {
        orderItems.push.apply(orderItems, order.order_items);
    });
    return orderItems;
}
