import unittest

from lexicographic_perms import all_perms, prepend_all

class LexicographicPerms(unittest.TestCase):
    def test_base_case_1(self):
        self.assertEqual(all_perms([]), [[]])

    def test_base_case_2(self):
        self.assertEqual(all_perms([0]), [[0]])

    def test_base_case_3(self):
        self.assertEqual(all_perms([1, 2]), [[1, 2], [2, 1]])

    def test_rec_call_3perms_1(self):
        self.assertEqual(all_perms([1, 2, 3]), [
            [1, 2, 3], [1, 3, 2], [2, 1, 3],
            [2, 3, 1], [3, 1, 2], [3, 2, 1]
        ])

    def test_rec_call_3perms_2(self):
        self.assertEqual(all_perms([1, 'a', 'foo']), [
            [1, 'a', "foo"], [1, "foo", 'a'],
            ['a', 1, "foo"], ['a', "foo", 1],
            ["foo", 1, 'a'], ["foo", 'a', 1]
        ])

    def test_rec_call_4perms(self):
        self.assertEqual(all_perms([1, 2, 3, 4]),
                         [
                            [1, 2, 3, 4], [1, 2, 4, 3],
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
                            [4, 3, 1, 2], [4, 3, 2, 1],
                         ])

    def test_rec_call_5perms(self):
        self.assertEqual(len(all_perms(list(range(0, 6)))), 720)

    def test_rec_call_6perms(self):
        self.assertEqual(len(all_perms(list(range(0, 7)))), 5040)

    def test_rec_call_9perms(self):
        self.assertEqual(len(all_perms(list(range(0, 9)))), 362_880)

    def test_rec_call_10perms(self):
        self.assertEqual(len(all_perms(list(range(0, 10)))), 3_628_800)

    def test_prepend_all_1(self):
        self.assertEqual(prepend_all(3, [[]]), [[3]])

    def test_prepend_all_2(self):
        self.assertEqual(prepend_all(3, [[1, 2], [2, 1]]), [[3, 1, 2], [3, 2, 1]])

    def test_prepend_all_3(self):
        self.assertEqual(prepend_all(4, [[1, 2, 3], [1, 3, 2],
                                         [2, 1, 3], [2, 3, 1],
                                         [3, 1, 2], [3, 2, 1]]),
                         [[4, 1, 2, 3], [4, 1, 3, 2],
                          [4, 2, 1, 3], [4, 2, 3, 1],
                          [4, 3, 1, 2], [4, 3, 2, 1]])

if __name__ == "__main__":
    unittest.main()

# test_base_case_1 (__main__.LexicographicPerms) ... ok
# test_base_case_2 (__main__.LexicographicPerms) ... ok
# test_base_case_3 (__main__.LexicographicPerms) ... ok
# test_prepend_all_1 (__main__.LexicographicPerms) ... ok
# test_prepend_all_2 (__main__.LexicographicPerms) ... ok
# test_prepend_all_3 (__main__.LexicographicPerms) ... ok
# test_rec_call_10perms (__main__.LexicographicPerms) ... ok
# test_rec_call_3perms_1 (__main__.LexicographicPerms) ... ok
# test_rec_call_3perms_2 (__main__.LexicographicPerms) ... ok
# test_rec_call_4perms (__main__.LexicographicPerms) ... ok
# test_rec_call_5perms (__main__.LexicographicPerms) ... ok
# test_rec_call_6perms (__main__.LexicographicPerms) ... ok
# test_rec_call_9perms (__main__.LexicographicPerms) ... ok

# ----------------------------------------------------------------------
# Ran 13 tests in 14.105s
