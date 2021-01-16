import secrets

def make_unique_id(name, size=16):
    return "%s%s" % (name, secrets.token_hex(size))
