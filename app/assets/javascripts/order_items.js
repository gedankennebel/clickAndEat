$(document).ready(function () {

    // variables  #############################################################
    var _order;

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

    // AJAX   #################################################################
    function getCategories() {
        $.ajax({
            // TODO restaurant_id
            url:'/restaurants/1/item_categories',
            dataType:"json"
        }).done(function (categories) {
                $('#categories').html(createCategoriesHtml(categories));
            });
    }

    function getItems(url) {
        $.ajax({
            url:url,
            dataType:"json"
        }).done(function (items) {
                $('#items').html(createItemsHtml(items));
            });
    }

    function addToOrder(itemId) {
        $.ajax({
            type:'post',
            //TODO HATEOAS
            url:document.URL + '/order_items',
            contentType:'application/json; charset=utf-8',
            dataType:"json",
            data:JSON.stringify({order_id:_order.id, quantity:1, item:{id:itemId}})
        }).always(function () {
                getOrder();
            });
    }

    function getOrder() {
        $.ajax({
            url:document.URL,
            dataType:'json'
        }).done(function (order) {
                _order = order;
                $('#order').html(createOrderItemHtml(order.order_items));
            });
    }

    function incrementQuantity(increment, orderItemId) {
        var orderItem = getOrderItemById(_order.order_items, orderItemId);
        orderItem.quantity += increment;
        $.ajax({
            type:'put',
            url:getSelfLink(orderItem),
            contentType:'application/json; charset=utf-8',
            dataType:"json",
            data:JSON.stringify(orderItem)
        }).always(function () {
                getOrder();
            });
    }

    // HTML templates  ########################################################

    function createCategoriesHtml(categories) {
        var html = "<ul>";
        $.each(categories, function (index, category) {
            html += "<li>" +
                "   <button class='categoryLink'  value='" + category.items + "'> " + category.name + "</button>" +
                "</li>";
        });
        html += "</ul>";
        return html;
    }

    function createItemsHtml(items) {
        var html = "<ul>";
        $.each(items, function (index, item) {
            html += "<li><div class='item' id='" + item.id + "'>";
            html += "   <input type='image'  src='" + item.picture + "'/>";
            html += "   <p>" + item.name + "</p>";
            html += "   <p>#" + item.itemNumber + "</p>";
            html += "   <p>" + parseFloat(item.price).toFixed(2) + "€ </p>";
            html += "</div></li>";
        });
        html += "</ul>";
        return html;
    }

    function createOrderItemHtml(orderItems) {
        var html = "<ul>";
        $.each(orderItems, function (index, orderItem) {
            html += "<li>";
            html += "   <div class='orderItem' id='" + orderItem.id + "'>";
            html += "      <span class='plusminus'>";
            html += "         <input type='image' class='plus' src='/images/plus.png'><br/>";
            html += "         <input type='image' class='minus' src='/images/minus.png'>";
            html += "      </span>";
            html += "      <p>" + orderItem.item.name + " (" + orderItem.quantity + ")</p>";
            html += "      <p>" + (orderItem.item.price * orderItem.quantity).toFixed(2) + "€ </p>";
            html += "   </div>";
            html += "</li>";
        });
        html += "</ul>";
        return html;
    }
});