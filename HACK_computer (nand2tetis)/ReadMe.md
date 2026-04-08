## 1. Addition Program
```assembly
// Code
// Computes R0 = 2 + 3  (R0 refers to RAM[0])
@2
D=A
@3
D=D+A
@0
M=D
```
## Output
<img width="1891" height="570" alt="image" src="https://github.com/user-attachments/assets/345e9798-0de1-4269-8f12-95d7338bd24b" />

## 2. To find Maximum
```assembly
// Computes R2 = max(R0, R1)  (R0,R1,R2 refer to RAM[0],RAM[1],RAM[2])
// Usage: Before executing, put two values in R0 and R1.

  // D = R0 - R1
  @3
  D=A
  @R0
  M=D
  @2
  D=A
  @R1
  M=D
  @R0
  D=M
  @R1
  D=D-M
  // If (D > 0) goto ITSR0
  @ITSR0
  D;JGT
  // Its R1
  @R1
  D=M
  @OUTPUT_D
  0;JMP
(ITSR0)
  @R0
  D=M
(OUTPUT_D)
  @R2
  M=D
(END)
  @END
  0;JMP
```
## Output
<img width="1902" height="787" alt="image" src="https://github.com/user-attachments/assets/3d6bc2ca-e763-4048-bb99-86bc5e0cc213" />

## 3. Sum 1 to N program

```assembly
@10
D=A
@R0
M=D
@R0
D=M
@n
M=D
@i
M=1
@sum
M=0
(LOOP)
@i
D=M
@n
D=D-M
@STOP
D;JGT
@sum
D=M
@i
D=D+M
@sum
M=D
@i
M=M+1
@LOOP
0;JMP
(STOP)
@sum
D=M
@R1
M=D
(END)
@END
0;JMP
```
## Output:
<img width="1571" height="600" alt="image" src="https://github.com/user-attachments/assets/e7395446-2cab-4cab-bd6b-a591a2ffd7e0" />

## Reference: Nand2tetris
