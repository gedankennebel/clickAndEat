$(document).ready(function () {

    // init  ##################################################################
    getCategories();
    getOrder();

    // Event Handler  #########################################################
    $("#categories").on('click', 'button', function (i, link) {
        getItems(this.value);
    });

    $("#items").on('click', 'input', function () {
        addToOrder(this.parentNode.id)
    });

    $("#order").on('click', ".plus", function () {
        var orderItemId = this.parentNode.parentNode.id;
        incrementQuantity(1, orderItemId);
    });

    $("#order").on('click', '.minus', function () {
        var orderItemId = this.parentNode.parentNode.id;
        incrementQuantity(-1, orderItemId);
    });

    $('#order').on('click', '#submitOrder', function () {
        submitOrder();
    });
});
// variables  #############################################################
var _order;
var _items;

// AJAX   #################################################################
function getCategories() {
    Index.get(function (index) {
        $.ajax({
            url:index.getLink('current_restaurant'),
            dataType:"json"
        }).done(function (restaurant) {
                $('#categories').html(createCategoriesHtml(restaurant.item_categories));
            });
    });
}

function getItems(url) {
    $.ajax({
        url:url,
        dataType:"json"
    }).done(function (items) {
            _items = items;
            renderItems(items);
        });
}

function addToOrder(itemId) {
    var orderItem = getOrderItemByItemId(_order.order_items, itemId);
    if (orderItem != null) {
        orderItem.quantity++;
    } else {
        var item = getObjectById(_items, itemId);
        var newOrderItem = {id:Math.random(), quantity:1, item:item};
        _order.order_items.push(newOrderItem);
    }
    renderOrderItems(_order.order_items);
}

function getOrder() {
    $.ajax({
        url:document.URL,
        dataType:'json'
    }).done(function (order) {
            _order = order;
            renderOrderItems(order.order_items);
        });
}

function submitOrder() {
    $.ajax({
        url:document.URL,
        type:'put',
        dataType:'json',
        contentType:'application/json; charset=utf-8',
        data:JSON.stringify(_order)
    }).done(function () {
            showSuccess('Successfully submitted order');
        }).fail(function () {
            showError('Failed to save order');
        }).always(function () {
            getOrder();
        });
}

function incrementQuantity(increment, orderItemId) {
    var orderItem = getObjectById(_order.order_items, orderItemId);
    orderItem.quantity += increment;
    if (orderItem.quantity <= 0) {

        _order.order_items.splice(_order.order_items.indexOf(orderItem), 1);
    }
    renderOrderItems(_order.order_items);
}
