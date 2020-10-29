import numpy as np


def gradient_cross_entropy_int_table(AL, Y, table_1, table_2, sigmoid_decimal_bits=12, precision='int32'):
    """
    Function that implements the cross entropy calculation of AL and Y. Since this is a classification problem with
    two outputs, Y can have values of 0 and 1.

    :param precision: integer PRECISION of implementation
    :param AL: activation value to calculate gradient cross entropy
    :param Y: expected value
    :param table_1: cross entropy table where Y is equal to zero generated bu using function get_cross_entropy_tables()
    :param table_2: cross entropy table where Y is equal to one generated bu using function get_cross_entropy_tables()
    :param sigmoid_decimal_bits: number of bits used for decimal values
    :return: dAL -- matched value of table_1 or table_2 depending on Y and AL
    """
    if AL > 2 ** sigmoid_decimal_bits - 1:
        AL = 2 ** sigmoid_decimal_bits - 1
    elif AL < -2 ** sigmoid_decimal_bits:
        AL = -2 ** sigmoid_decimal_bits

    if Y == 0:
        dAL = table_1[AL]
    elif Y == 2**sigmoid_decimal_bits:
        dAL = table_2[AL]

    return (dAL<<sigmoid_decimal_bits).astype(precision)


def cross_entropy_int(AL, Y, log_table, sigmoid_decimal_bits=12, precision='int32'):
    """

    :param AL: activation value to calculate cross entropy
    :param Y: expected value
    :param log_table: logarithm table generated by using function log_table()
    :param sigmoid_decimal_bits: number of bits used for decimal values
    :param precision: integer PRECISION of implementation
    :return: cross entropy loss calculation
    """
    if AL > 2 ** sigmoid_decimal_bits - 1:
        AL = 2 ** sigmoid_decimal_bits - 1
    elif AL < -2 ** sigmoid_decimal_bits:
        AL = -2 ** sigmoid_decimal_bits

    loss = -(Y * log_table[AL] + (2 ** sigmoid_decimal_bits - Y) * log_table[2 ** sigmoid_decimal_bits - AL])
    # return np.squeeze(loss).astype(PRECISION) >> sigmoid_decimal_bits
    return (np.squeeze(loss) >> sigmoid_decimal_bits).astype(precision)


# def gradient_cross_entropy_int(AL, Y, sigmoid_decimal_bits=12, PRECISION='int32'):
#     # if(AL==0 or AL==4096):
#     #    print('Division by zero error. AL={}'.format(AL))
#
#     # loss_gradient = -(np.divide(Y, AL) - np.divide(2**sigmoid_decimal_bits - Y, 2**sigmoid_decimal_bits - AL))
#     loss_gradient = -(np.divide(Y, AL) - np.divide(2 ** sigmoid_decimal_bits - Y, 2 ** sigmoid_decimal_bits - AL))
#     return loss_gradient.astype(PRECISION) << 12