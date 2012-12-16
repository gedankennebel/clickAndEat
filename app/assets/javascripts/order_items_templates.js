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
    html += "   <h2>Total Amount: </h2>" + getTotalAmount(orderItems).toFixed(2)
    html += "</div>";
    html += "<input id='submitOrder' type='button' value='Submit'>";
    $('#order').html(html);
}

function createOrderItemMonitorHtml(orderItems) {
    var html = "<ul>";
    $.each(orderItems, function (index, orderItem) {
        html += "<li>";
        html += "   <div class='orderItemMonitor' id='" + orderItem.id + "'>";
        html += "      <p>" + orderItem.item.name + " (" + orderItem.quantity + ")</p>";
        html += "      <p>" + orderItem.cooked + "</p>";
        html += "      <p>" + orderItem.served + "</p>";
        html += "      <input type='submit' class='cooked' value='Cooked'/>";
        html += "      <input type='submit' class='served' value='Served'/>";
        html += "   </div>";
        html += "</li>";
    });
    html += "</ul>";
    return html;
}
