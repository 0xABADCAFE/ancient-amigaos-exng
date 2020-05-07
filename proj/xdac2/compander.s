#NO_APP
.text
LC0:
	.ascii "bad_alloc\0"
LC1:
	.ascii "%5ld \0"
	.even
.globl _dumpDecode__9CompanderPl
_dumpDecode__9CompanderPl:
	pea a5@
	movel sp,a5
	moveml #0x2038,sp@-
	movel a5@(12),a4
	clrl d2
	lea _printf,a3
	lea _putchar,a2
	.even
L102:
	movel a4@(d2:l:4),sp@-
	pea LC1
	jbsr a3@
	addql #2,d2
	addql #8,sp
	bftst d2{#28:#4}
	jne L101
	pea 10:w
	jbsr a2@
	addql #4,sp
L101:
	cmpl #255,d2
	jle L102
	pea 10:w
	jbsr a2@
	moveml a5@(-16),#0x1c04
	unlk a5
	rts
.globl __15BinaryCompander$decTab
.data
	.even
__15BinaryCompander$decTab:
	.long 0
.globl __15BinaryCompander$encTab
	.even
__15BinaryCompander$encTab:
	.long 0
.globl __15BinaryCompander$count
	.even
__15BinaryCompander$count:
	.long 0
.text
LC2:
	.ascii "-- constructing BinaryCompander --\0"
	.even
.globl ___15BinaryCompander
___15BinaryCompander:
	link a5,#-56
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-52)
	movel a5@(8),a0
	movel #___vt_9Compander,a0@
	movel a5@(-52),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L111,a5@(-12)
	movel sp,a5@(-8)
	jra L110
	.even
L111:
	jra L126
	.even
L110:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a0
	movel #___vt_15BinaryCompander,a0@
	clrl sp@-
	pea LC2
	movel a5@(-52),a1
	addql #4,a1
	movel a1,a5@(-56)
	jbsr _printDebug__9SystemLibPCci
	addql #8,sp
	movel __15BinaryCompander$count,d0
	jne L112
	jbsr _initTables__15BinaryCompander
	tstb d0
	jeq L114
	addql #1,__15BinaryCompander$count
	jra L114
	.even
L112:
	addql #1,d0
	movel d0,__15BinaryCompander$count
L114:
	movel a5@(-52),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L125
	.even
L126:
L108:
	movel a5@(-56),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L119,a5@(-36)
	movel sp,a5@(-32)
	jra L118
	.even
L119:
	jra L127
	.even
L118:
	lea a5@(-48),a0
	movel a5@(-56),a1
	movel a0,a1@
	movel a5@(8),a1
	movel #___vt_9Compander,a1@
	movel a5@(-56),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L127:
L116:
	jbsr ___terminate
	.even
L125:
	moveml a5@(-168),#0x5cfc
	fmovem a5@(-128),#0x3f
	unlk a5
	rts
LC3:
	.ascii "--- destroying BinaryCompander ---\0"
	.even
.globl __$_15BinaryCompander
__$_15BinaryCompander:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel #___vt_15BinaryCompander,a2@
	movel __15BinaryCompander$count,d0
	jle L129
	movel d0,d1
	subql #1,d1
	movel d1,__15BinaryCompander$count
	moveq #1,d1
	cmpl d0,d1
	jne L129
	jbsr _destroyTables__15BinaryCompander
L129:
	clrl sp@-
	pea LC3
	jbsr _printDebug__9SystemLibPCci
	addql #8,sp
	movel #___vt_9Compander,a2@
	movel a5@(12),d0
	btst #0,d0
	jeq L135
	movel a2,sp@-
	jbsr ___builtin_delete
L135:
	movel a5@(-4),a2
	unlk a5
	rts
LC4:
	.ascii "BinaryCompander::initTables() - unable to allocate table space\0"
	.even
LC5:
	.long 0
	.long 8
	.long 16
	.long 24
	.long 32
	.long 48
	.long 64
	.long 128
	.long 256
	.long 512
	.long 1024
	.long 2048
	.long 4096
	.long 8192
	.long 16384
	.long 32768
	.even
