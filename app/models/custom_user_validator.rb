class CustomUserValidator < ActiveModel::Validator
  def validate(record)
    unless record.name =~ /^([А-Я]+\s+){2,}[А-Я]+/i
      record.errors[:name] << 'Ошибочное имя'
    end
  end
end