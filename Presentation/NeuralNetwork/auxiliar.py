import numpy as np


def transform_data(x, sigmoid_decimal_bits=12, precision='int32'):
    """
    Function to transform data into integer format.

    :param x: input data
    :param sigmoid_decimal_bits: number of bits used for decimal values
    :param precision: integer PRECISION of implementation
    :return: x_int -- integer transformation of x by shifting right sigmoid_decimal_bits times
    """

    if precision != 'float':
        x_int = (x * 2 ** sigmoid_decimal_bits).astype(precision)
    else:
        x_int = x

    return x_int