LC6:
	.long 1
	.long 1
	.long 1
	.long 1
	.long 2
	.long 2
	.long 8
	.long 16
	.long 32
	.long 64
	.long 128
	.long 256
	.long 512
	.long 1024
	.long 2048
	.long 4096
LC7:
	.ascii "BinaryCompander::initTables() - created tables\0"
	.even
.globl _initTables__15BinaryCompander
_initTables__15BinaryCompander:
	link a5,#-128
	moveml #0x3830,sp@-
	clrl sp@-
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel #66560,sp@-
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	addw #12,sp
	tstl d0
	jne L137
	pea 2:w
	pea LC4
	jbsr _printDebug__9SystemLibPCci
	clrb d0
	jra L144
	.even
L137:
	movel d0,__15BinaryCompander$decTab
	addl #1024,d0
	movel d0,__15BinaryCompander$encTab
	moveq #-64,d2
	addl a5,d2
	pea 64:w
	movel d2,sp@-
	pea LC5
	lea _bcopy,a2
	jbsr a2@
	addw #12,sp
	moveq #-128,d3
	addl a5,d3
	pea 64:w
	movel d3,sp@-
	pea LC6
	jbsr a2@
	addw #12,sp
	movel __15BinaryCompander$decTab,a1
	clrl d4
	movel d3,a3
	movel d2,a2
	.even
