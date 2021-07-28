
# from subprocess import *
# output = Popen(["test4.exe"], stdout=PIPE).communicate()[0].decode('utf-8')
# print(output)
# import subprocess
# # output = subprocess.check_output(["test4.exe"]).decode('utf-8')
# # print(output)

# subprocess.check_output(["./tmp/./a.out", "input.c"])


import io
from ppci.api import cc, link
source_file = io.StringIO("""
int printf(char* fmt) { }
void main() {
printf("Hello world!\n");
}
""")
obj = cc(source_file, 'arm')
print(obj.get_section('code').data)
obj = link([obj])
print(obj.get_section('code').data)
