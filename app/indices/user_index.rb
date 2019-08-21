ThinkingSphinx::Index.define :user, :with => :active_record do
  # fields
  indexes first_name, :sortable => true
  indexes email
end