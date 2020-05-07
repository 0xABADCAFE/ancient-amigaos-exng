#NO_APP
.globl __5QMath$data
.data
	.even
__5QMath$data:
	.long 0
.globl __5QMath$arcData
	.even
__5QMath$arcData:
	.long 0
.globl __5QMath$eFrac
	.even
__5QMath$eFrac:
	.long 0
.globl __5QMath$eInt
	.even
__5QMath$eInt:
	.long 0
.text
LC0:
	.ascii "QMath::init() - insufficient memory for tables\0"
	.even
.globl _init__5QMath
_init__5QMath:
	pea a5@
	movel sp,a5
	moveml #0x3030,sp@-
	tstl __5QMath$data
	jeq L123
	movel #-50659328,d0
	jra L138
	.even
L123:
	pea 16:w
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea 13040:w
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,__5QMath$data
	addw #12,sp
	jne L124
	pea 2:w
	pea LC0
	jbsr _printDebug__9SystemLibPCci
	movel #-50528257,d0
	jra L138
	.even
L124:
	movel #4112,d1
	addl d1,d0
	movel d0,__5QMath$arcData
	addl d1,d0
	movel d0,__5QMath$eFrac
	addl d1,d0
	movel d0,__5QMath$eInt
	clrl d3
	lea _asin,a3
	lea _exp,a2
	.even
L128:
	movel __5QMath$data,a0
	fmoved #0r0.00153398078789063,fp0
	fdmull d3,fp0
	fsinx fp0,fp0
	fsmovex fp0,fp0
	fmoves fp0,a0@(d3:l:4)
	movel d3,d0
	jge L156
	addl #1023,d0
L156:
	moveq #10,d1
	asrl d1,d0
	fdmovel d0,fp0
	fmoved fp0,sp@-
	jbsr a3@
	movel __5QMath$arcData,a0
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fsmovex fp0,fp0
	fmoves fp0,a0@(d3:l:4)
	movel d3,d0
	negl d0
	jpl L157
	addl #1023,d0
L157:
	moveq #10,d1
	asrl d1,d0
	fdmovel d0,fp0
	fmoved fp0,sp@-
	jbsr a2@
	movel __5QMath$eFrac,a0
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fsmovex fp0,fp0
	fmoves fp0,a0@(d3:l:4)
	addw #16,sp
	movel d3,d2
	addql #1,d2
	movel __5QMath$data,a0
	fmoved #0r0.00153398078789063,fp0
	fdmull d2,fp0
	fsinx fp0,fp0
	fsmovex fp0,fp0
	fmoves fp0,a0@(d2:l:4)
	movel d2,d0
	jge L160
	movel d3,d0
	addl #1024,d0
L160:
	moveq #10,d1
	asrl d1,d0
	fdmovel d0,fp0
	fmoved fp0,sp@-
	jbsr a3@
	movel __5QMath$arcData,a0
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fsmovex fp0,fp0
	fmoves fp0,a0@(d2:l:4)
	movel d2,d0
	negl d0
	jpl L161
	addl #1023,d0
L161:
	moveq #10,d1
	asrl d1,d0
	fdmovel d0,fp0
	fmoved fp0,sp@-
	jbsr a2@
	movel __5QMath$eFrac,a1
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fsmovex fp0,fp0
	fmoves fp0,a1@(d2:l:4)
	addw #16,sp
	addql #2,d3
	cmpl #1023,d3
	jle L128
	movel __5QMath$data,a0
	movel #0x3f800000,a0@(4096)
	movel #0x3f800000,a1@(4096)
	movel __5QMath$arcData,a0
	movel #0x3fc90fdb,a0@(4096)
	clrl d3
	.even
