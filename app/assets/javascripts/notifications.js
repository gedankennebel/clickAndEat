$(document).ready(function () {
    Index.get(function (index) {
        var channel = index.getLink('monitor');
        if (getCurrentPath() != channel) {
            var faye = new Faye.Client('http://localhost:9292/faye');
            faye.subscribe(channel, function (order) {
                updateNotificationsCount(order);
            });
        }
    });
});

function updateNotificationsCount(order) {
    filterOrder(order);
    var notificationCount = $('#notification-count');
    var htmlContent = notificationCount.html();
    var formerCount = parseInt(htmlContent.substring(1, htmlContent.length - 1));
    var newCount = (formerCount + order.order_items.length);
    notificationCount.html('(' + (newCount) + ')');
}


function Index() {
}

Index.get = function (done, fail) {
    $.ajax({
        url:'/',
        dataType:'json'
    }).done(function (index) {
            index.getLink = function (rel) {
                return getLink(rel, this);
            };
            done(index);
        }).fail(function () {
            fail();
        });
};
