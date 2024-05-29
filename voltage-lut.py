

C = 3300. / 4096

txt = ""
for i in range(4096):
    val = f"{i * C:.1f}"
    while(len(val) < 6):
        val = " " + val
    txt += val
    print(val)

mem = ""
for c in txt:
    mem += format(ord(c), "x") + "\n"

text_file = open("output.txt", "w")
text_file.write(txt)
text_file.close()

text_file = open("output.mem", "w")
text_file.write(mem)
text_file.close()