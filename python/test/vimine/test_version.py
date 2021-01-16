import unittest
from python.vimine import version
class TestVersion(unittest.TestCase):

    def test_version(self):
        self.assertEqual( version.vimine_py_version(), "0.1.0")