L135:
	moveq #-88,d0
	addl d3,d0
	fdmovel d0,fp0
	fmoved fp0,sp@-
	jbsr a2@
	movel __5QMath$eInt,a0
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fsmovex fp0,fp0
	fmoves fp0,a0@(d3:l:4)
	addql #8,sp
	movel d3,d2
	addql #1,d2
	moveq #-87,d0
	addl d3,d0
	fdmovel d0,fp0
	fmoved fp0,sp@-
	jbsr a2@
	movel __5QMath$eInt,a0
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fsmovex fp0,fp0
	fmoves fp0,a0@(d2:l:4)
	addql #8,sp
	addql #1,d2
	moveq #-86,d0
	addl d3,d0
	fdmovel d0,fp0
	fmoved fp0,sp@-
	jbsr a2@
	movel __5QMath$eInt,a0
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fsmovex fp0,fp0
	fmoves fp0,a0@(d2:l:4)
	addql #8,sp
	addql #1,d2
	moveq #-85,d0
	addl d3,d0
	fdmovel d0,fp0
	fmoved fp0,sp@-
	jbsr a2@
	movel __5QMath$eInt,a0
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fsmovex fp0,fp0
	fmoves fp0,a0@(d2:l:4)
	addql #8,sp
	addql #1,d2
	moveq #-84,d0
	addl d3,d0
	fdmovel d0,fp0
	fmoved fp0,sp@-
	jbsr a2@
	movel __5QMath$eInt,a0
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fsmovex fp0,fp0
	fmoves fp0,a0@(d2:l:4)
	addql #8,sp
	addql #1,d2
	moveq #-83,d0
	addl d3,d0
	fdmovel d0,fp0
	fmoved fp0,sp@-
	jbsr a2@
	movel __5QMath$eInt,a0
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fsmovex fp0,fp0
	fmoves fp0,a0@(d2:l:4)
	addql #8,sp
	addql #1,d2
	moveq #-82,d0
	addl d3,d0
	fdmovel d0,fp0
	fmoved fp0,sp@-
	jbsr a2@
	movel __5QMath$eInt,a0
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fsmovex fp0,fp0
	fmoves fp0,a0@(d2:l:4)
	addql #8,sp
	addql #1,d2
	moveq #-81,d0
	addl d3,d0
	fdmovel d0,fp0
	fmoved fp0,sp@-
	jbsr a2@
	movel __5QMath$eInt,a0
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fsmovex fp0,fp0
	fmoves fp0,a0@(d2:l:4)
	addql #8,sp
	addql #8,d3
	cmpl #175,d3
	jle L135
	clrl d0
L138:
	moveml a5@(-16),#0xc0c
	unlk a5
	rts
	.even
.globl _done__5QMath
_done__5QMath:
	pea a5@
	movel sp,a5
	movel __5QMath$data,d0
	jeq L164
	movel d0,sp@-
	jbsr _free__3MemPv
L164:
	clrl __5QMath$data
	clrl __5QMath$arcData
	clrl __5QMath$eFrac
	clrl __5QMath$eInt
	unlk a5
	rts
	.even
.globl _angleMod__5QMathf
_angleMod__5QMathf:
	pea a5@
	movel sp,a5
	fsmoves a5@(8),fp0
	fjge L167
	movel #1610612736,sp@-
	movel #1075388923,sp@-
	fmoved fp0,sp@-
	jbsr _fmod
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddd #0r6.283185482025151,fp0
	jra L173
	.even
L167:
	fcmps #0r6.28318548,fp0
	fjlt L169
	movel #1610612736,sp@-
	movel #1075388923,sp@-
	fmoved fp0,sp@-
	jbsr _fmod
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
L173:
	fsmovex fp0,fp0
L169:
	fmoves fp0,d0
	unlk a5
	rts
	.even
.globl _sin__5QMathf
_sin__5QMathf:
	pea a5@
	movel sp,a5
	fmovem #0xc,sp@-
	movel d2,sp@-
	fsmoves a5@(8),fp3
	fsmuls #0r651.898621,fp3
	fdmovex fp3,fp0
	fcmpd #0r2147483648.000005,fp0
	fjge L175
	fmoveml fpcr,d0
	moveq #16,d2
	orl d0,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d1
	fmoveml d0,fpcr
	jra L176
	.even
L175:
	fdsubd #0r2147483648.000005,fp0
	fmoveml fpcr,d0
	moveq #16,d2
	orl d0,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d1
	fmoveml d0,fpcr
	bchg #31,d1
L176:
	fdmovel d1,fp0
	tstl d1
	jge L177
	fdaddd #0r4294967296.000005,fp0
L177:
	fsmovex fp0,fp0
	fssubx fp0,fp3
	cmpl #1023,d1
	jhi L178
	movel __5QMath$data,a0
	fsmoves a0@(d1:l:4),fp2
	jra L179
	.even
L178:
	cmpl #2047,d1
	jhi L181
	movel #2048,d0
	subl d1,d0
	movel __5QMath$data,a0
	fsmoves a0@(d0:l:4),fp2
	jra L179
	.even
L181:
	cmpl #3071,d1
	jhi L182
	movel __5QMath$data,a0
	fsnegs a0@(-8192,d1:l:4),fp2
	jra L179
	.even
L182:
	cmpl #4095,d1
	jhi L183
	movel #4096,d0
	subl d1,d0
	movel __5QMath$data,a0
	fsnegs a0@(d0:l:4),fp2
	jra L179
	.even
