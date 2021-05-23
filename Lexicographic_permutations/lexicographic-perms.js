//
// Lexicographic permutations - Problem 24
//

export const allPerms = (coll) => {
  if (coll.length == 0) return [[]];
  if (coll.length == 1) return [coll];

  if (coll.length == 2) return [[...coll], coll.reverse()];
  // => [...coll] make a copy - coll.reverse() has side effect

  if (coll.length == 10) {
    // from 10 we have:
    // => RangeError: Maximum call stack size exceeded
    //
    const n = coll.length;
    let perms = allPermsR(coll.slice(0, n - 1));
    let xperms = [];
    
    for (let perm of perms) {
      for (let ix = 0; ix < perm.length; ix++) {
        let _perm = [...perm];
        _perm.splice(ix, 0, n); 
        xperms.push(_perm);
      }
      // insert in last position
      let _perm = [...perms[n-1]];
      _perm.splice(n-1, 0, n);
      xperms.push(_perm);
    }

    return xperms;  // order will be different from what is expected
    //              // a simple sort won't generate the expected order either...
  }
  else {
    return allPermsR(coll)
  }
}


const allPermsR = (coll) => {
  if (coll.length == 2) return [[...coll], coll.reverse()];
  // => [...coll] make a copy - coll.reverse() has side effect

  let perms = []

  for (let d of coll) {
    const coll_d = coll.filter((x) => x != d);
    const _perms = prependAll(d, allPermsR(coll_d));
    perms.push(..._perms)
  }

  return perms;
}

const prependAll = (item, perms) => {
  for (let perm of perms) {
    perm.unshift(item);
  }

  return perms;
}
