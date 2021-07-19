from django.shortcuts import render
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
# Create your views here.
import subprocess

app_name = 'optimizer'

@csrf_exempt
def index(request):
    in_code = request.POST.get('in_code')
    writeOutputNormal(in_code)

    with open('code.asm', 'r') as file:
        data = file.read().replace('\n', '\n')
    out_code = data
    # print("Here : ",in_code)
    return render(request, 'optimizer/index.html',{'in_code':in_code,'out_code':out_code})
    # return render(request, 'optimizer/test.html')
    # return HttpResponse("Hello, world. You're at the optimizer")


def writeOutputNormal(in_code):

    if in_code != None:
        with open("input.c","w") as f:
            f.write(in_code)

        subprocess.check_output(["./a.out" ,"input.c"])


    



# def viewOptimizedCode(request):
#     in_code = request.POST.get('in_code')
#     print("Here : ",in_code)
#     return render(request, 'optimizer/index.html',{'in_code':in_code,'out_code':out_code})