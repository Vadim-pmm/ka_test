# функция json.somefield относится к библиотеке jbuilder
# она берет ruby-объект ( данном случае - @comments, переданный как параметр) и формирует одиночный хэш
# перечень ключей - слева, значения- справа.

json.id         comment.id
json.body       comment.body
json.rank       comment.rank
json.author     User.find(comment.user_id).name
json.parent_id  comment.parent_id
json.vacancy_id comment.vacancy_id

# ! несмотря на наличие нескольких строк - результат срабатывания этого паршиала - одна строка-хэш
# это видно даже по документации на jbuilder, что дополнение строк просто дополяет хэш.

# более простой синтак сис :
#json.(comment, :id, :body, :rank)
# но в моем случае нужно формировать доп. поле author, поэтому я расписал в столбик