d1 = Department.create title: 'Numero Uno'
d2 = Department.create title: 'Numero Due'
d1n1 = Department.create title: 'Uno L1V1', parent: d1
d1n2 = Department.create title: 'Uno L1V2', parent: d1
d1n1n1 = Department.create title: 'Uno L2V1.1', parent: d1n1
d1n2n1 = Department.create title: 'Uno L2V2.1', parent: d1n2

em = d1.employees.create email: 'em@isolat.co', password: '123456789'
bs = d1.employees.create email: 'bs@isolat.co', password: '123456789'
bk = d1.employees.create email: 'bk@isolat.co', password: '123456789'

bk.roles << :bookkeeper
bk.save
bs.boss_of = d1