L141:
	bfextu d4{#28:#3},d0
	bfextu d4{#24:#4},d1
	mulsl a3@(d1:l:4),d0
	movel a1,a0
	addl a2@(d1:l:4),d0
	movel d0,a1@+
	btst #0,d4
	jeq L140
	negl a0@
L140:
	addql #1,d4
	cmpl #255,d4
	jle L141
	clrl sp@-
	pea LC7
	jbsr _printDebug__9SystemLibPCci
	moveq #1,d0
L144:
	moveml a5@(-148),#0xc1c
	unlk a5
	rts
LC8:
	.ascii "BinaryCompander::destroyTables() - destroyed tables\0"
	.even
.globl _destroyTables__15BinaryCompander
_destroyTables__15BinaryCompander:
	pea a5@
	movel sp,a5
	movel __15BinaryCompander$decTab,d0
	jeq L146
	movel d0,sp@-
	jbsr _free__3MemPv
	clrl __15BinaryCompander$decTab
	clrl __15BinaryCompander$encTab
	clrl sp@-
	pea LC8
	jbsr _printDebug__9SystemLibPCci
L146:
	unlk a5
	rts
LC9:
	.ascii "BinaryCompander::dumpDecCurve() - no table\0"
LC10:
	.ascii "Binary companding curve (positive half only)\0"
	.even
.globl _dumpDecodeCurve__15BinaryCompander
_dumpDecodeCurve__15BinaryCompander:
	pea a5@
	movel sp,a5
	tstl __15BinaryCompander$decTab
	jne L148
	pea 2:w
	pea LC9
	jbsr _printDebug__9SystemLibPCci
	jra L147
	.even
L148:
	pea LC10
	jbsr _puts
	movel __15BinaryCompander$decTab,sp@-
	movel a5@(8),sp@-
	jbsr _dumpDecode__9CompanderPl
L147:
	unlk a5
	rts
.globl __12FibCompander$decTab
.data
	.even
__12FibCompander$decTab:
	.long 0
.globl __12FibCompander$encTab
	.even
__12FibCompander$encTab:
	.long 0
.globl __12FibCompander$count
	.even
__12FibCompander$count:
	.long 0
.text
LC11:
	.ascii "-- constructing FibCompander --\0"
	.even
.globl ___12FibCompander
___12FibCompander:
	link a5,#-56
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-52)
	movel a5@(8),a0
	movel #___vt_9Compander,a0@
	movel a5@(-52),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L155,a5@(-12)
	movel sp,a5@(-8)
	jra L154
	.even
L155:
	jra L170
	.even
L154:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a0
	movel #___vt_12FibCompander,a0@
	clrl sp@-
	pea LC11
	movel a5@(-52),a1
	addql #4,a1
	movel a1,a5@(-56)
	jbsr _printDebug__9SystemLibPCci
	addql #8,sp
	movel __12FibCompander$count,d0
	jne L156
	jbsr _initTables__12FibCompander
	tstb d0
	jeq L158
	addql #1,__12FibCompander$count
	jra L158
	.even
L156:
	addql #1,d0
	movel d0,__12FibCompander$count
L158:
	movel a5@(-52),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L169
	.even
L170:
L152:
	movel a5@(-56),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L163,a5@(-36)
	movel sp,a5@(-32)
	jra L162
	.even
L163:
	jra L171
	.even
L162:
	lea a5@(-48),a0
	movel a5@(-56),a1
	movel a0,a1@
	movel a5@(8),a1
	movel #___vt_9Compander,a1@
	movel a5@(-56),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L171:
L160:
	jbsr ___terminate
	.even
L169:
	moveml a5@(-168),#0x5cfc
	fmovem a5@(-128),#0x3f
	unlk a5
	rts
LC12:
	.ascii "--- destroying FibCompander ---\0"
	.even
.globl __$_12FibCompander
__$_12FibCompander:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel #___vt_12FibCompander,a2@
	movel __12FibCompander$count,d0
	jle L173
	movel d0,d1
	subql #1,d1
	movel d1,__12FibCompander$count
	moveq #1,d1
	cmpl d0,d1
	jne L173
	jbsr _destroyTables__12FibCompander
L173:
	clrl sp@-
	pea LC12
	jbsr _printDebug__9SystemLibPCci
	addql #8,sp
	movel #___vt_9Compander,a2@
	movel a5@(12),d0
	btst #0,d0
	jeq L179
	movel a2,sp@-
	jbsr ___builtin_delete
L179:
	movel a5@(-4),a2
	unlk a5
	rts
LC13:
	.ascii "FibCompander::initTables() - unable to allocate table space\0"
LC14:
	.ascii "FibCompander::initTables() - created tables\0"
	.even
.globl _initTables__12FibCompander
_initTables__12FibCompander:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	clrl sp@-
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel #66560,sp@-
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	addw #12,sp
	tstl d0
	jne L181
	pea 2:w
	pea LC13
	jbsr _printDebug__9SystemLibPCci
	clrb d0
	jra L187
	.even
L181:
	movel d0,__12FibCompander$decTab
	movel d0,d1
	addl #1024,d1
	movel d1,__12FibCompander$encTab
	movel d0,a2
	clrl a2@+
	clrl a2@+
	moveq #1,d2
	lea _pow,a3
	.even
L185:
	fmoved #0r0.1946375251968508,fp0
	fdmull d2,fp0
	fmoved fp0,sp@-
	movel #-1687917474,sp@-
	movel #1073341303,sp@-
	jbsr a3@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdmuld #0r0.4472135955999164,fp0
	fdaddd #0r0.5000000000000005,fp0
	fmoveml fpcr,d0
	moveq #16,d1
	orl d0,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,a2@+
	fmoveml d0,fpcr
	fdnegx fp0,fp0
	fmoveml fpcr,d0
	moveq #16,d1
	orl d0,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,a2@+
	fmoveml d0,fpcr
	addw #16,sp
	addql #1,d2
	moveq #127,d0
	cmpl d2,d0
	jge L185
	clrl sp@-
	pea LC14
	jbsr _printDebug__9SystemLibPCci
	moveq #1,d0
L187:
	moveml a5@(-12),#0xc04
	unlk a5
	rts
LC15:
	.ascii "FibCompander::destroyTables() - destroyed tables\0"
	.even
.globl _destroyTables__12FibCompander
_destroyTables__12FibCompander:
	pea a5@
	movel sp,a5
	movel __12FibCompander$decTab,d0
	jeq L189
	movel d0,sp@-
	jbsr _free__3MemPv
	clrl __12FibCompander$decTab
	clrl __12FibCompander$encTab
	clrl sp@-
	pea LC15
	jbsr _printDebug__9SystemLibPCci
L189:
	unlk a5
	rts
LC16:
	.ascii "FibCompander::dumpDecCurve() - no table\0"
LC17:
	.ascii "Linear Fibonacci companding curve (positive half only)\0"
	.even
.globl _dumpDecodeCurve__12FibCompander
_dumpDecodeCurve__12FibCompander:
	pea a5@
	movel sp,a5
	tstl __12FibCompander$decTab
	jne L191
	pea 2:w
	pea LC16
	jbsr _printDebug__9SystemLibPCci
	jra L190
	.even
L191:
	pea LC17
	jbsr _puts
	movel __12FibCompander$decTab,sp@-
	movel a5@(8),sp@-
	jbsr _dumpDecode__9CompanderPl
L190:
	unlk a5
	rts
.globl __16RootFibCompander$decTab
.data
	.even
__16RootFibCompander$decTab:
	.long 0
.globl __16RootFibCompander$encTab
	.even
__16RootFibCompander$encTab:
	.long 0
.globl __16RootFibCompander$count
	.even
__16RootFibCompander$count:
	.long 0
.text
LC18:
	.ascii "-- constructing RootFibCompander --\0"
	.even
.globl ___16RootFibCompander
___16RootFibCompander:
	link a5,#-56
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-52)
	movel a5@(8),a0
	movel #___vt_9Compander,a0@
	movel a5@(-52),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L198,a5@(-12)
	movel sp,a5@(-8)
	jra L197
	.even
