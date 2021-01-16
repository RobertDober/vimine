_yank_rings = {}
def yank_ring_for_current_buffer(api):
    _yr = _yank_rings.get(api.eval("buffer_number()"))
    if _yr:
        return _yr
    else:
        _yr = _YankRing(api)
        _yank_rings[api.eval("buffer_number()")] = _yr
        return _yr

class _YankRing:

    def __init__(self, api):
        self.api     = api
        self.buf_num = api.eval("buffer_number()")
        _yank_rings[self.buf_num] = self
        self.yank_rings = _yank_rings
        self.ring = []
