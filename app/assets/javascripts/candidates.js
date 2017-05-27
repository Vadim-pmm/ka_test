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
                // src может быть не только ссылкой на img, но и собственно контентом в формате URI
                $('#img_prev').attr('src', e.target.result);
            };
            // readAsDataURL - грузит файл в формате data URI
            // это происходит в формате HTTP-запроса (т.е. нужно настроить обработчик onload)
            reader.readAsDataURL(input.files[0]);
        }
    }

    $("#avatar-upload").change(function(){
        $('#img_prev').removeClass('hidden');
        readURL(this);
    });
});