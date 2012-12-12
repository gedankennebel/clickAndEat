$(document).ready(function () {

//    $('#categories').html("test");

    function getCategories() {
        $.ajax({
            url:'/restaurants/1/item_categories',
            contentType:'application/json'
        }).done(function (categories) {
                var html = "<ul>";
                $.each(categories, function (index, category) {
                    html += "<li><button class='categoryLink'  value='" + category.items + "'> " + category.name + "</button></li>";
                });
                html += "</ul>";

                $('#categories').html(html);
            });
    }

    getCategories();

    $("#categories").on('click', 'button', function (i, link) {
        getItems(this.value);
    });


    function getItems(url) {
        $.ajax({
            url:url,
            contentType:'application/json'
        }).success(function (items) {
                var html = "<ul>";
                $.each(items, function (index, item) {
                    html += "<li><div class='item'>";
                    html += "<img src=" + item.picture + ">";
                    html += "<p>" + item.name + "</p>";
                    html += "<p>" + item.price + "€ </p>";
                    html += "</div></li>";
                });
                html += "</ul>";

                $('#items').html(html);
            });
    }

    $(".item").on('click', function () {
        addToOrder(1)
    });

    function addToOrder(itemId) {
        $.ajax({
            type:'post',
            url:'/orders/1/order_items',
            contentType:'application/json',
            data:{item:{id:itemId}}
        })
    }

    function getOrderItems() {
        $.ajax({
            url:'/orders/1/order_items',
            contentType:'application/json'
        }).success(function (orderItems) {
                var html = "<ul>";
                $.each(orderItems, function (index, orderItem) {
                    html += "<li><div>";
                    html += "<img src=" + orderItem.item.picture + ">";
                    html += "<p>" + orderItem.item.name + "</p>";
                    html += "<p>" + orderItem.item.price * orderItem.quantity + "€ </p>";
                    html += "</div></li>";
                });
                html += "</ul>";

                $('#order').html(html);
            });
    }

    getOrderItems();

});