L198:
	jra L213
	.even
L197:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a0
	movel #___vt_16RootFibCompander,a0@
	clrl sp@-
	pea LC18
	movel a5@(-52),a1
	addql #4,a1
	movel a1,a5@(-56)
	jbsr _printDebug__9SystemLibPCci
	addql #8,sp
	movel __16RootFibCompander$count,d0
	jne L199
	jbsr _initTables__16RootFibCompander
	tstb d0
	jeq L201
	addql #1,__16RootFibCompander$count
	jra L201
	.even
L199:
	addql #1,d0
	movel d0,__16RootFibCompander$count
L201:
	movel a5@(-52),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L212
	.even
L213:
L195:
	movel a5@(-56),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L206,a5@(-36)
	movel sp,a5@(-32)
	jra L205
	.even
L206:
	jra L214
	.even
L205:
	lea a5@(-48),a0
	movel a5@(-56),a1
	movel a0,a1@
	movel a5@(8),a1
	movel #___vt_9Compander,a1@
	movel a5@(-56),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L214:
L203:
	jbsr ___terminate
	.even
L212:
	moveml a5@(-168),#0x5cfc
	fmovem a5@(-128),#0x3f
	unlk a5
	rts
LC19:
	.ascii "--- destroying RootFibCompander ---\0"
	.even
.globl __$_16RootFibCompander
__$_16RootFibCompander:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel #___vt_16RootFibCompander,a2@
	movel __16RootFibCompander$count,d0
	jle L216
	movel d0,d1
	subql #1,d1
	movel d1,__16RootFibCompander$count
	moveq #1,d1
	cmpl d0,d1
	jne L216
	jbsr _destroyTables__16RootFibCompander
L216:
	clrl sp@-
	pea LC19
	jbsr _printDebug__9SystemLibPCci
	addql #8,sp
	movel #___vt_9Compander,a2@
	movel a5@(12),d0
	btst #0,d0
	jeq L222
	movel a2,sp@-
	jbsr ___builtin_delete
L222:
	movel a5@(-4),a2
	unlk a5
	rts
LC20:
	.ascii "RootFibCompander::initTables() - unable to allocate table space\0"
LC21:
	.ascii "RootFibCompander::initTables() - created tables\0"
	.even
