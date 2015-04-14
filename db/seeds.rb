d = Department.create title: 'Numero Uno'
e  = d.employees.create email: 'employee@company.org',       password: Devise.friendly_token[0,20]
b  = d.employees.create email: 'boss@company.org',           password: Devise.friendly_token[0,20]
bk = d.employees.create email: 'bookkeeper@company.org',     password: Devise.friendly_token[0,20]
bk.roles << :bookkeeper
b.boss_of = d