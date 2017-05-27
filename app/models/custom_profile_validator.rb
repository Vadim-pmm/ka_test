class CustomProfileValidator < ActiveModel::Validator
  def validate(record)
    unless record.phone.nil?
      record.phone.delete!("^0-9")
      unless record.phone.length == 10
        record.errors[:phone] << 'Введите корректный номер телефона'
        false
      end
    end
  end
end