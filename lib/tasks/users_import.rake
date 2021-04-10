namespace :users do
  task import: :environment  do
    KiprosherProfile.all.each do |k|
      user_attributes = KiprosherProfileSerializer.new(k).to_hash.dig(:data, :attributes)

      user_record = User.find_or_initialize_by(import_key: user_attributes[:id])
      user_record.assign_attributes(user_attributes.except(:id))
      user_record.save(validate: false)
    end
  end
end
