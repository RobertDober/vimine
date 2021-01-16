import unittest
import secrets
from python.yank_ring import *
from python.test.helpers.mock_api import vim

secret = secrets.token_hex(16)
vim.stub_eval("buffer_number()", secret)

class TestYankRingInit(unittest.TestCase):
    def test_init(self):
        yr = yank_ring_for_current_buffer(vim.api)
        yr1 = yr.yank_rings[yr.buf_num]
        self.assertEqual(yr, yr1)

    def test_empty_ring(self):
        yr = yank_ring_for_current_buffer(vim.api)
        self.assertEqual(yr.ring, [])

