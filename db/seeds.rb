d = Department.create title: 'Numero Uno'
em = d.employees.create email: 'em@isolat.co', password: '123456789'
bs = d.employees.create email: 'bs@isolat.co', password: '123456789'
bk = d.employees.create email: 'bk@isolat.co', password: '123456789'
bk.roles << :bookkeeper
bs.boss_of = d