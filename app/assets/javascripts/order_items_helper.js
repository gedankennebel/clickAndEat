function getLink(rel, hypermedia) {
    var result;
    $.each(hypermedia.links, function (index, link) {
        if (link.rel == rel) {
            console.log('link');
            console.log(link);
            result = link;
        }
    });
    return result.href;
}

function getSelfLink(hypermedia) {
    return getLink('self', hypermedia);
}

function getObjectById(objectList, id) {
    var result;
    $.each(objectList, function (index, orderItem) {
        if (orderItem.id == id) {
            result = orderItem;
        }
    });
    return result;
}

function getOrderItemByItemId(orderItems, itemId) {
    var result;
    $.each(orderItems, function (index, orderItem) {
        if (orderItem.item.id == itemId) {
            result = orderItem;
        }
    });
    return result;
}

function getTotalAmount(orderItems) {
    var result = 0;
    $.each(orderItems, function (index, orderItem) {
        result += orderItem.quantity * orderItem.item.price;
    });
    return result;
}

function getCurrentPath() {
    var l = document.createElement("a");
    l.href = document.URL;
    return l.pathname;
}
