Factory.define :event do |f|
  f.sequence(:name) { |i| "Event test #{i}" }
  f.starts_at 2.days.from_now.to_date
end
