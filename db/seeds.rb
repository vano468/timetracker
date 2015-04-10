d = Department.create title: 'Numero Uno'
e = d.employees.create email: 'employee@company.org', password: Devise.friendly_token[0,20]
b = d.employees.create email: 'boss@company.org',     password: Devise.friendly_token[0,20]
b.boss_of = d
e.records.create type: 'Vacation'
e.records.create