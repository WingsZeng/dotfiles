#!/usr/bin/env python3

from pwn import *
{bindings}

context.binary = {bin_name}.path

io = remote('host', 1337) if args.REMOTE else gdb.debug({proc_args}) if args.GDB else process({proc_args}, stdin=PTY)

n2b = lambda x    : str(x).encode()
rv  = lambda x    : io.recvn(x)
ru  = lambda s    : io.recvuntil(s, drop=True)
sd  = lambda s    : io.send(s)
sl  = lambda s    : io.sendline(s)
sn  = lambda n    : sl(n2b(n))
sa  = lambda p, s : io.sendafter(p, s)
sla = lambda p, s : io.sendlineafter(p, s)
sna = lambda p, n : sla(p, n2b(n))
ia  = lambda      : io.interactive()
uu32 = lambda x   : u32(x.ljust(4, b'\0'))
uu64 = lambda x   : u64(x.ljust(8, b'\0'))
p32s = lambda *xs : flat([p32(x) for x in xs])
p64s = lambda *xs : flat([p64(x) for x in xs])

prompt      = b':'
prompt_menu = prompt

op   = lambda x : sla(prompt_menu, n2b(x))
snap = lambda n : sna(prompt, n)
sap  = lambda s : sa(prompt, s)
slap = lambda s : sla(prompt, s)

def leakaddr(pre = None, suf = None, num = None, keepsuf = True):
    if num is None:
        num = 6 if context.bits == 64 else 4
    if pre is not None:
        ru(pre)
    if suf is not None:
        r = ru(suf)
        if keepsuf:
            r += suf
        r = r[-num:]
    else:
        r = rv(num)
    u = uu64 if context.bits == 64 else uu32
    return u(r)

