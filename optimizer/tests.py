from django.test import TestCase
from . models import Code


class ModelTesting(TestCase):

    def setUp(self):
        self.code = Code("", "", "")
        line_v = ["MOV WORD PTR [bp-20],AX", "MOV AX,[bp-20]"]
        self.code.optimizeCode(line_v)

        with open('/tmp/opt_new.asm', 'r') as file:
            data = file.read().replace('\n', '\n')
        self.code.opt_code_asm = data

    def test_post_model(self):
        self.assertEqual(self.code.opt_code_asm, "MOV WORD PTR [sp-20],AX\n")
