from django.shortcuts import render
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
# Create your views here.

app_name = 'optimizer'

@csrf_exempt
def index(request):
    in_code = request.POST.get('in_code')
    out_code = "output code"
    print("Here : ",in_code)
    return render(request, 'optimizer/index.html',{'in_code':in_code,'out_code':out_code})
    # return HttpResponse("Hello, world. You're at the optimizer")

# def viewOptimizedCode(request):
#     in_code = request.POST.get('in_code')
#     print("Here : ",in_code)
#     return render(request, 'optimizer/index.html',{'in_code':in_code,'out_code':out_code})