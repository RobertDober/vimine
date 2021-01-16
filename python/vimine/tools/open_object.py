class OpenObject():
    # def iteritems(self):
    #     try:
    #         return self.__dict__.iteritems()
    #     except AttributeError:
    #         return self.__dict__.items()

    # def items(self):
    #     return self.__dict__.items()

    # def keys(self):
    #     return self.__dict__.keys()

    # def __iter__(self):
    #     return self.__dict__.__iter__()

    def __setitem__(self, key, value):
        self.__setattr__(key, value)

    def __getitem__(self, key):
        return self.__getattr__(key)

    # def __getstate__(self):
    #     return self.__dict__

    # def __setstate__(self, d):
    #     self.__dict__.update(d)

    # def __delitem__(self, key):
    #     self.__dict__.__delitem__(key)

    def __getattr__(self, key):
        if self.__dict__.get(key) is None:
            raise KeyError
        return self.__dict__.get(key)

    def __setattr__(self, key, value):
        self.__dict__[key] = value

    # def __delattr__(self, key):
    #     self.__dict__.pop(key, None)

    def __repr__(self):
        return str(self.__dict__)

    def __eq__(self, rhs):
        if hasattr(rhs, '__dict__'):
            return self.__dict__ == rhs.__dict__

        return self.__dict__ == rhs

    def __ne__(self, rhs):
        return not self.__eq__(rhs)

    def __len__(self):
        return len(self.__dict__)
