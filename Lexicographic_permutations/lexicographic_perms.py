from typing import List, Any

def all_perms(coll:List) -> List[List]:
    if len(coll) == 0:
        return [[]]

    elif len(coll) == 1:
        return [coll]

    elif len(coll) == 2:
        return [coll, coll[::-1]]
    #
    perms = []

    for d in coll:
        coll_d = [x for x in coll if x != d]
        _perms = prepend_all(d, all_perms(coll_d))  # rec. call
        perms = [*perms, *_perms]

    return perms


def prepend_all(item:Any, perms:List[List]) -> List[List]:
    # this function has a side-effect
    return [[item, *perm] for perm in perms]
