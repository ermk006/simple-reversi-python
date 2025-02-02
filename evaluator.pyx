import stone


cdef class Evaluator:
    cpdef int eval(self, object a_board, int a_stone):
        pass


cdef class MiddleEvaluator(Evaluator):
    """evaluator for the first to middle periods."""

    cpdef int eval(self, object a_board, int my_stone):
        cdef int _my_putpos = self._count_putpos(a_board, my_stone)
        cdef int _opp_putpos = self._count_putpos(a_board, stone.reverse(my_stone))
        cdef int _eval = _my_putpos - _opp_putpos + self._eval_corners(a_board, my_stone)
        return _eval

    cdef int _count_putpos(self, object a_board, int my_stone):
        cdef int _count = 0
        cdef int x, y
        for x in range(1, 9):
            for y in range(1, 9):
                if a_board.possible_to_put_stone_at(my_stone, (x, y)):
                    _count += 1
        return _count

    cdef int _eval_corners(self, object a_board, int my_stone):
        cdef int _opp_stone = stone.reverse(my_stone)
        cdef int _point = 0
        cdef ((int, int), (int, int), (int, int), (int, int)) _corners = ((1, 1), (1, 8), (8, 1), (8, 8))
        cdef int _corner_point = 10
        cdef (int, int) _c
        cdef int _s
        for _c in _corners:
            _s = a_board.get_at(_c)
            if _s == my_stone:
                _point += _corner_point
            elif _s == _opp_stone:
                _point -= _corner_point
        return _point


cdef class FinalEvaluator(Evaluator):
    """evaluator for the last period which evaluate the number of stones"""

    cpdef int eval(self, object a_board, int my_stone):
        cdef int _my_count = a_board.count_stones(my_stone)
        cdef int _opp_count = a_board.count_stones(stone.reverse(my_stone))
        cdef int _eval = _my_count - _opp_count
        return _eval
