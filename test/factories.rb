Factory.define :user do |f|
  f.sequence(:name) { |i| "User #{i}" }
end

Factory.define :admin, :parent => :user do |f|
  f.sequence(:name) { |i| "Admin #{i}" }
  f.admin true
end

Factory.define :event do |f|
  f.sequence(:name) { |i| "Event test #{i}" }
  f.starts_at 2.days.from_now.to_date
end
