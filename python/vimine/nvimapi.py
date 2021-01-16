class NvimAPI():
    def __init__(self, api):
        self.api = api
    def eval(self, command):
        return self.api.eval(command)