.globl _initTables__16RootFibCompander
_initTables__16RootFibCompander:
	pea a5@
	movel sp,a5
	moveml #0x2038,sp@-
	clrl sp@-
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel #66560,sp@-
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	addw #12,sp
	tstl d0
	jne L224
	pea 2:w
	pea LC20
	jbsr _printDebug__9SystemLibPCci
	clrb d0
	jra L230
	.even
L224:
	movel d0,__16RootFibCompander$decTab
	movel d0,d1
	addl #1024,d1
	movel d1,__16RootFibCompander$encTab
	movel d0,a2
	clrl a2@+
	clrl a2@+
	moveq #1,d2
	lea _sqrt,a4
	lea _pow,a3
	.even
L228:
	fmoved #0r0.007874015748031501,fp0
	fdmull d2,fp0
	fmoved fp0,sp@-
	jbsr a4@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdmuld #0r24.71896570000005,fp0
	fmoved fp0,sp@-
	movel #-1687917474,sp@-
	movel #1073341303,sp@-
	jbsr a3@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdmuld #0r0.4472135955999164,fp0
	fdaddd #0r0.5000000000000005,fp0
	fmoveml fpcr,d0
	moveq #16,d1
	orl d0,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,a2@+
	fmoveml d0,fpcr
	fdnegx fp0,fp0
	fmoveml fpcr,d0
	moveq #16,d1
	orl d0,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,a2@+
	fmoveml d0,fpcr
	addw #24,sp
	addql #1,d2
	moveq #127,d0
	cmpl d2,d0
	jge L228
	clrl sp@-
	pea LC21
	jbsr _printDebug__9SystemLibPCci
	moveq #1,d0
L230:
	moveml a5@(-16),#0x1c04
	unlk a5
	rts
LC22:
	.ascii "RootFibCompander::destroyTables() - destroyed tables\0"
	.even
.globl _destroyTables__16RootFibCompander
_destroyTables__16RootFibCompander:
	pea a5@
	movel sp,a5
	movel __16RootFibCompander$decTab,d0
	jeq L232
	movel d0,sp@-
	jbsr _free__3MemPv
	clrl __16RootFibCompander$decTab
	clrl __16RootFibCompander$encTab
	clrl sp@-
	pea LC22
	jbsr _printDebug__9SystemLibPCci
L232:
	unlk a5
	rts
LC23:
	.ascii "RootFibCompander::dumpDecCurve() - no table\0"
LC24:
	.ascii "Root-Fibonacci companding curve (positive half only)\0"
	.even
.globl _dumpDecodeCurve__16RootFibCompander
_dumpDecodeCurve__16RootFibCompander:
	pea a5@
	movel sp,a5
	tstl __16RootFibCompander$decTab
	jne L234
	pea 2:w
	pea LC23
	jbsr _printDebug__9SystemLibPCci
	jra L233
	.even
L234:
	pea LC24
	jbsr _puts
	movel __16RootFibCompander$decTab,sp@-
	movel a5@(8),sp@-
	jbsr _dumpDecode__9CompanderPl
L233:
	unlk a5
	rts
	.even
.globl _get__9Companderi
_get__9Companderi:
	link a5,#-160
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,d1
	moveq #1,d0
	cmpl a5@(8),d0
	jeq L237
	moveq #2,d0
	cmpl a5@(8),d0
	jeq L244
	jra L251
	.even
L237:
	pea _nothrow
	pea 4:w
	movel d1,a0
	addql #4,a0
	movel a0,a5@(-160)
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-148)
	movel a5@(-160),a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L241,a5@(-12)
	movel sp,a5@(-8)
	jra L240
	.even
L241:
	jra L280
	.even
L240:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(-148),sp@-
	jbsr ___15BinaryCompander
	movel a5@(-160),a1
	movel a1@,a0
	movel a0@,a1@
	jra L281
	.even
L244:
	pea _nothrow
	pea 4:w
	movel d1,a0
	addql #4,a0
	movel a0,a5@(-160)
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-152)
	movel a5@(-160),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L248,a5@(-36)
	movel sp,a5@(-32)
	jra L247
	.even
