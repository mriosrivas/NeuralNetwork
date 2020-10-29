import numpy as np


def sigmoid_table(extra_bits=4, sigmoid_decimal_bits=12, precision='int32'):
    """
    Sigmoid function table generator. This function maps an input of size EXTRA_BITS + sigmoid_decimal_bits
    into a sigmoid function of size sigmoid_decimal_bits.

    :param extra_bits: bits used to increment range of input values
    :param sigmoid_decimal_bits: number of bits used for decimal values
    :param precision: integer PRECISION of implementation
    :return: sigma -- floating point sigma values
            table -- integer sigma values
    """

    delta = 2 ** (-sigmoid_decimal_bits)
    table_size = 2 ** (extra_bits + sigmoid_decimal_bits)  # - 1

    z = np.zeros(table_size)

    for i in range(table_size):
        z[i] = i * delta

    sigma = 1 / (1 + np.exp(-z))
    sigma_int = (sigma * (2 ** sigmoid_decimal_bits - 1)).astype(precision)

    return sigma, sigma_int


def log_table(decimal_bits=12, precision='int32'):
    """
    Logarithmic function table generator. This function generates a log table with
    floating point input values 0 to 1 mapped into 0 and 2**DECIMAL_BITS.
    Output is signed of size DECIMAL_BITS.

    Table domain between:
    -2**(DECIMAL_BITS) and 2**(DECIMAL_BITS)-1

    Table range between: log(0.0000001) and log(1)

    :param decimal_bits: number of decimal bits to use
    :param precision: integer PRECISION of implementation
    :return: z -- array of numbers from 0 to 1 with an increment of 2**-DECIMAL_BITS
            log -- floating point calculation of log(z)
            log_int -- table of integer log values (signed decimal_bit size)
    """

    delta = 2 ** (-decimal_bits)
    table_size = 2 ** decimal_bits + 1

    z = np.zeros(table_size)
    log = np.zeros(table_size)

    for i in range(table_size):
        z[i] = i * delta

    log[1:] = np.log(z[1:])
    log[0] = np.log(0.0000001)

    log_int = (log * (2 ** decimal_bits)).astype(precision)

    return z, log, log_int


def generate_gradient_cross_entropy_table(AL, Y, decimal_bits=12, precision='int32'):
    """
    Auxiliary function to calculate cross entropy of AL and Y.

    :param AL: integer activation layer output value or predicted value.
    :param Y: integer Y value
    :param decimal_bits: number of decimal bits to use
    :param precision: integer PRECISION of implementation
    :return: cross entropy calculation of AL and Y in floating point representation
    """

    y = Y / (2 ** decimal_bits)
    al = AL / (2 ** decimal_bits)

    loss_gradient = -(np.divide(y, al) - np.divide(1 - y, 1 - al))

    return loss_gradient.astype(precision)


def get_cross_entropy_tables(decimal_bits=12, precision='int32'):
    """

    :param precision: integer PRECISION of implementation
    :param decimal_bits: number of decimal bits to use
    :return: cross_entropy_table_1 -- integer cross entropy table with Y=0
            cross_entropy_table_2 -- integer cross entropy table with Y=2**DECIMAL_BITS
    """

    al = np.arange(0, 2**decimal_bits)
    vector_gradient_cross_entropy = np.vectorize(generate_gradient_cross_entropy_table)

    cross_entropy_table_1 = vector_gradient_cross_entropy(al, 0, decimal_bits, precision)
    cross_entropy_table_2 = vector_gradient_cross_entropy(al, 2**decimal_bits, decimal_bits, precision)

    cross_entropy_table_1[0] = cross_entropy_table_1[1]
    cross_entropy_table_2[0] = cross_entropy_table_2[1]

    return cross_entropy_table_1, cross_entropy_table_2
