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
                    html += "<li><div>";
                    html += "<img src=" + item.picture + ">";
                    html += "<p>" + item.name + "</p>";
                    html += "<p>" + item.price + "€ </p>";
                    html += "</div></li>";
                });
                html += "</ul>";

                $('#items').html(html);
            });
    }

});