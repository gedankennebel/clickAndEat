// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function () {
    console.log('test');
    Index.get(function (index) {
        var channel = index.getLink('monitor');
        if (getCurrentPath() != channel) {
            var faye = new Faye.Client('http://localhost:9292/faye');
            faye.subscribe(channel, function (order) {
                updateNotificationsCount(order);
            });
            console.log(channel);
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


