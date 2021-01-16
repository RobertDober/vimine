import unittest
from python.vimine.tools.open_object import OpenObject

class TestOpenObject(unittest.TestCase):

    def setUp(self):
        self.oo = OpenObject()
        self.oo.predefined = 1

    def test_object_creation(self):
        self.assertTrue(isinstance(self.oo, OpenObject))

    def test_no_key(self):
        with self.assertRaises(KeyError):
            self.oo.no_such_key

    def test_set_key(self):
        self.oo.alpha = 1
        self.assertEqual(self.oo.alpha, 1)

    def test_reassignment(self):
        self.assertEqual(self.oo.predefined, 1)
        self.oo.predefined = 42
        self.assertEqual(self.oo.predefined, 42)

    def test_item_read_access(self):
        self.assertEqual(self.oo["predefined"], 1)

    def test_item_write_access(self):
        self.oo["beta"] = 2
        self.assertEqual(self.oo.beta, 2)
