BITS 64

org     0x08048000

; typedef struct elf64_hdr {
;   unsigned char	e_ident[EI_NIDENT];	/* ELF "magic number" */
;   Elf64_Half e_type;
;   Elf64_Half e_machine;
;   Elf64_Word e_version;
;   Elf64_Addr e_entry;		/* Entry point virtual address */
;   Elf64_Off e_phoff;		/* Program header table file offset */
;   Elf64_Off e_shoff;		/* Section header table file offset */
;   Elf64_Word e_flags;
;   Elf64_Half e_ehsize;
;   Elf64_Half e_phentsize;
;   Elf64_Half e_phnum;
;   Elf64_Half e_shentsize;
;   Elf64_Half e_shnum;
;   Elf64_Half e_shstrndx;
; } Elf64_Ehdr;

ehdr:
            db      0x7F, "ELF"                 ; e_ident
            db      2, 1, 1, 0
            db  0                               ; pad before code starts
_start:     mov dil, 42                         ; combined code/EI_PAD
            mov al, 60
            syscall
            dw      2                           ; e_type
            dw      0x3E                        ; e_machine
            dd      1                           ; e_version
            dq      _start                      ; e_entry
            dq      phdr - $$                   ; e_phoff
            dq      0                           ; e_shoff
            dd      0                           ; e_flags
            dw      ehdrsize                    ; e_ehsize
            dw      phdrsize                    ; e_phentsize
            dw      1                           ; e_phnum
            dw      0                           ; e_shentsize
            dw      0                           ; e_shnum
            dw      0                           ; e_shstrndx

ehdrsize    equ     $ - ehdr

; typedef struct elf64_phdr {
;   Elf64_Word p_type;
;   Elf64_Word p_flags;
;   Elf64_Off p_offset;		/* Segment file offset */
;   Elf64_Addr p_vaddr;		/* Segment virtual address */
;   Elf64_Addr p_paddr;		/* Segment physical address */
;   Elf64_Xword p_filesz;		/* Segment size in file */
;   Elf64_Xword p_memsz;		/* Segment size in memory */
;   Elf64_Xword p_align;		/* Segment alignment, file & memory */
; } Elf64_Phdr;

phdr:
            dd      1                           ; p_type
            dd      5                           ; p_flags
            dq      0                           ; p_offset
            dq      $$                          ; p_vaddr
            dq      $$                          ; p_paddr
            dq      filesize                    ; p_filesz
            dq      filesize                    ; p_memsz
            dd      0x1000                      ; p_align
    times 4 db 0

phdrsize    equ     $ - phdr

filesize    equ     $ - $$
