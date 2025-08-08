# Assembeler used for nand2tetris course
# assembly code -> machine code

import sys
import os

base_var_mem = 16

symbols = {
    "R0": 0, "R1": 1, "R2": 2, "R3": 3, "R4": 4, "R5": 5,
    "R6": 6, "R7": 7, "R8": 8, "R9": 9, "R10": 10, "R11": 11,
    "R12": 12, "R13": 13, "R14": 14, "R15": 15, "SP": 0, "LCL": 1,
    "ARG": 2, "THIS": 3, "THAT": 4, "SCREEN": 16384, "KBD": 24576,
}

var_symbols = {}

comp_table = {
    "0": "0101010", "1": "0111111", "-1": "0111010",
    "D": "0001100", "A": "0110000", "!D": "0001101", "!A": "0110001",
    "-D": "0001111", "-A": "0110011", "D+1": "0011111", "A+1": "0110111",
    "D-1": "0001110", "A-1": "0110010", "D+A": "0000010", "D-A": "0010011",
    "A-D": "0000111", "D&A": "0000000", "D|A": "0010101",
    "M": "1110000", "!M": "1110001", "-M": "1110011", "M+1": "1110111",
    "M-1": "1110010", "D+M": "1000010", "D-M": "1010011",
    "M-D": "1000111", "D&M": "1000000", "D|M": "1010101"
}

dest_table = {
    "": "000", "M": "001", "D": "010", "MD": "011",
    "A": "100", "AM": "101", "AD": "110", "AMD": "111"
}

jump_table = {
    "": "000", "JGT": "001", "JEQ": "010", "JGE": "011",
    "JLT": "100", "JNE": "101", "JLE": "110", "JMP": "111"
}

def clean_comments(lines):
    instr = []
    for line in lines:
        line = line.strip()
        if not line or line.startswith("//"):
            continue
        else:
            line = line.split("//")[0].strip()
            instr.append(line)
    return instr

def type_of_instr(instr):
    if instr.startswith('@'):
        return 'A'
    else:
        return 'C'

def decode_A(instr):
    global base_var_mem
    if '@' in instr:
        value = instr.split("@")[1]
        if(value.isdigit()):
            return value
        elif value in symbols:
            return symbols[value]
        elif value in var_symbols:
            return var_symbols[value]
        else:
            var_symbols[value] = base_var_mem
            print(f'assigned {base_var_mem} to {value}')
            base_var_mem += 1
            return var_symbols[value]

def decode_C(instr):
    dest_c = None
    comp_c = None
    jump_c = None
    if '=' in instr:
        parts = instr.split("=")
        dest_c = parts[0]
        instr = parts[1]
    
    if ';' in instr:
        parts = instr.split(";")
        comp_c = parts[0]
        jump_c = parts[1]
    else:
        comp_c = instr
        
    return dest_c, comp_c, jump_c  
    
def interpreter(input_file, output_file):
    value = None
    dest = None
    comp = None
    jump = None
        
    with open(input_file, 'r') as file:
        lines = clean_comments(file)
        lines = firstpass(lines)
        
    with open(output_file, 'w') as ofile:   
        for instr in lines:
            if instr:
                asm = ''
                instr_type = type_of_instr(instr)
                if(instr_type == 'A'):
                    asm += '0'
                    value = decode_A(instr)
                    value = format(int(value), '015b')
                    asm += value                
                        
                elif (instr_type == 'C'):
                    asm += '111'
                    dest, comp, jump = decode_C(instr)
                    asm += comp_table[comp]
                    asm += dest_table.get(dest, "000")
                    asm += jump_table.get(jump, "000")  
                    
                hex_asm =  format(int(asm, 2), "04X")
                print(hex_asm)             
                ofile.write(hex_asm + '\n')
            
def firstpass(input_file):
    instr_number = 0
    lines = []
    for line in input_file:
        if(line.startswith('(')):
            symbol = line.strip('()')
            var_symbols[symbol] = instr_number
        else: 
            instr_number += 1            
            lines.append(line)
    return lines
            
def main():
    if len(sys.argv) != 4 or sys.argv[2] != "-o":
        print("Usage: python ASSEMBLER.py input.asm -o output.hack")
        return
    input_filename = sys.argv[1]
    output_filename = sys.argv[3]
    if not (os.path.exists(input_filename)):
        print("Input file not found.")
        return
    interpreter(input_filename, output_filename)
        
if __name__ == "__main__":
    main()
