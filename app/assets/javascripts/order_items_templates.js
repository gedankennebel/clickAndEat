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

function renderItems(items) {
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
    $('#items').html(html);
}

function renderOrderItems(orderItems) {
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
    html += "<div class='totalAmount'>";
    html += "   <h2>Total Amount: </h2>" + getTotalAmount(orderItems).toFixed(2);
    html += "</div>";
    html += "<input id='submitOrder' type='button' value='Submit'>";
    $('#order').html(html);
}

function createOrderItemMonitorHtml(order) {
    var html = "<ul>";
    $.each(order.order_items, function (index, orderItem) {
        var cookedDisabled = orderItem.cooked ? "disabled" : "";
        var servedDisabled = orderItem.served ? "disabled" : "";
        var timeLeft = getMinutesLeft(orderItem.item, order);
        var timeUpClass = timeLeft < 0 ? 'timeUp' : '';

        html += "<li>";
        html += "   <table class='orderItemMonitor " + timeUpClass + "'>";
        html += "       <tr id='" + orderItem.id + "'>";
        html += "         <td>" + orderItem.item.name + " (" + orderItem.quantity + ")</td>";
        html += "         <td>";
        html += "           <p>Table: " + order.table + "</p>";
        html += "           <p>Order: " + order.id + "</p>";
        html += "         </td>";
        html += "         <td>";
        html += "           <p>Time&nbsp;remaining:</p>";
        html += "           <p class='timer'>" + timeLeft + "&nbsp;min</p>";
        html += "         </td>";
        html += "         <td><input type='submit' class='cooked button' value='Cooked' " + cookedDisabled + "/></td>";
        html += "         <td><input type='submit' class='served button' value='Served' " + servedDisabled + "/></td>";
        html += "       <tr>";
        html += "   </table>";
        html += "</li>";
    });
    html += "</ul>";
    return html;
}

function getMinutesLeft(item, order) {
    var createdAt = Date.parse(order.created_at);
    var now = new Date();
    var cooktimeMs = item.cooktime * 60 * 1000;

    var endTime = createdAt + cooktimeMs;
    return ((endTime - now) / (60 * 1000)).toFixed(0);
}