L183:
	movel __5QMath$data,a0
	fsmoves a0@(-16384,d1:l:4),fp2
L179:
	movel d1,d0
	addql #1,d0
	cmpl #1023,d0
	jhi L188
	fsmoves a0@(d0:l:4),fp1
	jra L189
	.even
L188:
	cmpl #2047,d0
	jhi L191
	movel #2048,d1
	subl d0,d1
	movel d1,d0
	fsmoves a0@(d0:l:4),fp1
	jra L189
	.even
L191:
	cmpl #3071,d0
	jhi L192
	fsnegs a0@(-8192,d0:l:4),fp1
	jra L189
	.even
L192:
	cmpl #4095,d0
	jhi L193
	movel #4096,d2
	subl d0,d2
	movel d2,d0
	fsnegs a0@(d0:l:4),fp1
	jra L189
	.even
L193:
	fsmoves a0@(-16384,d0:l:4),fp1
L189:
	fmoves #0r1,fp0
	fssubx fp3,fp0
	fsmulx fp2,fp0
	fsmulx fp1,fp3
	fsaddx fp3,fp0
	fmoves fp0,d0
	movel sp@+,d2
	fmovem sp@+,#0x30
	unlk a5
	rts
	.even
.globl _cos__5QMathf
_cos__5QMathf:
	pea a5@
	movel sp,a5
	fmovem #0xc,sp@-
	movel d2,sp@-
	fsmoves a5@(8),fp3
	fsmuls #0r651.898621,fp3
	fdmovex fp3,fp0
	fcmpd #0r2147483648.000005,fp0
	fjge L200
	fmoveml fpcr,d0
	moveq #16,d2
	orl d0,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d1
	fmoveml d0,fpcr
	jra L201
	.even
L200:
	fdsubd #0r2147483648.000005,fp0
	fmoveml fpcr,d0
	moveq #16,d2
	orl d0,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d1
	fmoveml d0,fpcr
	bchg #31,d1
L201:
	fdmovel d1,fp0
	tstl d1
	jge L202
	fdaddd #0r4294967296.000005,fp0
L202:
	fsmovex fp0,fp0
	fssubx fp0,fp3
	cmpl #1023,d1
	jhi L203
	movel #1024,d0
	jra L224
	.even
L203:
	cmpl #2047,d1
	jhi L206
	movel __5QMath$data,a0
	fsnegs a0@(-4096,d1:l:4),fp2
	jra L204
	.even
L206:
	cmpl #3071,d1
	jhi L207
	movel #3072,d0
	subl d1,d0
	movel __5QMath$data,a0
	fsnegs a0@(d0:l:4),fp2
	jra L204
	.even
L207:
	cmpl #4095,d1
	jhi L208
	movel __5QMath$data,a0
	fsmoves a0@(-12288,d1:l:4),fp2
	jra L204
	.even
L208:
	movel #5120,d0
L224:
	subl d1,d0
	movel __5QMath$data,a0
	fsmoves a0@(d0:l:4),fp2
L204:
	movel d1,d0
	addql #1,d0
	cmpl #1023,d0
	jhi L213
	movel #1024,d1
	jra L225
	.even
L213:
	cmpl #2047,d0
	jhi L216
	fsnegs a0@(-4096,d0:l:4),fp1
	jra L214
	.even
L216:
	cmpl #3071,d0
	jhi L217
	movel #3072,d2
	subl d0,d2
	movel d2,d0
	fsnegs a0@(d0:l:4),fp1
	jra L214
	.even
L217:
	cmpl #4095,d0
	jhi L218
	fsmoves a0@(-12288,d0:l:4),fp1
	jra L214
	.even
L218:
	movel #5120,d1
L225:
	subl d0,d1
	movel d1,d0
	fsmoves a0@(d0:l:4),fp1
L214:
	fmoves #0r1,fp0
	fssubx fp3,fp0
	fsmulx fp2,fp0
	fsmulx fp1,fp3
	fsaddx fp3,fp0
	fmoves fp0,d0
	movel sp@+,d2
	fmovem sp@+,#0x30
	unlk a5
	rts
	.even
.globl _tan__5QMathf
_tan__5QMathf:
	pea a5@
	movel sp,a5
	fmovem #0xc,sp@-
	movel d2,sp@-
	fsmoves a5@(8),fp3
	fsmuls #0r651.898621,fp3
	fdmovex fp3,fp0
	fcmpd #0r2147483648.000005,fp0
	fjge L227
	fmoveml fpcr,d0
	moveq #16,d2
	orl d0,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d1
	fmoveml d0,fpcr
	jra L228
	.even
