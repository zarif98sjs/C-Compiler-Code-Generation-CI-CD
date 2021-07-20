from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
# Create your views here.
from .models import Code
import dropbox

app_name = 'optimizer'

dbx = dropbox.Dropbox('sl.A1BNaC4Fk7O_Uq-VF3s6KvZBwCyjC9TJmGqht2EbjM-HmZ8uUuTaMM49fpb9kPl5gkIZecSrTvFjwpRQFZ8cJVva9kdPFs50QdXKPES1C7asoxr7JH1Canj24Nm52bR07qJhI7A')


def createFile(fileString, fileName):
    dbx.files_upload(fileString, '/'+fileName, mute=True, mode=dropbox.files.WriteMode.overwrite)

# with open('input.c',"rb") as f:
#     # data = f.readlines()
#     createFile(f.read(),'temp.txt')


@csrf_exempt
def index(request):
    code = Code("", "", "")
    code.in_code = request.POST.get('in_code')

    if code.in_code is not None:
        # createFile(str.encode(code.in_code), 'in.txt')
        code.writeOutputNormal()
        code.optimizeCodeFromFile('/tmp/code.asm')

        with open('/tmp/opt_new.asm', 'r') as file:
            data = file.read().replace('\n', '\n')
        code.opt_code_asm = data
        # print("Here : ",in_code)
        print("inside")
    else:
        code.in_code = ""
    return render(request, 'optimizer/index.html', {'in_code': code.in_code, 'out_code': code.opt_code_asm})
    # return render(request, 'optimizer/test.html')
    # return HttpResponse("Hello, world. You're at the optimizer")
