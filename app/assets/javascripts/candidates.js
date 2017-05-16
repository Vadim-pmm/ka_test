// тэг autocomplete-source заполняется во вьюхе профиля кандидата
// на небольших данных пусть так - работать быстрее будет.

$(document).ready(function() {
    $('#newskill').autocomplete({
        source: $('#newskill').data('autocomplete-source'),
        messages: {
            noResults: '',
            results: function() {}
    }});
})


$(function() {
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#img_prev').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        }
    }

    $("#avatar-upload").change(function(){
        $('#img_prev').removeClass('hidden');
        readURL(this);
    });
});