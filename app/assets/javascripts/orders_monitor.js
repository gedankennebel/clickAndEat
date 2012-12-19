$(document).ready(function () {

//    var faye = new Faye.Client('http://localhost:9292/faye');
//    faye.subscribe("/branches/2/orders", function (data) {
//        console.log(data);
//    });

    // variables  #############################################################
    var _orderItems;

    // init  ##################################################################
    getOrderItems();

    // Event Handler  #########################################################
    $("#monitor").on('click', '.cooked', function () {
        var orderItem = getObjectById(_orderItems, this.parentNode.id);
        orderItem.cooked = true;
        updateOrderItem(orderItem);
    });

    $("#monitor").on('click', '.served', function () {
        var orderItem = getObjectById(_orderItems, this.parentNode.id);
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
