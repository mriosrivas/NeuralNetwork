import numpy as np


def initialize_parameters_deep(layer_dims, k=16, precision='int32'):
    """

    :param precision: integer PRECISION of implementation
    :param layer_dims: python array (list) containing the dimensions of each layer in our network
    :param k: number of times a left shift is performed to the lsb to create a matrix of weights
    :return: parameters -- python dictionary containing parameters "W1", "b1", ..., "WL", "bL":
                    Wl -- weight matrix of shape (layer_dims[l], layer_dims[l-1])
                    bl -- bias vector of shape (layer_dims[l], 1)
    """
    np.random.seed(3)
    parameters = {}
    L = len(layer_dims)  # number of layers in the network

    for l in range(1, L):
        parameters['W' + str(l)] = np.random.randint(-1 << k, 1 << k, (layer_dims[l], layer_dims[l - 1])).astype(
            precision)
        parameters['b' + str(l)] = (np.zeros((layer_dims[l], 1))).astype(precision)

        assert (parameters['W' + str(l)].shape == (layer_dims[l], layer_dims[l - 1]))
        assert (parameters['b' + str(l)].shape == (layer_dims[l], 1))

    return parameters
