# эта функция относится к библиотеке jbuilder
# она берет ruby-объект ( данном случае - @comments) и формирует массив хэшей
# структура единичного хэша задается partial-ом

json.array! @comments, partial: 'comments/comment', as: :comment

# а формат вывода на экран задается React-компонентом : CommentSection, который использует этот паршиал для генерации данных (см. show.erb -> app/assets/javascripts/components/comment_section.es6)