L248:
	jra L282
	.even
L247:
	lea a5@(-48),a1
	movel a1,a0@
	movel a5@(-152),sp@-
	jbsr ___12FibCompander
	movel a5@(-160),a1
	movel a1@,a0
	movel a0@,a1@
	jra L281
	.even
L251:
	pea _nothrow
	pea 4:w
	movel d1,a0
	addql #4,a0
	movel a0,a5@(-160)
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-156)
	movel a5@(-160),a0
	movel a0@,a5@(-72)
	clrl a5@(-68)
	movel a5,a5@(-64)
	movel #L255,a5@(-60)
	movel sp,a5@(-56)
	jra L254
	.even
L255:
	jra L283
	.even
L254:
	lea a5@(-72),a1
	movel a1,a0@
	movel a5@(-156),sp@-
	jbsr ___16RootFibCompander
	movel a5@(-160),a1
	movel a1@,a0
	movel a0@,a1@
	jra L281
	.even
L280:
L238:
	movel a5@(-160),a0
	movel a0@,a5@(-96)
	clrl a5@(-92)
	movel a5,a5@(-88)
	movel #L262,a5@(-84)
	movel sp,a5@(-80)
	jra L261
	.even
L262:
	jra L284
	.even
L261:
	lea a5@(-96),a0
	movel a5@(-160),a1
	movel a0,a1@
	moveq #1,d0
	jeq L264
	pea _nothrow
	movel a5@(-148),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L264:
	movel a5@(-160),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L282:
L245:
	movel a5@(-160),a0
	movel a0@,a5@(-120)
	clrl a5@(-116)
	movel a5,a5@(-112)
	movel #L268,a5@(-108)
	movel sp,a5@(-104)
	jra L267
	.even
L268:
	jra L285
	.even
L267:
	lea a5@(-120),a0
	movel a5@(-160),a1
	movel a0,a1@
	moveq #1,d0
	jeq L270
	pea _nothrow
	movel a5@(-152),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L270:
	movel a5@(-160),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L283:
L252:
	movel a5@(-160),a0
	movel a0@,a5@(-144)
	clrl a5@(-140)
	lea a5@(-136),a0
	movel a5,a0@
	movel #L274,a0@(4)
	movel sp,a5@(-128)
	jra L273
	.even
L274:
	jra L286
	.even
L273:
	lea a5@(-144),a0
	movel a5@(-160),a1
	movel a0,a1@
	moveq #1,d0
	jeq L276
	pea _nothrow
	movel a5@(-156),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L276:
	movel a5@(-160),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L284:
L259:
	jbsr ___terminate
	.even
L285:
L265:
	jbsr ___terminate
	.even
L286:
L271:
	jbsr ___terminate
	.even
L281:
	moveml a5@(-272),#0x5cfc
	fmovem a5@(-232),#0x3f
	unlk a5
	rts
.globl ___vt_16RootFibCompander
	.even
___vt_16RootFibCompander:
	.long 0
	.long 0
	.long _dumpDecodeCurve__16RootFibCompander
	.long __$_16RootFibCompander
	.skip 4
.globl ___vt_12FibCompander
	.even
___vt_12FibCompander:
	.long 0
	.long 0
	.long _dumpDecodeCurve__12FibCompander
	.long __$_12FibCompander
	.skip 4
.globl ___vt_15BinaryCompander
	.even
___vt_15BinaryCompander:
	.long 0
	.long 0
	.long _dumpDecodeCurve__15BinaryCompander
	.long __$_15BinaryCompander
	.skip 4
	.even
___vt_9Compander:
	.long 0
	.long 0
	.long ___pure_virtual
	.long __$_9Compander
	.skip 4
	.even
__$_9Compander:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel #___vt_9Compander,a0@
	btst #0,a5@(15)
	jeq L28
	movel a0,sp@-
	jbsr ___builtin_delete
L28:
	unlk a5
	rts
