u = User.create(email: "admin@admin.com", password: "123456")

x=1
5.times do
  Price.create(amount: (x*100), description: "simple description")
  x=x+1
end

x = 1
5.times do
  plan = Plan.create(name: "Plan Sell-#{x}", short_name: "P#{x}", description: "dummy text")
  plan.price_id = Price.all[x-1].id
  plan.save
  x = x+1
end

