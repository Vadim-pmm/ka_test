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
