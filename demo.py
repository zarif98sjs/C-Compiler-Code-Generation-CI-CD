
def optimizeCode():

    with open('code.asm', 'r') as readFile:
        with open('opt_new.asm', 'w') as writeFile:
            line_v = readFile.readlines()
            prev_line_token = []
            prevLineCmd = ""

            for i in range(0, len(line_v)):
                # print(line_v[i])
                curLine = line_v[i]
                curLine = curLine.replace('\n', '')
                cur_line_token = []

                if len(curLine) == 0:
                    continue

                if curLine[0] == ';':
                    writeFile.write(curLine+'\n')
                    continue

                token_v = curLine.split(' ')
                # print(token_v)

                if token_v[0] == "MOV":
                    if token_v[1] == "WORD":
                        cur_line_token = token_v[3].split(',')
                    else:
                        cur_line_token = token_v[1].split(',')

                    if prevLineCmd == "MOV":
                        if i > 0:
                            if cur_line_token[0] == prev_line_token[1] and cur_line_token[1] == prev_line_token[0]:
                                # do nothing
                                continue
                            else:
                                writeFile.write(curLine+'\n')
                        else:
                            writeFile.write(curLine+'\n')
                    else:
                        writeFile.write(curLine+'\n')

                    prev_line_token = cur_line_token
                else:
                    sz_token_v = len(token_v)
                    if sz_token_v >= 2:
                        if token_v[1] == "PROC":
                            writeFile.write('\n')

                    writeFile.write(curLine+'\n')
                    prev_line_token = []
                prevLineCmd = token_v[0]


optimizeCode()
