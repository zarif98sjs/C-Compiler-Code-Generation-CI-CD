from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
# Create your views here.
from .models import Code

app_name = 'optimizer'


@csrf_exempt
def index(request):
    code = Code("", "")
    code.in_code = request.POST.get('in_code')
    code.writeOutputNormal()
    code.optimizeCodeFromFile('./tmp/code.asm')

    with open('./tmp/opt_new.asm', 'r') as file:
        data = file.read().replace('\n', '\n')
    code.opt_code = data
    # print("Here : ",in_code)
    return render(request, 'optimizer/index.html', {'in_code': code.in_code, 'out_code': code.opt_code})
    # return render(request, 'optimizer/test.html')
    # return HttpResponse("Hello, world. You're at the optimizer")
