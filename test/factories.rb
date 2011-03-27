Factory.define :user do |f|
  f.sequence(:name) { |i| "User #{i}" }
end

Factory.define :admin, :parent => :user do |f|
  f.sequence(:name) { |i| "Admin #{i}" }
  f.admin true
end

Factory.define :authorization do |f|
  f.association :user, :factory => :user
  f.sequence(:uid) { |i| i.to_s }
  f.provider 'test-provider'
end

Factory.define :event do |f|
  f.sequence(:name) { |i| "Event test #{i}" }
  f.starts_at 2.days.from_now.to_date
end

Factory.define :star do |f|
  f.association :user, :factory => :user
  f.association :event, :factory => :event
end
