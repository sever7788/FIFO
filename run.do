# Установите FPGA устройство для синтеза
# Этот шаг необходим и команда должна быть выполнена перед любыми другими действиями
setup_fpga -tech VIRTEX7 -part xc7v585t

# Создайте и сопоставьте библиотеку 'work'
hlib create ./work
hlib map work ./work

# Компиляция источников RTL в библиотеку 'work' с использованием SystemVerilog
# Обратите внимание на флаг -sv, который указывает на использование SystemVerilog
hcom -lib work -sv design.sv

# Установите выходные файлы синтеза (EDF и VM)
setoption output_edif "design.synth.edf"
setoption output_verilog "design.synth.vm"
setoption output_schematicsvg "diag.svg"

# Выполните синтез верхнего модуля с включенной библиотекой 'work'
hsyn -L work FIFO