import { allPerms } from './lexicographic-perms';

describe('Euler Project: Lexicographic permutations', () => {

  describe('Lexicographic permutations (LP) / Base Cases', () => {
    test('LP - base case 1', () => {
      expect(allPerms([])).toEqual([[]]);
    });

    test('LP - base case 2', () => {
      expect(allPerms([0])).toEqual([[0]]);
    });

    test('LP - base case 3', () => {
      expect(allPerms([1, 2])).toEqual([[1, 2], [2, 1]]);
    });
  });

  describe('Lexicographic permutations (LP) / Rec', () => {
    test('LP - rec 1', () => {
      expect(allPerms([true, false])).toEqual([[true, false], [false, true]]);
    });

    test('LP - rec 2: perms of 3 items', () => {
      expect(allPerms([1, 2, 3])).toEqual([[1, 2, 3], [1, 3, 2],
                                           [2, 1, 3], [2, 3, 1],
                                           [3, 1, 2], [3, 2, 1]]);
    });

    test('LP - rec 3: perms of 3 items', () => {
      expect(allPerms([1, 'a', "foo"])).toEqual([[1, 'a', "foo"], [1, "foo", 'a'],
                                                 ['a', 1, "foo"], ['a', "foo", 1],
                                                 ["foo", 1, 'a'], ["foo", 'a', 1]]);
    });

    test('LP - rec 4: perms of 4 items', () => {
      expect(allPerms([1, 2, 3, 4])).toEqual([[1, 2, 3, 4], [1, 2, 4, 3],
                                              [1, 3, 2, 4], [1, 3, 4, 2],
                                              [1, 4, 2, 3], [1, 4, 3, 2],
                                              [2, 1, 3, 4], [2, 1, 4, 3],
                                              [2, 3, 1, 4], [2, 3, 4, 1],
                                              [2, 4, 1, 3], [2, 4, 3, 1],
                                              [3, 1, 2, 4], [3, 1, 4, 2],
                                              [3, 2, 1, 4], [3, 2, 4, 1],
                                              [3, 4, 1, 2], [3, 4, 2, 1],
                                              [4, 1, 2, 3], [4, 1, 3, 2],
                                              [4, 2, 1, 3], [4, 2, 3, 1],
                                              [4, 3, 1, 2], [4, 3, 2, 1]]);
    });

    test('LP - rec 5: perms of 5 items', () => {
      expect(allPerms([1, 2, 3, 4, 5]).length).toEqual(120);
    });

    test('LP - rec 6: perms of 6 items', () => {
      expect(allPerms([1, 2, 3, 4, 5, 6]).length).toEqual(720);
    });

    test('LP - rec 7: perms of 7 items', () => {
      expect(allPerms([1, 2, 3, 4, 5, 6, 7]).length).toEqual(5040);
    });
    
    test('LP - rec 8: perms of 8 items', () => {
      expect(allPerms([1, 2, 3, 4, 5, 6, 7, 8]).length).toEqual(40320);
    });

    test('LP - rec 9: perms of 9 items', () => {
      expect(allPerms([1, 2, 3, 4, 5, 6, 7, 8, 9]).length).toEqual(362880);
    });
    
    test('LP - rec 10: perms of 10 items', () => {
      expect(allPerms([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]).length).toEqual(3628800);
    });
    // => RangeError: Maximum call stack size exceeded
    // npm config ls -l
    // 
    // env NODE_OPTIONS="--stack-size=1000" npm test
    // => node: --stack-size is not allowed in NODE_OPTIONS

    // node --v8-options | grep stack
    //  --stack-size (default size of stack region v8 is allowed to use (in kBytes))
    //    type: int  default: 984

  });
});
