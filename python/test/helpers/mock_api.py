from .random import * 
from python.vimine.tools.open_object import OpenObject


mocks = OpenObject() 
class MockAPI:
    # class functions
    # member functions
    def __init__(self):
        self.evaluations = OpenObject()
        self._init_evaluations()

    def _init_evaluations(self):
        mocks["buffer_number"] = make_unique_id("buffer_number")
        self.stub_eval("buffer_number()", mocks.buffer_number)

    def eval(self, command):
        # intentional potential for raise of IndexError
        return self.evaluations[command]

    def stub_eval(self, command, value):
        self.evaluations[command] = value

def delegate(to, *methods):
    def dec(klass):
        def create_delegator(method):
            def delegator(self, *args, **kwargs):
                obj = getattr(self, to)
                m = getattr(obj, method)
                return m(*args, **kwargs)
            return delegator
        for m in methods:
            setattr(klass, m, create_delegator(m))
        return klass
    return dec

@delegate('api', 'stub_eval')
class MockVIM:
    def __init__(self):
        self.api = MockAPI()

vim = MockVIM()
