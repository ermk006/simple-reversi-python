import stone


class Evaluator:
    def eval(self, a_board, a_stone):
        pass


class MiddleEvaluator(Evaluator):
    """evaluator for the first to middle periods."""

    def eval(self, a_board, my_stone):
        _my_putpos = self._count_putpos(a_board, my_stone)
        _opp_putpos = self._count_putpos(a_board, stone.reverse(my_stone))
        _count_place = self._count_place(a_board, my_stone)
        _eval = _my_putpos - _opp_putpos + _count_place
        return _eval

    def _count_putpos(self, a_board, my_stone):
        _count = 0
        for x in range(1, 9):
            for y in range(1, 9):
                if a_board.possible_to_put_stone_at(my_stone, (x, y)):
                    _count += 1
        return _count

    def _count_place(self, a_board, mystone):
        _score = 0
        _corner = ((1,1), (1,8), (8,1), (8,8))
        _corner_point = 10
        _around = ((1,2), (2,1), (2,2), (1,7), (2,8), (2,7), (7,1), (8,2), (7,2), (7,8), (8,7), (7,7))
        _around_point = -10

        for _c in _corner:
          _s = a_board.get_at(_c)
          if _s == mystone:
            _score += _corner_point
        
        for _c in _around:
          _s = a_board.get_at(_c)
          if _s == _around:
            _score += _around_point
        return _score

class FinalEvaluator(Evaluator):
    """evaluator for the last period which evaluate the number of stones"""

    def eval(self, a_board, my_stone):
        _my_count = a_board.count_stones(my_stone)
        _opp_count = a_board.count_stones(stone.reverse(my_stone))
        _eval = _my_count - _opp_count
        return _eval
