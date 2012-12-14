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

function getOrderItemById(orderItems, orderItemId) {
    var result;
    $.each(orderItems, function (index, orderItem) {
        if (orderItem.id == orderItemId) {
            result = orderItem;
        }
    });
    return result;
}