L227:
	fdsubd #0r2147483648.000005,fp0
	fmoveml fpcr,d0
	moveq #16,d2
	orl d0,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d1
	fmoveml d0,fpcr
	bchg #31,d1
L228:
	fdmovel d1,fp0
	tstl d1
	jge L229
	fdaddd #0r4294967296.000005,fp0
L229:
	fsmovex fp0,fp0
	fssubx fp0,fp3
	cmpl #1023,d1
	jhi L230
	movel #1024,d0
	subl d1,d0
	fmoves #0r1,fp2
	fssubx fp3,fp2
	movel __5QMath$data,a0
	fsmovex fp2,fp1
	fsmuls a0@(d1:l:4),fp1
	fsmovex fp3,fp0
	fsmuls a0@(4,d1:l:4),fp0
	fsaddx fp0,fp1
	jra L240
	.even
L230:
	cmpl #2047,d1
	jhi L232
	movel d1,d0
	addl #-1024,d0
	movew #2048,a0
	subl d1,a0
	movel a0,d1
	jra L241
	.even
L232:
	cmpl #3071,d1
	jhi L234
	movel #3072,d0
	subl d1,d0
	addl #-2048,d1
	fmoves #0r1,fp2
	fssubx fp3,fp2
	movel __5QMath$data,a0
	fsmovex fp2,fp1
	fsmuls a0@(d1:l:4),fp1
	fsmovex fp3,fp0
	fsmuls a0@(4,d1:l:4),fp0
	fsaddx fp0,fp1
	jra L240
	.even
L234:
	cmpl #4095,d1
	jls L236
	movel #5120,d0
	subl d1,d0
	addl #-4096,d1
	fmoves #0r1,fp2
	fssubx fp3,fp2
	movel __5QMath$data,a0
	fsmovex fp2,fp1
	fsmuls a0@(d1:l:4),fp1
	fsmovex fp3,fp0
	fsmuls a0@(4,d1:l:4),fp0
	fsaddx fp0,fp1
	jra L240
	.even
L236:
	movel d1,d0
	addl #-3072,d0
	movel #4096,d2
	subl d1,d2
	movel d2,d1
L241:
	fmoves #0r1,fp2
	fssubx fp3,fp2
	fsnegx fp2,fp1
	movel __5QMath$data,a0
	fsmuls a0@(d1:l:4),fp1
	fsmovex fp3,fp0
	fsmuls a0@(4,d1:l:4),fp0
	fssubx fp0,fp1
L240:
	fsmuls a0@(d0:l:4),fp2
	fsmuls a0@(4,d0:l:4),fp3
	fsaddx fp3,fp2
	fsdivx fp2,fp1
	fmoves fp1,d0
	movel sp@+,d2
	fmovem sp@+,#0x30
	unlk a5
	rts
	.even
.globl _asin__5QMathf
_asin__5QMathf:
	pea a5@
	movel sp,a5
	movel d2,sp@-
	fsmoves a5@(8),fp1
	fsmuls #0r1024,fp1
	fjge L243
	fsnegx fp1,fp1
	fsmovex fp1,fp0
	fssubs #0r0.5,fp0
	fcmpd #0r2147483648.000005,fp0
	fjge L244
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	jra L245
	.even
L244:
	fdsubd #0r2147483648.000005,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	bchg #31,d0
L245:
	fdmovel d0,fp0
	tstl d0
	jge L246
	fdaddd #0r4294967296.000005,fp0
L246:
	fsmovex fp0,fp0
	fssubx fp0,fp1
	fsmovex fp1,fp0
	fssubs #0r1,fp0
	movel __5QMath$arcData,a0
	fsmuls a0@(d0:l:4),fp0
	fsmuls a0@(4,d0:l:4),fp1
	fssubx fp1,fp0
	jra L253
	.even
L243:
	fsmovex fp1,fp0
	fssubs #0r0.5,fp0
	fcmpd #0r2147483648.000005,fp0
	fjge L248
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	jra L249
	.even
L248:
	fdsubd #0r2147483648.000005,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	bchg #31,d0
L249:
	fdmovel d0,fp0
	tstl d0
	jge L250
	fdaddd #0r4294967296.000005,fp0
L250:
	fsmovex fp0,fp0
	fssubx fp0,fp1
	fmoves #0r1,fp0
	fssubx fp1,fp0
	movel __5QMath$arcData,a0
	fsmuls a0@(d0:l:4),fp0
	fsmuls a0@(4,d0:l:4),fp1
	fsaddx fp1,fp0
