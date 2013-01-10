function getLink(rel, hypermedia) {
    var result;
    $.each(hypermedia.links, function (index, link) {
        if (link.rel == rel) {
            result = link;
            return false;
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
            return false;
        }
    });
    return result;
}

function getOrderItemByItemId(orderItems, itemId) {
    var result;
    $.each(orderItems, function (index, orderItem) {
        if (orderItem.item.id == itemId) {
            result = orderItem;
            return false;
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

function showSuccess(message) {
    var selector = '.notice';
    showFlash(selector, message);
}

function showError(message) {
    var selector = '.alert';
    showFlash(selector, message);
}

function showFlash(selector, message) {
    jQuery(selector).html(message);
    jQuery(selector).slideDown('slow');
    jQuery(selector).fadeOut(3000);
}

// jQuery extensions
$.fn.serializeObject = function () {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function () {
        var value;
        try {
            value = JSON.parse(this.value);
        } catch (e) {
            value = this.value;
        }

        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(value);
        } else {
            o[this.name] = value;
        }
    });
    return o;
};

