import unittest

from python.vimine.nvimapi import NvimAPI
from python.test.helpers.mock_api import vim, mocks

api = NvimAPI(vim)


class TestNVimApiEval(unittest.TestCase):
    def test_correct_buffer_number(self):
        self.assertEqual(api.eval("buffer_number()"), mocks.buffer_number)