L253:
	fmoves fp0,d0
	movel sp@+,d2
	unlk a5
	rts
	.even
.globl _acos__5QMathf
_acos__5QMathf:
	pea a5@
	movel sp,a5
	fmovem #0x4,sp@-
	movel d2,sp@-
	fsmoves a5@(8),fp2
	fsmuls #0r1024,fp2
	fjge L255
	fsnegx fp2,fp2
	fsmovex fp2,fp0
	fssubs #0r0.5,fp0
	fcmpd #0r2147483648.000005,fp0
	fjge L256
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	jra L257
	.even
L256:
	fdsubd #0r2147483648.000005,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	bchg #31,d0
L257:
	fdmovel d0,fp0
	tstl d0
	jge L258
	fdaddd #0r4294967296.000005,fp0
L258:
	fsmovex fp0,fp0
	fssubx fp0,fp2
	fmoves #0r1,fp0
	fssubx fp2,fp0
	movel __5QMath$arcData,a0
	fsmuls a0@(d0:l:4),fp0
	fsadds #0r1.57079637,fp0
	fsmuls a0@(4,d0:l:4),fp2
	fsaddx fp2,fp0
	fmoves fp0,d0
	jra L264
	.even
L255:
	fsmovex fp2,fp0
	fssubs #0r0.5,fp0
	fcmpd #0r2147483648.000005,fp0
	fjge L260
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	jra L261
	.even
L260:
	fdsubd #0r2147483648.000005,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	bchg #31,d0
L261:
	fdmovel d0,fp0
	tstl d0
	jge L262
	fdaddd #0r4294967296.000005,fp0
L262:
	fsmovex fp0,fp0
	fssubx fp0,fp2
	fmoves #0r1,fp0
	fssubx fp2,fp0
	movel __5QMath$arcData,a0
	fsmuls a0@(d0:l:4),fp0
	fmoves #0r1.57079637,fp1
	fssubx fp0,fp1
	fsmuls a0@(4,d0:l:4),fp2
	fssubx fp2,fp1
	fmoves fp1,d0
L264:
	movel sp@+,d2
	fmovem sp@+,#0x20
	unlk a5
	rts
	.even
.globl _exp__5QMathf
_exp__5QMathf:
	pea a5@
	movel sp,a5
	movel d3,sp@-
	movel d2,sp@-
	fsmoves a5@(8),fp1
	fsmovex fp1,fp0
	fsadds #0r0.5,fp0
	fcmpd #0r2147483648.000005,fp0
	fjge L266
	fmoveml fpcr,d0
	moveq #16,d2
	orl d0,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d1
	fmoveml d0,fpcr
	jra L267
	.even
L266:
	fdsubd #0r2147483648.000005,fp0
	fmoveml fpcr,d3
	moveq #16,d0
	orl d3,d0
	andw #-33,d0
	fmoveml d0,fpcr
	fmovel fp0,d1
	fmoveml d3,fpcr
	bchg #31,d1
L267:
	movel d1,d0
	subql #1,d0
	fssubl d0,fp1
	fsmuls #0r1024,fp1
	fsmovex fp1,fp0
	fssubs #0r0.5,fp0
	fcmpd #0r2147483648.000005,fp0
	fjge L268
	fmoveml fpcr,d2
	moveq #16,d3
	orl d2,d3
	andw #-33,d3
	fmoveml d3,fpcr
	fmovel fp0,d0
	fmoveml d2,fpcr
	jra L269
	.even
L268:
	fdsubd #0r2147483648.000005,fp0
	fmoveml fpcr,d2
	moveq #16,d3
	orl d2,d3
	andw #-33,d3
	fmoveml d3,fpcr
	fmovel fp0,d0
	fmoveml d2,fpcr
	bchg #31,d0
L269:
	fdmovel d0,fp0
	tstl d0
	jge L270
	fdaddd #0r4294967296.000005,fp0
L270:
	fsmovex fp0,fp0
	fssubx fp0,fp1
	movel __5QMath$eInt,a1
	fmoves #0r1,fp0
	fssubx fp1,fp0
	movel __5QMath$eFrac,a0
	fsmuls a0@(d0:l:4),fp0
	fsmuls a0@(4,d0:l:4),fp1
	fsaddx fp1,fp0
	fsmuls a1@(352,d1:l:4),fp0
	fmoves fp0,d0
	movel sp@+,d2
	movel sp@+,d3
	unlk a5
	rts
