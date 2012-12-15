$(document).ready(function () {

    // variables  #############################################################
    var _orderItems;

    // init  ##################################################################
    getOrderItems();

    // Event Handler  #########################################################
    $("#monitor").on('click', '.cooked', function () {
        var orderItem = getOrderItemById(_orderItems, this.parentNode.id);
        orderItem.cooked = true;
        updateOrderItem(orderItem);
    });

    $("#monitor").on('click', '.served', function () {
        var orderItem = getOrderItemById(_orderItems, this.parentNode.id);
        orderItem.served = true;
        updateOrderItem(orderItem);
    });

    // AJAX   #################################################################

    function getOrderItems() {
        $.ajax({
            url:document.URL,
            dataType:'json'
        }).done(function (orderItems) {
                _orderItems = orderItems;
                $('#monitor').html(createOrderItemMonitorHtml(orderItems));
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
                getOrderItems();
            });
    }
});
